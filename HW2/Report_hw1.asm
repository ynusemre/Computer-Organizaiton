.data
	# i want to test my code with huge array, hopely it work
	Arr1: .word  0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15   	# Array1
	n1: .word   16								#lenght of array
	
	Arr2: .word  3, 10, 7, 9, 4, 11   			# Array2
	n2: .word   6                                         #lenght of array
	
	Arr3: .word  10, 22, 9, 33, 21, 50, 41, 60, 80   	# Array3
	n3: .word   9                                         #lenght of array
	
	Arr4: .word  0, 1, 0, 3, 2, 3    			# Array4
	n4: .word   6                                         #lenght of array
	
	Arr5: .word  2, 3, 3, 3, 3, 3, 3    			# Array5
	n5: .word   7                                         #lenght of array
	
	Arr6: .word  10,11,2,5,3,7,58,78   			# Array6
	n6: .word   8                                         #lenght of array
	                                                     
	arr: .space 64  							   # hold the biggest value of arr2 array's column
	arr2: .space 64								    # hold the SUBARRAYS	
	arr3: .space 64								   #hold the longest insceasing sub sequence
	length: .space 64   							#length array using for the longest sub sequence size	
	
	newLine: .asciiz "\n"                                                      # For new line
	message: .asciiz " "						            # For White space
	
	message2: .asciiz "Sub Sequences : \n "
	
	message3: .asciiz " ] , Size =  "
	message4: .asciiz "candidate sequence : [ "
	
	
	M1: .asciiz "Array 1 :  [ 0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15 ] \n" 
	M2: .asciiz "Array 2 :  [ 3, 10, 7, 9, 4, 11 ] \n"
	M3: .asciiz "Array 3 :  [ 10, 22, 9, 33, 21, 50, 41, 60, 80 ] \n"
	M4: .asciiz "Array 4 :  [ 0, 1, 0, 3, 2, 3 ] \n"
	M5: .asciiz "Array 5 :  [ 2, 3, 3, 3, 3, 3, 3 ] \n"
	M6: .asciiz "Array 6 :  [ 10,11,2,5,3,7,58,78 ] \n"
	
	fout:   .asciiz "testout1.txt"      				# filename for output1
	
.text
	
 	main:	
 	# How to find longest sub sequence ?
 	#arr2 keeps the subseries in each control and is stored in arr.
 	#In each loop, the elements in arr2 are compared with the elements in arr, and a larger value in arr2 is put into arr in ascending order
 	#In each loop, arr2 is reset and a new subarray is inserted and compared with the elements in arr
 	#As a result of these operations, the longest sub sequence is obtained and written in arr
 	#arr array address is put in v0 register and returned.
 	
 	# How to find longest sub sequence size ?
 	#Initially, 1 is put at index 0 of the length array.
 	#and the control is done one by one, starting from the index first of the main array .
 	# When checking an element in the main array, the elements to the left of it are checked
 	#and if there is an element smaller than itself
 	#and if the value in the index of the smaller element in the length array is greater than the value in the index of the larger element,
 	#Takes the value of the larger and smaller length in the length array
 	#and in the final length array, the value of the checked index in the main array is incremented by one.
 	#As a result of these operations, the length of the longest sub sequence is reached.
 	#length array value is put in v0 register and returned.
