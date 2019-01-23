;hello world


section   .text ;define start of code section

global  _start ;make main function callable



section   .data ;define start of data section


msg db        "Hello World in x86 Assembly on OSX",0xa ;string variable called msg, terminated with carriage return
len   equ $ - msg ;size of msg in bytes


_syscall: ;define kernel function called
        int       0x80 ; make system call 
        ret ;return
_start: ;linker entry point

        push dword len ;push the length on the string onto the stack
        push dword msg ;push the contents of msg onto the stack

        push dword 1   ;push file descriptor

        mov eax, 0x4   ;store syscall number in EAX register 0x4 = sys_write
        call _syscall  ; call the syscall function 

        add esp, 12    ; clear the stack 

        push dword 0   ; push the exit code onto the stack
        mov eax, 0x1   ; store syscall number in EAX register 0x1 = sys_exit
        call _syscall  ; call the syscall function

