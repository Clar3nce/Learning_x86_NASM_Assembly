;calc.asm
;trying to create a basic calculator in x86 assembly



section .text

    global _start


section .data
    
    num_one: times 32 db 0 ; allocate buffer of 32 bytes in memory to store first number of sum
    num_two: times 32 db 0 ; allocate buffer of 32 bytes in memory to store sencond number of sum
    result:  times 64 db 0 ; allocate buffer of 64 bytes in memory to store total of sum



    info db       "This is a basic calculator that will produce the sum of two inputs.",0xa ; the info splash screen displayed at start of execution
    inf_len   equ $ - info ; size of info message in bytes
    
    in_f db       "Enter First Number: "  ; display input first number message
    in_f_len equ $ - in_f ; size of in_f in bytes

    in_s db       "Enter Second Number: " ; display input second number message 
    in_s_len equ $ - in_s ; size of in_s in bytes;

    sum  db       "The Reuslt of the two numbers is: ",0xa; display the output
    sum_len  equ $- sum; size of out string in bytes
    

_syscall:  ; declare kernel syscall 
    int       0x80 ; make system _syscall
    ret    ; return 


_info:
   push dword inf_len ; push size of info message onto stack 
   push dword info    ; push info message onto the stack
   push dword 1
   mov  eax, 0x4      ; move 0x4 into EAX 0x4 = SYS_WRITE
   call _syscall      ; call sys_write with the values on the stack as arguments 
   add  esp, 12       ; clear the last 12 bytes from the stack 
   push dword 0       ; push exit code 0 onto the stack
   mov  eax, 0x1      ; move 0x1 into EAX 0x1 = SYS_EXIT
   call _syscall      ; call SYS_EXIT by using _syscall function with EAX containing the syscall number 

_read_first_number:
   push dword in_f_len ; push size of in_f messgae onto the stack
   push dword in_f     ; push in_f message onto the stack 
   push dword 1        ; push file descriptor onto the stack
   mov  eax, 0x4       ; move 0x4 into EAX 0x4 = SYS_WRITE
   call _syscall       ; call SYS_WRITE using syscall function 
   add  esp, 12        ; clear last 12 bytes of the stack

   mov  edx, 32       ; move the maximum input length into EDX
   mov  ecx, num_one  ; move the buffer to receive the input into ECX
   mov  ebx, 0        ; move the file descriptor value into EBX
   mov  eax, 0x3      ; move 0x3 into EAX 0x3 = SYS_READ
   call _syscall      ; call SYS_READ by using _syscall function with EAX containing the syscall number
   cmp  eax, 0        ; compare EAX to 0 to determine if all input data has been received
   add  esp, 15
   jle  read_second_number ; jump to reading the second number if EAX = 0
   

   push dword in_f_len
   push dword in_f
   push dword 1
   mov  eax, 0x4
   call _syscall
   ; continue from here 


_read_second_number: 
   push dword in_f_len ; push size of in_f messgae onto the stack
   push dword in_f     ; push in_f message onto the stack 
   push dword 1        ; push file descriptor onto the stack
   mov  eax, 0x4       ; move 0x4 into EAX 0x4 = SYS_WRITE
   call _syscall       ; call SYS_WRITE using syscall function 
   add  esp, 12        ; clear last 12 bytes of the stack

   mov  edx, 32       ; move the maximum input length into EDX
   mov  ecx, num_two  ; move the buffer to receive the input into ECX
   mov  ebx, 0        ; move the file descriptor value into EBX
   mov  eax, 0x3      ; move 0x3 into EAX 0x3 = SYS_READ
   call _syscall      ; call SYS_READ by using _syscall function with EAX containing the syscall number
   cmp  eax, 0        ; compare EAX to 0 to determine if all input data has been received 






_start:
   call _info ; call the info function 
