Include Irvine32.inc
Include macros.inc
BUFFER_SIZE = 1000

.data
str1 BYTE "  Enter the Word : ",0
input BYTE 10 DUP(?)
score BYTE 0
Lives BYTE 5
check BYTE 1
word_list BYTE "FAST","APPLE","SPOT","TOUCH","SHOUT",0
word_list1 BYTE "VALUE","EMPLOYEE","SUCCESS","LAW","VIRUS",0
word_list2 BYTE "FINANCE","MONEY","REWARD","WALLET","WARE",0
arr_L1 BYTE 5 DUP(1)
arr_L2 BYTE 5 DUP(1)
arr_L3 BYTE 5 DUP(1)
file_L1 BYTE "level1.txt",0
file_L2 BYTE "level2.txt",0
file_L3 BYTE "level3.txt",0
file_L4 BYTE "instruction.txt",0
char BYTE 4 Dup("0")


;read file
buffer BYTE BUFFER_SIZE DUP(0)
fileHandle HANDLE ?


;write high score to file
filename BYTE "high_score.txt",0
stringLength DWORD ?

.code
main proc

Again:
      call clrscr
      call crlf
      mWrite<"     'CROSSWORD PUZZLE GAME PROJECT'",0dh,0ah>
	  mWrite<"    =================================",0>
      call crlf
      call crlf
      call crlf
      mWrite<" 1- Quick Play",0dh,0ah," 2- Instruction",0dh,0ah," 3- Setting",0dh,0ah>
      mWrite<" 4- Quit",0dh,0dh,0ah,0ah>
      mWrite<"  Enter Choice : ",0>
      mov eax,0
      call readdec

      cmp al,1
      jne next
      call Quick_play
      jmp quit

      next:
           cmp al,2
           jne next1
		   call clrscr
           call Instruction
           jmp quit

      next1:
            cmp al,3
            jne next2
            call Setting
            jmp quit

      next2:
            cmp al,4
            jne next3
            mov check,0
            jmp Quit1

      next3:
            mWrite <" You Enter Invalid Number",0dh,0ah>
            mov eax,1500
            call delay
            jmp Again
      
	  quit:
           call readdec
           cmp check,0
           jne Again

Quit1:
      call clrscr
	  call DumpRegs
	  exit
main endp

;------------------*Quick_play*------------------
Quick_play PROC

call clrscr
call Level1

call clrscr
cmp lives,0
je gameover
call Level2

call clrscr
cmp lives,0
je gameover
call Level3
jmp quit 

gameover:
         call crlf
		 call crlf
		 call crlf 
		 call crlf 
         mWrite<"      NO LIFE LEFT TO PLAY",0>
		 call Crlf 
	     call Crlf 
         mWrite<"       <------ * GAME OVER!!!!! * ------>",0>
         jmp quit

quit:
     ret
Quick_play endp
;----------------------------------------------------

;------------------*Setting*------------------
Setting PROC
call clrscr
mWrite<" 1- Change Font Color ",0dh,0ah>
mWrite<" 2- Change Background Color ",0dh,0ah>
mWrite<" 3- Change Both Font and Background Color ",0dh,0ah>
call crlf 
Again:
      mWrite<"  Enter Choice : ",0>
      mov eax,0
      call readdec
      cmp al,1
      jne next
      call ChangeFontColor
      jmp next2
	  next:
	       cmp al,2 
		   jne next1
		   call ChangeBackgroundColor
		   jmp next3
	  next1:
	       cmp al,3
		   jne next2
		   call ChangeFontAndBackgroundColor
		   jmp next3
      next2:
           mWrite<"  You enter Invalid number",0dh,0ah>
           mov eax,1500
           call delay
           jmp Again

next3:
      ret
Setting endp
;-------------------------------------------------

;------------------*ChangeFontColor*------------------
ChangeFontColor PROC

call clrscr
mWrite<" 1- Blue",0dh,0ah," 2- White",0dh,0ah," 3- Green",0dh,0ah>
mWrite<" 4- Red",0dh,0ah," 5- Magenta",0dh,0ah," 6- Yellow",0dh,0ah>
mWrite<" 7- Cyan",0dh,0ah," 8- Brown",0dh,0ah>
call Crlf 
mWrite<"  Select your desired Font Color : ",0>
mov eax,0
call readdec