#############################################################################################################################################################################				
##################################################################         ARRAY 1         ##################################################################################				
#############################################################################################################################################################################
 		# i am doing this part 6 time for the 6 array and explanation is same
 		
		la $a1,Arr1                             # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n1				# GÝVE TO FUNCTON THE ARRAY'S SIZE
		la $a3,Arr1				# GÝVE TO FUNCTON THE ARRAY 
		
		li $v0,4
	 	la $a0,M1
	 	syscall
		
		jal longestSubSeq			# CALL FUNCTION
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		# returned v registers
		# v1 size of longest sub sequence
		# v0 longest increasing sub sequence
		
		# LOAD ADRESS OF ARR3 THAT WÝLL HOLD LONGEST SUB SEQUENCE THAT FROM THE PROCEDURE
		la $t1,arr3
		
		# THAT FOR FILL THE ARR3 WITH RETURNED VALUE OF V0(LONGEST SUB SEQUENCE)																								
		For7:
			slt $t5, $t0,$v1         	# i < size of longest sub sequence
			beq $t5, $zero, Exit8
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j For7
		
		Exit8:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			
			li $v0, 9
			li $a0, 100   	# allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order 
			For8:
				slt $t5, $t0,$v1         # i < size of longest sub sequence
				beq $t5, $zero, Exit9
			
				lw $t3,($t1)
				
				blt $t3,$s2,if10
				bge $t3,$s2,if11
				
				if10:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j For8
					
				if11:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j For8
				
			Exit9:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				# Open (for writing) a file that does not exist
				li   $v0, 13       # system call for open file
				la   $a0, fout     # output file name
				li   $a1, 1       # Open for writing (flags are 0: read, 1: write)
				li   $a2, 0        # mode is ignored
				syscall            # open a file (file descriptor returned in $v0)
				move $s6, $v0      # save the file descriptor 
				
				# write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				
				
				li $v0,4
	 			la $a0,newLine
	 			syscall
				
#############################################################################################################################################################################				
##################################################################         ARRAY 2         ##################################################################################				
#############################################################################################################################################################################				
		
		la $a1,Arr2				 # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n2				# GÝVE TO FUNCTON THE ARRAY'S SIZE	
		la $a3,Arr2				# GÝVE TO FUNCTON THE ARRAY
		
		li $v0,4
	 	la $a0,M2
	 	syscall
		
		jal longestSubSeq
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		
		la $t1,arr3
														
		For9:
			slt $t5, $t0,$v1         
			beq $t5, $zero, Exit10
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j For9
		
		Exit10:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			li $v0, 9
			li $a0, 100    # allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order
			For10:
				slt $t5, $t0,$v1            # i < size of longest sub sequence
				beq $t5, $zero, Exit11
			
				lw $t3,($t1)
				blt $t3,$s2,if12
				bge $t3,$s2,if13
				
				if12:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					sub $t1,$t1,4
					addi $t0,$t0,1
					j For10
					
				if13:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j For10
				
			Exit11:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				 # write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				li $v0,4
	 			la $a0,newLine
	 			syscall
				
#############################################################################################################################################################################				
##################################################################         ARRAY 3         ##################################################################################				
#############################################################################################################################################################################				
		
		la $a1,Arr3				 # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n3				# GÝVE TO FUNCTON THE ARRAY'S SIZE	
		la $a3,Arr3				# GÝVE TO FUNCTON THE ARRAY
		
		li $v0,4
	 	la $a0,M3
	 	syscall
		
		jal longestSubSeq
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		
		la $t1,arr3
														
		FOR3:
			slt $t5, $t0,$v1         
			beq $t5, $zero, EXIT3
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j FOR3
		
		EXIT3:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			li $v0, 9
			li $a0, 100    # allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order
			FOR4:
				slt $t5, $t0,$v1            # i < size of longest sub sequence
				beq $t5, $zero, EXIT4
			
				lw $t3,($t1)
				blt $t3,$s2,IF1
				bge $t3,$s2,IF2
				
				IF1:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR4
					
				IF2:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR4
				
			EXIT4:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				# write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				li $v0,4
	 			la $a0,newLine
	 			syscall
				
