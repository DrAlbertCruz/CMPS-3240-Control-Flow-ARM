# CMPS 3240 Lab: Control of flow with ARM

## Objectives

During this lab you will:

* Use `gcc` to assemble and link ARM code
* Use `stdio` `printf()` from ARM
* Become introduced to control of flow with ARM

## Prerequisites

This lab assumes you have read or are familiar with the following topics:

* Control of flow (textbook's discussion of control of slow with MIPS is sufficient)
* Use of C-style `printf()`
* Iterative factorial
* Iterative Fibonacci

Please study these topics if you are not familiar with them so that the lab can be completed in a timely manner.

## Requirements

The following is a list of requirements to complete the lab. Some labs can completed on any machine, whereas some require you to use a specific departmental teaching server. You will find this information here.

### Software

We will use the following programs:

* `gcc`
* `git`
* `gdb`

### Compatability

This lab requires the departmental ARM server. It will not work on `odin.cs.csubak.edu`, `sleipnir.cs.csubak.edu`, other PCs, etc. that have x86 processors. It may work on a Raspberry Pi or similar system on chip with ARM, but it must be ARMv8-a.

| Linux | Mac | Windows |
| :--- | :--- | :--- |
| Limited | No | No |


## Background

This lab will cover the topic of control of flow. Under normal circumstances, the processor will continue to execute your user program line-by-line until it hits the `svc` operation to exit the process. In a previous lab, we used a software interrupt to hand over control to the supervisor process with `svc`. When it was done, it would resume executing your code on the following line. Considering our user process, there are generally two ways to alter the control of flow--that is, executing some line other than the following one. In C-style code it would look like this:

```c
if (expr)
	// Block if expr is True
else
	// Block if expr is False
```

If you've read the textbook and are somewhat familiar with MIPS branching, a branch operation is carried out like so:

```mips
beq $a0, $t0, target
# Block if expr is False
...
target:
# Block if expr is True
...
```

However, branching in ARM is somewhat like x86. When you want to execute a block of code conditionally, you need to set up the math for the expression with a separate instruction, often `cmp`:

```arm
cmp x0, x1
beq target
# Block if expr is False
...
target:
# Block if expr is True
...
```

`cmp` executes a subtraction: `x0` - `x1`. Like arithmetic, the second operand can be an immidiate value. There is also `cmn` which adds the two arguments. A separate register, called the flag register `cspr` (Current Status Processor Register), sets certain bits in the register based on the result of the operation performed in `cmp`. It records the following results:

* The N flag is set by an instruction if the result is negative. This assumes two's compliment and checks the most significant bit.
* The Z flag is set if the result of the is zero.
* The C flag is set if the result of an unsigned operation overflows the register. 
* The V flag is set if the result of a signed operation overflows the register. 

For convienience, you do not need to implement operations to check specific bits in the `cspr` register. There are a separate set of operations that strongly resemble the MIPS operations:

| Instruction | Explanation |
| --- | --- |
| b target | Unconditional branch |
| beq target | Branch when Z = 1 |
| bne target | Branch when Z = 0 |
| bmi target | Branch when N = 1 |
| bpl target | Branch when N = 0 |
| blt target | Branch when N != V |
| ble target | Branch when Z = 1 or N != V |
| bgt target | Branch when Z = 0 and N = V |
| bge target | Branch when Z = 1 or N !=V |
| bl target | Branch unconditionally and store return address |
| bx R | Return from function call, to the address specified in register R |

This is a brief explanation of branching that should be sufficient for the lab. It does not explain some advanced concepts:

* You don't actually need `cmp`, if you tack on a `s` at the end of an arithmetic instruction it will trigger the flag register.
* There are some `cmp` aliases that will also cause a branch
* Single instructions can be conditional

But, these advanced concepts are not needed for this lab. If you want to read more, read this reference.<sup>1</sup>

### Example Code

The code in this repository gives two examples: 

1. `count.s` which counts up to 100 using a pre-test loop.
2. `fact.s` which displays the factorial of 7 (7!).

There are some major differences between this lab and the previous lab that should be noted:

* We are using `gcc` to assemble and link the binary. 
* This lets us use `printf()` from `stdio` by inserting the instruction `.extern printf` in the code.
* `gcc` starts at `main`, not `_start`.

Study these examples before proceeding.

## Approach

Start by cloning this repository:

```shell
$ git clone https://github.com/DrAlbertCruz/CMPS-3240-Control-Flow-ARM.git
...
$ cd CMPS-3240-Control-Flow-ARM
```

The `make` file includes targets for the examples, just call `make` from the command line. 

Your task is to implement code that prints the first 10 Fibonacci numbers. It should do this iteratively. The code for this in C-language is as follows:

```c
int a = 0;
int b = 1;

for(i = 2 ; i <= n ; i++ )
{
    temp = a + b;
    a = b;
    b = temp;
}

printf( "%d\n", b )
```

You should code this as original ARM code. Do not use `gcc` to assemble the code for you.

## Check off

Demonstrate that your code works to the instructor, and let them inspect your ARM code.

### References

<sup>1</sup>ftp://www.cs.uregina.ca/pub/class/301/ARM-control/lecture.html