cmp al,1
jne next
mov eax,blue
call settextcolor
jmp quit

next:
     cmp al,2
     jne next1
     mov eax,white
     call settextcolor
     jmp quit

next1:
      cmp al,3
      jne next2
      mov eax,green
      call settextcolor
      jmp quit

next2:
      cmp al,4
      jne next3
      mov eax,red
      call settextcolor
      jmp quit

next3:
      cmp al,5
      jne next4
      mov eax,magenta
      call settextcolor
      jmp quit

next4:
      cmp al,6
      jne next5
      mov eax,yellow
      call settextcolor
      jmp quit

next5:
      cmp al,7
      jne next6
      mov eax,cyan
      call settextcolor
      jmp quit

next6:
      cmp al,8
      jne next7
      mov eax,brown
      call settextcolor
      jmp quit

next7:
      mWrite <"  You Enter Invalid Number",0dh,0ah>

quit:
     ret
ChangeFontColor endp
;-----------------------------------------------------

;------------------***ChangeBackgroundColor***------------------
ChangeBackgroundColor PROC

call clrscr
mWrite<" 1- Blue",0dh,0ah," 2- White",0dh,0ah," 3- Green",0dh,0ah>
mWrite<" 4- Red",0dh,0ah," 5- Magenta",0dh,0ah," 6- Yellow",0dh,0ah>
mWrite<" 7- Cyan",0dh,0ah," 8- Brown",0dh,0ah>
call Crlf 
mWrite<"  Select your desired Background Color : ",0>
mov eax,0
call readdec

cmp al,1
jne next
mov eax,(blue*16)
call settextcolor
call clrscr
jmp quit

next:
     cmp al,2
     jne next1
     mov eax,(white*16)
     call settextcolor
	 call clrscr
     jmp quit

next1:
      cmp al,3
      jne next2
      mov eax,(green*16)
      call settextcolor
	  call clrscr
      jmp quit

next2:
      cmp al,4
      jne next3
      mov eax,(red*16)
      call settextcolor
	  call clrscr
      jmp quit

next3:
      cmp al,5
      jne next4
      mov eax,(magenta*16)
      call settextcolor
	  call clrscr
      jmp quit

next4:
      cmp al,6
      jne next5
      mov eax,(yellow*16)
      call settextcolor
	  call clrscr
      jmp quit

next5:
      cmp al,7
      jne next6
      mov eax,(cyan*16)
      call settextcolor
	  call clrscr
      jmp quit

next6:
      cmp al,8
      jne next7
      mov eax,(brown*16)
      call settextcolor
	  call clrscr
      jmp quit

next7:
      mWrite <"  You Enter Invalid Number",0dh,0ah>

quit:
     ret
ChangeBackgroundColor ENDP
;---------------------------------------------------------------

;------------------***ChangeFontAndBackgroundColor***------------------
ChangeFontAndBackgroundColor PROC

call clrscr
mWrite<" 1- Blue(font) and Gray(background)",0dh,0ah," 2- White(font) and Red(background)",0dh,0ah," 3- Green(font) and Black(background)",0dh,0ah>
mWrite<" 4- Red(font) and LightGreen(background)",0dh,0ah," 5- Magenta(font) and LightRed(background)",0dh,0ah," 6- Yellow(font) and Magenta(background)",0dh,0ah>
mWrite<" 7- Cyan(font) and LightGray(background)",0dh,0ah," 8- Brown(font) and LightBlue(background)",0dh,0ah," 9- Black(font) and White(background)",0dh,0ah>
call Crlf 
mWrite<"  Select your desired Font and Background Color Combination: ",0>
mov eax,0
call readdec

cmp al,1
jne next
mov eax,blue+(gray*16)
call settextcolor
call clrscr
jmp quit

next:
     cmp al,2
     jne next1
     mov eax,white+(red*16)
     call settextcolor
	 call clrscr
     jmp quit

next1:
      cmp al,3
      jne next2
      mov eax,green+(black*16)
      call settextcolor
	  call clrscr
      jmp quit

