_pageFaultInterruptHandler:
    section .data
        .pageFault db "Page fault occured!", 0
    
    section .text
        mov rsi, .pageFault
        call _print
        jmp _haltMachine