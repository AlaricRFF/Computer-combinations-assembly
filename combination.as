        lw	0	1	n
        lw      0       2       r
        lw      0       4       Caddr	load combination function address
        jalr    4       7		call function
        halt
reNsp	lw	0	4	neg1	reg4 = -1
	add	4	2	2	r -- (restore r here)
	add	0	1	3	return n to reg3
	jalr	7	4		return
reN	add	0	1	3	return n from PREVIOUS function call
	jalr	7	4		return
re1	lw	0	3	pos1 	return 1 if n == 0
	jalr	7	4		return
comb	lw	0	4	pos1	reg4 = 1
	beq	1	2	re1	if n == r, return 1
	beq	2	4	reN  	if r == 1, return n
	beq	1	0	re1	if n == 0, return 1
	beq	2	0	re1	if r == 0, return 1
	add	4	2	2	r ++ (will restore that)
	beq	1	2	reNsp	n == r + 1, return n
	lw	0	4	neg1	reg4 = -1
	add	4	2	2	r -- (restore here is not entering beq)
	lw	0	4	pos1	reg4 = 1
	sw	5	7	Stack	store return address to stack
	add 	4	5	5	stack pointer(reg5) ++
	sw	5	2	Stack	store r
	add 	4	5	5	stack pointer(reg5) ++
	sw	5	1	Stack	store n
	add 	4	5	5	stack pointer(reg5) ++
	sw	5	6	Stack	store local sum reg6 into the stack
	add	4	5	5	stack pointer(reg5) ++
	lw	0	4	neg1	reg4 = -1
	add	4	1	1	n --
	lw	0	4	Caddr	reg4 = Caddr
	jalr	4	7		call comb(n-1,r), return in reg3
	add	0	3	6	reg6 = comb(n-1,r)
	lw	0	4	neg1	reg4 = -1
	add	4	2	2	r -- (do this when reg4 = -1) [NO NEED TO RESTORE n!! n has already been reduced!]
	lw	0	4	Caddr	reg4 = Caddr
	jalr	4	7		call comb(n-1,r-1), return in reg3
	add	3	6	3	reg3 = comb(n-1,r) + comb(n-1,r-1)
	lw	0	4	neg1	reg4 = -1
	add	4	5	5	stack pointer(reg5) --
	lw	5	6	Stack	restore reg6, which is the caller current sum
	add	4	5	5	stack pointer(reg5) --
	lw	5	1	Stack	restore n
	add	4	5	5	stack pointer(reg5) --
	lw	5	2	Stack	restore r
	add	4	5	5	stack pointer(reg5) --
	lw	5	7	Stack	reg7 retains return address
	jalr	7	4		go back to line 4 <end of recursion>
n       .fill	7
r       .fill	0
Caddr   .fill	comb
neg1	.fill	-1
pos1	.fill	1
Stack   .fill	0