next2:
      cmp al,4
      jne next3
      mov eax,red+(lightgreen*16)
      call settextcolor
	  call clrscr
      jmp quit

next3:
      cmp al,5
      jne next4
      mov eax,magenta+(lightred*16)
      call settextcolor
	  call clrscr
      jmp quit

next4:
      cmp al,6
      jne next5
      mov eax,yellow+(magenta*16)
      call settextcolor
	  call clrscr
      jmp quit

next5:
      cmp al,7
      jne next6
      mov eax,cyan+(lightgray*16)
      call settextcolor
	  call clrscr
      jmp quit

next6:
      cmp al,8
      jne next7
      mov eax,brown+(lightblue*16)
      call settextcolor
	  call clrscr
      jmp quit

next7:
      cmp al,9
      jne next8
      mov eax,black+(white*16)
      call settextcolor
	  call clrscr
      jmp quit

next8:
      mWrite <"  You Enter Invalid Number",0dh,0ah>

quit:
     ret
ChangeFontAndBackgroundColor ENDP
;----------------------------------------------------------------------

;------------------*Level1*------------------
Level1 PROC

outter:
       call crlf
       call crlf
       call crlf
       mov ecx,1000
       call delay
       mWrite<"       > LEVEL 1: <",0ah,0>
       call crlf
       call crlf
       cmp lives,0
	   je nolife
       
	   mWrite<" >> Lives : ",0>
       movzx eax,lives
       call writedec
       mWrite<"    >> Score : ",0>
       movzx  eax,score
       call WriteDec
	   call crlf
	   call crlf

	   mov edx,offset file_L1
	   call Read_File
	   call crlf

	   mov edx,offset str1
	   call writestring

	   mov  edx,OFFSET input
       mov  ecx,9
       call ReadString

	   mov al,arr_L1[0]
	   cmp al,1
	   jne else1

	   cld
	   mov esi,offset input
	   mov edi,offset word_list[0]
	   mov ecx,4
	   repe cmpsb
	   jnZ else1
	   call crlf 
	   mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	   inc score
	   mov arr_L1[0],0
	   jmp next
      
	   else1:
	         mov al,arr_L1[1]
	         cmp al,1
	         jne else2
	         cld 
	         mov esi,offset input
	         mov edi,offset word_list[4]
	         mov ecx,5
	         repe cmpsb
	         jnz else2
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L1[1],0
	         jmp next
      
	  else2:
            mov al,arr_L1[2]
	        cmp al,1
	        jne else3
	        cld
	        mov esi,offset input
	        mov edi,offset word_list[9]
	        mov ecx,4
	        repe cmpsb
	        jnz else3
			call crlf 
	        mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	        inc score
	        mov arr_L1[2],0
	        jmp next

      else3:
            mov al,arr_L1[3]
	        cmp al,1
	        jne else4
	        cld
	        mov esi,offset input
	        mov edi,offset word_list[13]
	        mov ecx,5
	        repe cmpsb
	        jnz else4
			call crlf 
	        mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	        inc score
	        mov arr_L1[3],0
	        jmp next

      else4:
            mov al,arr_L1[4]
	        cmp al,1
	        jne else5
	        cld
	        mov esi,offset input
	        mov edi,offset word_list[18]
	        mov ecx,5
	        repe cmpsb
	        jnz else5
			call crlf 
	        mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	        inc score
	        mov arr_L1[4],0
	        jmp next

      else5:
	        call crlf 
            mWrite<" Your entered word not found!!!!",0dh,0ah>
	        dec lives
      next:
           mov eax,1500
           call delay
           call clrscr
           mov al,score
           cmp al,5
           jl outter
           JZ quit

nolife:
     call crlf
	 call crlf
	 call crlf
	 call crlf
	 call crlf
     mWrite<"      NO LIFE LEFT TO PLAY",0>
     mWrite<"       <------ * GAME OVER!!!!! * ------>",0>
	 ret

quit:
     ret
Level1 endp
;------------------------------------------------

