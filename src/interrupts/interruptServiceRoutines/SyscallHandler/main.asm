_syscallHandler:
	call [syscallTable + rax * 8]
	iretq

syscallTable dq _sysRead, _print
