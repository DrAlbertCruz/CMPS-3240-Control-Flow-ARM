# Code to print out numbers from 1 to 100 using a post-test loop.
.text
# Command to instruct 'gcc' to import stdlib 'printf'
.extern printf

# 'gcc' will start at main, not _start
.global main
main:
### 	INITIALIZE VARIBLES 		###
# Value to print
mov 	x19, 0x0
# Counter
mov	x20, #100

### 	CODE START 			###
_looptop:
# Call to printf(). Printf expects arguments in order starting from x0 to x2.
# This is the start of the loop body.
ldr 	x0, =string1
mov 	x1, x19
bl 	printf
# This is the end of the loop body, and what follows is the loop test. If the
# value does not meet the exit conditions, jump back to _looptop. I put a
# breakpoint _a1 here in case you wanted to see the execution step by step.
_a1:
adds 	x19, x19, #1
cmp	x19, x20
bne	_looptop

_exit:
# Exit is 'svc' with code 93. Return 0 thru x0
mov x8, #93
mov x0, #0
svc #0

### 	STATIC VARIABLE SECTION 	###
.data
# Printf string for printing a single character. %d is a single integer.
.global string1
string1:
	.ascii	"%d\n"