;------------------*Level2*------------------
Level2 Proc

	   call crlf
	   call crlf
	   call crlf
	   mov ecx,1000
	   call delay
	   mWrite<" --->>> LEVEL 1 SUCCESSFULLY COMPLETED, NOW PASS NEXT LEVEL <<<----",0>
outter:
       call crlf
	   call crlf
	   call crlf
	   mWrite<"       > LEVEL 2: <",0>
	   call crlf
	   call crlf
       cmp lives,0
	   je nolife

       mWrite<" >> Lives : ",0>
       movzx eax,lives
       call writedec
       mWrite<"     >> Score : ",0>
       movzx eax,score
       call WriteDec
	   call crlf
	   call crlf
	   mov edx,offset file_L2
	   call Read_File
	   call crlf

	   mov edx,offset str1
	   call writestring

	   mov  edx,OFFSET input
       mov  ecx,9
       call ReadString


	   mov al,arr_L2[0]
	   cmp al,1
	   jne else1
	   cld
	   mov esi,offset input
	   mov edi,offset word_list1[0]
	   mov ecx,5
	   repe cmpsb
	   jnZ else1
	   call crlf 
	   mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	   inc score
	   mov arr_L2[0],0
	   jmp next
       
	   else1:
	         mov al,arr_L2[1]
	         cmp al,1
	         jne else2
	         cld
	         mov esi,offset input
	         mov edi,offset word_list1[5]
	         mov ecx,8
	         repe cmpsb
	         jnz else2
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L2[1],0
	         jmp next
       
	   else2:
             mov al,arr_L2[2]
	         cmp al,1
	         jne else3
	         cld
	         mov esi,offset input
	         mov edi,offset word_list1[13]
	         mov ecx,7
	         repe cmpsb
	         jnz else3
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L2[2],0
	         jmp next
       
	   else3:
             mov al,arr_L2[3]
	         cmp al,1
	         jne else4
	         cld
	         mov esi,offset input
	         mov edi,offset word_list1[20]
	         mov ecx,3
	         repe cmpsb
	         jnz else4
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L2[3],0
	         jmp next
       
	   else4:
             mov al,arr_L2[4]
	         cmp al,1
	         jne else5
	         cld
	         mov esi,offset input
	         mov edi,offset word_list1[23]
	         mov ecx,5
	         repe cmpsb
	         jnz else5
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L2[4],0
	         jmp next

      else5:
	        call crlf 
            mWrite<" Your entered word not found!!!!",0dh,0ah>
	        dec lives
      next:
           mov eax,1500
           call delay
           call clrscr
           mov al,score
           cmp al,10
           jl outter
		   JZ quit

nolife:
     call crlf
	 call crlf
	 call crlf
	 call crlf
	 call crlf
     mWrite<"      NO LIFE LEFT TO PLAY",0>
     mWrite<"       <------ * GAME OVER!!!!! * ------>",0>
	 ret

quit:
     call crlf 
     ret
Level2 endp
;------------------------------------------------

;------------------*Level3*------------------
Level3 Proc

	   call crlf
	   call crlf
	   call crlf
	   mov ecx,1000
	   call delay
	   mWrite<" --->>> LEVEL 2 SUCCESSFULLY COMPLETED, NOW PASS NEXT LEVEL <<<---",0