#############################################################################################################################################################################				
##################################################################         ARRAY 4         ##################################################################################				
#############################################################################################################################################################################				
		
		la $a1,Arr4				 # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n4				# GÝVE TO FUNCTON THE ARRAY'S SIZE	
		la $a3,Arr4				# GÝVE TO FUNCTON THE ARRAY
		
		li $v0,4
	 	la $a0,M4
	 	syscall
		
		jal longestSubSeq
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		
		la $t1,arr3
														
		FOR5:
			slt $t5, $t0,$v1         
			beq $t5, $zero, EXIT5
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j FOR5
		
		EXIT5:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			li $v0, 9
			li $a0, 100    # allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order
			FOR6:
				slt $t5, $t0,$v1            # i < size of longest sub sequence
				beq $t5, $zero, EXIT6
			
				lw $t3,($t1)
				blt $t3,$s2,IF3
				bge $t3,$s2,IF4
				
				IF3:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR6
					
				IF4:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR6
				
			EXIT6:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				# write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				li $v0,4
	 			la $a0,newLine
	 			syscall
#############################################################################################################################################################################				
##################################################################         ARRAY 5         ##################################################################################				
#############################################################################################################################################################################				
		
		la $a1,Arr5				 # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n5				# GÝVE TO FUNCTON THE ARRAY'S SIZE	
		la $a3,Arr5				# GÝVE TO FUNCTON THE ARRAY
		
		li $v0,4
	 	la $a0,M5
	 	syscall
		
		jal longestSubSeq
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		
		la $t1,arr3
														
		FOR7:
			slt $t5, $t0,$v1         
			beq $t5, $zero, EXIT7
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j FOR7
		
		EXIT7:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			li $v0, 9
			li $a0, 100    # allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order
			FOR8:
				slt $t5, $t0,$v1            # i < size of longest sub sequence
				beq $t5, $zero, EXIT8
			
				lw $t3,($t1)
				blt $t3,$s2,IF5
				bge $t3,$s2,IF6
				
				IF5:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR8
					
				IF6:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR8
				
			EXIT8:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				# write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				li $v0,4
	 			la $a0,newLine
	 			syscall
