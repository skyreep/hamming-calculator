.equ SWITCHES, 0x10000040 #SWITCHES ADDRESS
.equ LED, 0x10000010 #LED ADDRESS

.global _start
_start:
	#Store LED and SWITCHES addresses
    movia r24, LED
    movia r25, SWITCHES
    
    #Store loop end value
    movi r8, 0x8
    
    #Store loop counter 'i'
    movi r9, 0x0
    
    #Load both values from switches - store in r3
    ldhio r3, 0(r25)
    
    #Storing comparators to split input
    movi r4, 0x0000001f 
    movi r5, 0x000003e0
    
    #Split input in two
    and r6, r3, r4 #r6 is 1st num
    and r3, r3, r5 #r3 is 2nd num
    
    srli r3, r3, 5
    
    #XOR original numbers
    xor r7, r6, r3
    
    LOOP:
    	bge r9, r8, ENDLOOP
        
    	#AND XOR results with 1
    	andi r10, r7, 0x1
    
    	#Add results of AND in tmp HD counter (r10 to final HD counter
    	#Then store in final HD counter (r11)
    	add r11, r10, r11
    
    	#Shift XOR results right one
    	srli r7, r7, 1
    	
        #Increment loop counter
        addi r9, r9, 1
        
        br LOOP
        
	ENDLOOP:
    #Display the final hamming distance via LED
    stwio r11, 0(r24)
    
    END: br END
    