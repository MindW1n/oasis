_floatingPointExceptionHandler:
    section .data
        .floatingPointException db "x87 Floating point exception occured!", 0
    
    section .text
        mov rsi, .floatingPointException
        call _print
        jmp _haltMachine