#############################################################################################################################################################################				
##################################################################         ARRAY 6         ##################################################################################				
#############################################################################################################################################################################				
		
		la $a1,Arr6				 # GÝVE TO FUNCTON THE ARRAY 
		lw $a2,n6				# GÝVE TO FUNCTON THE ARRAY'S SIZE	
		la $a3,Arr6				# GÝVE TO FUNCTON THE ARRAY
		
		li $v0,4
	 	la $a0,M6
	 	syscall
		
		jal longestSubSeq
		
		#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
		
		addi $t2,$zero,0
		addi $t0,$zero,0
		addi $s3,$zero,0
		addi $t1,$zero,0
		
		addi $t5,$zero,0
		addi $t3,$zero,0
		
		
		la $t1,arr3
														
		FOR9:
			slt $t5, $t0,$v1         
			beq $t5, $zero, EXIT9
			
			mul $s3,$t0,4
			add $t1,$t1,$s3
			add $v0,$v0,$s3	
			
			lw $t2,($v0)     
			sw $t2,($t1)						
			
			sub $t1,$t1,$s3
			sub $v0,$v0,$s3			
			addi $t0,$t0,1
			j FOR9
		
		EXIT9:	
			# to write my results to file:
			# I create a stack and convert the integer values of the longest sub
			# sequence and it's size to byte byte ascii values and put them in
			# reverse order in the stack that I created, then the file is written to the
			# file starting from the first element in the stack until the last element.
			
			addi $t0,$zero,0
			addi $t6,$zero,10
			
			# allocate 100 spca for the stack
			li $v0, 9
			li $a0, 100    # allocate 100 bytes 
			syscall
			move $s0, $v0
			
			# go to last space of stack
			addi $s0,$s0,99
			
			# put the \n (newline) end of the stack
			li $t9, 10
			sb $t9, ($s0)
			addi $s0, $s0, -1
			
			addi $v1,$v1,-1
			
			mul $s3,$v1,4
			add $t1,$t1,$s3
			
			addi $v1,$v1,1
			
			#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
			addi $s3,$zero,0
			addi $t2,$zero,0
			addi $t3,$zero,0
			addi $t5,$zero,0
			addi $s2,$zero,10
			
			
			# split the longest increasing sub sequence by byte byte and get their ascii value and put the stack as reverse order
			FOR10:
				slt $t5, $t0,$v1            # i < size of longest sub sequence
				beq $t5, $zero, EXIT10
			
				lw $t3,($t1)
				blt $t3,$s2,IF7
				bge $t3,$s2,IF8
				
				IF7:
					divu $t3,$t6
					mfhi $t8
				
					addi $t8,$t8,48
					
					sb $t8,($s0)
					addi $s0,$s0,-1
				
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1
				
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR10
					
				IF8:
					divu $t3,$t6
					mfhi $t8
					mflo $s4
					
					addi $t8,$t8,48
					addi $s4,$s4,48	
					
					sb $t8,($s0)
					addi $s0,$s0,-1	
					
					sb $s4,($s0)
					addi $s0,$s0,-1	
					
					li $t9, 32
					sb $t9, ($s0)
					addi $s0, $s0, -1		
					
					sub $t1,$t1,4
					addi $t0,$t0,1
					j FOR10
				
			EXIT10:
				# this part for the file explenation as like size: and Array: 
				# fill the stack some ascii values of s i z e :     A r r a y : (while space)
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 121
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 97
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 114
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 65
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 10
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
																				
				addi $v1,$v1,48
				sb $v1, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 58
				sb $t9, ($s0)
				addi $s0, $s0, -1
																																																																																																				
				li $t9, 101
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 122
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 105
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				li $t9, 115
				sb $t9, ($s0)
				addi $s0, $s0, -1
				
				# write the stack to file from begin to end
				# Write to file just opened
				li   $v0, 15       # system call for write to file
				move $a0, $s6      # file descriptor 
				move $a1, $s0      # address of stack from which to write
				li   $a2, 100        # hardcoded buffer length
				syscall            # write to file
				
				# Close the file 
				li   $v0, 16       # system call for close file
				move $a0, $s6      # file descriptor to close
				syscall            # close file								
				
				li $v0,4
	 			la $a0,newLine
	 			syscall																																
				
				li $v0,10
				syscall																	
