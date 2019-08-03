# Code to print out factorial of 7 (7!) with a pre-test loop.
.text
# Command to instruct 'gcc' to import stdlib 'printf'
.extern printf

# 'gcc' will start at main, not _start
.global main
main:
### 	INITIALIZE VARIBLES 		###
# Counter
mov	x20, #7
# Value to print. Preload with highest multiplicand.
mov 	x19, x20

### 	CODE START 			###
_looptop:
# Loop exit code. We will decrement 7 one-by-one at the end of the loop. If 
# we hit 1, then quit.
cmp	x20, #1
beq	_exit
# Start of the loop body code. Multiply x19 with 'n-1'.
sub 	x20, x20, #1
mul	x19, x19, x20
# End of the loop body. Jump to _looptop.
b _looptop

_exit:
# Call to printf(). Printf expects arguments in order starting from x0 to x2.
# This is the start of the loop body.
ldr 	x0, =string1
mov 	x1, x19
bl 	printf
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