outter:
       call crlf
	   call crlf
	   call crlf
	   mWrite<"       > LEVEL 3: <",0>
	   call crlf
	   call crlf
       cmp lives,0
	   je nolife
 
       mWrite<" >> Lives : ",0>
       movzx eax,lives
       call writedec
       mWrite<"     >> Score : ",0>
       movzx eax,score
       call WriteDec
	   call crlf
	   call crlf
	   mov edx,offset file_L3
	   call read_file
	   call crlf

	   mov edx,offset str1
	   call writestring

	   mov  edx,OFFSET input
       mov  ecx,9
       call ReadString


	   mov al,arr_L3[0]
	   cmp al,1
	   jne else1
	   cld
	   mov esi,offset input
	   mov edi,offset word_list2[0]
	   mov ecx,7
	   repe cmpsb
	   jnZ else1
	   call crlf 
	   mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	   inc score
	   mov arr_L3[0],0
	   jmp next
      
	   else1:
	         mov al,arr_L3[1]
	         cmp al,1
	         jne else2
	         cld
	         mov esi,offset input
	         mov edi,offset word_list2[7]
	         mov ecx,5
	         repe cmpsb
	         jnz else2
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L3[1],0
	         jmp next
       
	   else2:
             mov al,arr_L3[2]
	         cmp al,1
	         jne else3
	         cld
	         mov esi,offset input
	         mov edi,offset word_list2[12]
	         mov ecx,6
	         repe cmpsb
	         jnz else3
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L3[2],0
	         jmp next

       else3:
             mov al,arr_L3[3]
	         cmp al,1
	         jne else4
	         cld
	         mov esi,offset input
	         mov edi,offset word_list2[18]
	         mov ecx,6
	         repe cmpsb
	         jnz else4
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L3[3],0
	         jmp next

       else4:
             mov al,arr_L3[4]
	         cmp al,1
	         jne else5
	         cld
	         mov esi,offset input
	         mov edi,offset word_list2[24]
	         mov ecx,4
	         repe cmpsb
	         jnz else5
			 call crlf 
	         mWrite <" Your entered word Successfully found!!!!",0dh,0ah>
	         inc score
	         mov arr_L3[4],0
	         jmp next

       else5:
	         call crlf 
             mWrite<" Your entered word not found!!!!",0dh,0ah>
	         dec lives
       
	   next:
            mov eax,1500
            call delay
            call clrscr
            mov al,score
            cmp al,15
            jl outter
            je success

       success:
               call crlf
               call crlf
               call crlf
               mov ecx,2500
               call delay
	           call crlf
	           call crlf
	           call crlf
               mWrite<" 'HURRAH!!!!!!! YOU PASSED ALL LEVEL SUCCESSFULLY .........'",0>
               call crlf
			   call crlf
			   call crlf
               mWrite<" || 'CONGRATULATIONS YOU WIN THE GAME ...!!! ||'",0>
			   jmp quit
nolife:
     call crlf
	 call crlf
	 call crlf
	 call crlf
	 call crlf
     mWrite<" NO LIFE LEFT TO PLAY",0>
     mWrite<"       <------ * GAME OVER!!!!! * ------>",0>
	 ret

quit:
	 call Crlf 
	 call Crlf 
     ret
Level3 endp
;------------------------------------------------

;------------------Read_File***------------------
Read_File proc

call OpenInputFile
mov fileHandle,eax
cmp eax,INVALID_HANDLE_VALUE                    
jne file_ok 
mWrite <" ERROR: Cannot open file...!!!",0dh,0ah>
jmp quit

file_ok:
        mov edx,OFFSET buffer
        mov ecx,BUFFER_SIZE
        call ReadFromFile
        jnc check_buffer_size
        mWrite " ERROR: In Reading file...!!!" 
        call WriteWindowsMsg
        jmp close_file

check_buffer_size:
        cmp eax,BUFFER_SIZE 
		jb buf_size_ok 
        mWrite <"ERROR: Buffer too small for the file...!!!",0dh,0ah>
        jmp quit 

buf_size_ok:
            mov buffer[eax],0 
            mov edx,OFFSET buffer 
			call WriteString 
            call Crlf
close_file:
           mov eax,fileHandle
           call CloseFile

quit:
     ret
Read_File endp
;------------------------------------------------

;------------------*Instruction*------------------
Instruction PROC

mov edx,offset file_L4
call Read_File
call crlf
ret
Instruction endp
;-----------------------------------------------------

;-------------------*Write_File*------------------
Write_File PROC

mov edx,OFFSET filename 
call CreateOutputFile 
mov fileHandle,eax 
cmp eax, INVALID_HANDLE_VALUE  
jne file_ok 
mWrite<" ERROR: Cannot Create file...!!!",0dh,0ah,0>  
jmp quit 

file_ok: 
	    mov eax,0
	    cld
	    mov al,score
	    mov edi,offset char
	    stosd
        mov eax,fileHandle
        mov edx,offset char
        mov ecx,4
        call WriteToFile
        call CloseFile

quit:
     ret
Write_File endp
;-----------------------------------------------------

end main