#############################################################################################################################################################################				
###########################################################         Main Procedure         ##################################################################################				
#############################################################################################################################################################################				
		longestSubSeq:
			addi $t0,$zero,0  
		     	
		     	# Fill zero to arr2 (In order not to cause problems in the next transactions.)
			FOR1:	
				beq $t0,64,EXIT1  
				sw $zero,arr2($t0)
		
 				add $t0,$t0,4	
		
				j FOR1
		
		
			EXIT1:	
			# Fill zero to arr (In order not to cause problems in the next transactions.)
			add $t0,$zero,0				
			FOR:	
				beq $t0,64,EXIT  
				sw $zero,arr($t0)
		
 				add $t0,$t0,4	
		
				j FOR
		
		
			EXIT:
				# Fill zero to length (In order not to cause problems in the next transactions.)
				add $t0,$zero,0	
				For:
					beq $t0,64,Exit  
					sw $zero,length($t0)    # fill zero to length array
			
					add $t0,$t0,4	
			
					j For
		
			Exit:  
				#subsequence ending with Arr[0] is 1
				addi $t0,$zero,1         
				sw $t0,length($zero)    # fill 1 to length[0]
			
				addi $t2,$zero,0   	#counter2
			
				addi $t0,$zero,0
			
				addi $s0,$zero,1       # i counter'ý
				
				li $v0,4
	 			la $a0,message2
	 			syscall
			
			For1:
				slt $t3, $s0, $a2        # i < n
				beq $t3, $zero,Exit2
				
				addi $t4,$zero,0       # j counter'ý 
				
				li $v0,4
	 			la $a0,message4
	 			syscall
				
				For2:
					slt    $t5, $t4,$s0         # j < i
					beq $t5, $zero, Exit3
					
					# to arrive the Arr[j]
					mul $t6,$t4,4               
					add $a1,$a1,$t6
					
					lw $s1,($a1)            # Arr[j]
					
					# to arrive the Arr[i]
					mul $t8,$s0,4
					add $a3,$a3,$t8
					
					lw $s2,($a3)		# Arr[i]
					
					slt $s3,$s1,$s2         # if Arr[j] < Arr[i]
					bne $s3,$zero,if1	# if Arr[j] < Arr[i] correct	
					beq $s3,$zero,if2	# if Arr[j] < Arr[i] incorrect
					
					if1:		# if Arr[j] < Arr[i] correct		
						la $t0,length		# length array using for the longest sub sequence size
						
						mul $s3,$s0,4		# arrive the length[i]	
						add $t0,$t0,$s3
						
						lw $t9,($t0)     #length[i]
						
						sub $t0,$t0,$s3         # for the lenght array addres go back the initial
						
						mul $s4,$t4,4		# arrive the length[j]		
						add $t0,$t0,$s4
						
						lw $t5,($t0)     	 # lenght[j]
						
						sub $t0,$t0,$s4       # for the lenght array addres go back the initial
						
						slt $s5,$t9,$t5		#  length[i] < length[j]
						bne $s5,$zero,if3	# if length[i] < length[j] correct
						beq $s5,$zero,if2	# if length[i] < length[j] incorrect
						
						if3:		#if length[i] < length[j] correct
							la $t7,arr2    # arr2  using for the sub sequences
	 						
	 						mul $s4,$t2,4        # to arrive arr2[counter2]
							add $t7,$t7,$s4	     
	 						
	 						sw $s1,($t7)          # arr2[counter2]=Arr[j]
	 						
	 						# primt sub sequences to screen
	 						
	 						li $v0,1
	 						move $a0,$s1
	 						syscall
	 						
	 						li $v0,4
	 						la $a0,message
	 						syscall
	 						
	 						
	 						
	 						
	 						mul $s3,$s0,4          # to Arrive length[i]
							add $t0,$t0,$s3
	 						
	 						sw $t5,($t0)          # length[i] = length[j]
	 						
	 						sub $t0,$t0,$s3     # for the length array addres go back the initial
	 						sub $t7,$t7,$s4     # for the arr2 array addres go back the initial
							addi $t2,$t2,1      # counter2++
						
					if2:	
						sub $a1,$a1,$t6      # for the Arr array addres go back the initial
						sub $a3,$a3,$t8      # for the Arr array addres go back the initial
					
						addi $t4,$t4,1		   #  j++
						
						
						
						j For2           # go back to for2 for loop
				
				Exit3:
					#SOME REGISTER FILL ZERO FOR SAFETY FOR MY OPERATOIN
					addi $t4,$zero,0
					addi $t5,$zero,0
					addi $t6,$zero,0
					
					li $v0,1
	 				move $a0,$s2
	 				syscall
					
					addi $t2,$t2,1
					
					li $v0,4
	 				la $a0,message3
	 				syscall
					
					li $v0,1
	 				move $a0,$t2
	 				syscall
	 				
					addi $t2,$t2,-1
					
					li $v0,4
	 				la $a0,newLine
	 				syscall
					
					  
					la $s7,arr   # load adress arr array that will be use longest sub sequence
					
					For3:
						slt   $t5, $t4,$t2         # k < counter2
						beq $t5, $zero, Exit4
						
						mul $s3,$t4,4
						add $s7,$s7,$s3
						
						lw $t5,($s7)     # arr[k]
						
						sub $s7,$s7,$s3
						
						beq $t5,$zero,if4      # arr[k]==0
						bne $t5,$zero,if5      # arr[k]!=0
						b if6
						
						if4:   # arr[k]==0
							mul $s3,$t4,4
							add $t7,$t7,$s3	
							
							lw $t1,($t7)       ## arr2[k]
							
							mul $s3,$t4,4
							add $s7,$s7,$s3
						
							sw $t1,($s7)   # arr[k] = arr2[k]
							
							sub $s7,$s7,$s3
							sub $t7,$t7,$s3
	 						
						if5:     # arr[k]!=0
							mul $s3,$t4,4
							add $t7,$t7,$s3	
							
							lw $t1,($t7)       ## arr2[k]
							
							mul $s3,$t4,4
							add $s7,$s7,$s3
						
							lw $t5,($s7)     # arr[k]		
							
	 						sub $s7,$s7,$s3
							sub $t7,$t7,$s3
							
							slt $t6,$t1,$t5     # arr[k] > arr2[k]
							bne $t6,$zero,if7
							beq $t6,$zero,if6
							
							if7:    #arr[k] > arr2[k]
								mul $s3,$t4,4
								add $s7,$s7,$s3
								
								
								sw $t1,($s7)    # arr[k] = arr2[k]
								
								lw $t5,($s7)     # arr[k]
								
								sub $s7,$s7,$s3
						if6:
							addi $t4,$t4,1
							j For3
						
					Exit4:
						For4:    # fill zero to arr2 for the anotger sub sequence
							slt $t5, $t4,$a2         # m < n
							beq $t5, $zero, Exit5
							
							
							
							
							
							sw $zero,($t7)
							addi $t7,$t7,4
						
							addi $t4,$t4,1
							j For4
									
						Exit5:		
							mul $s3,$s0,4
							add $t0,$t0,$s3
					
							lw $t9,($t0)
					
							addi $t9,$t9,1
							addi $t4,$zero,0
					
							sw $t9,($t0)          # length[i]++ 
						
							sub $t0,$t0,$s3
					
							addi $s0, $s0, 1 	   #i++	
							addi $t2,$zero,0           #counter2=0
					
					
							j For1
				
			Exit2:
				addi $t2,$zero,0
				addi $t1,$zero,0         # lis=0
				addi $t3,$zero,0 
				addi $t5,$zero,0
				addi $t9,$zero,0
				addi $t6,$zero,0
					
				For5:
					slt $t5, $t2,$a2         # i < n
					beq $t5, $zero, Exit6
						
					mul $s3,$t2,4
					add $t0,$t0,$s3
						
					lw $t9,($t0)      #length[i]
						
					sub $t0,$t0,$s3
						
					slt $t6,$t1,$t9     # lis<length[i]
					bne $t6,$zero,if8
					b if9
						
					if8:	# lis<length[i]
						mul $s3,$t2,4
						add $t0,$t0,$s3
						
						lw $t9,($t0)      #length[i]
							
						add $t1,$t9,$zero
							
						sub $t0,$t0,$s3
						
						if9:
						     addi $t2,$t2,1	# i++				
						     j For5
						
				Exit6:
				
					addi $t2,$zero,0
					addi $t5,$zero,0
					addi $t3,$zero,0
					addi $t9,$zero,0
					addi $t6,$zero,0
					
					# arr[lis-1]=Arr[n-1]
					subi $t1,$t1,1
					subi $a2,$a2,1
				
					mul $s4,$t1,4
					add $s7,$s7,$s4
				
					mul $s3,$a2,4
					add $a1,$a1,$s3
				
					lw $t9,($a1)
					lw $t6,($s7) 
				
					sw $t9,($s7)
				
					sub $s7,$s7,$s4
					sub $a1,$a1,$s3
				
					addi $t1,$t1,1
					addi $a2,$a2,1
				
					la $v0,arr     # return the longest sub sequence to v0
				
					add $v1,$t1,$zero    # return the longest size sub sequence to v0
					
					
					
					jr $ra   # return the main prrcedure
