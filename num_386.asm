.model small
.386 ; Specify this after model to force 16 bit segments for simple DOS mode
.stack

.data

; String messages
Welcome db "Welcome to NumGuess 386 Assembly version!",0dh,0ah,0dh,0ah,"Enter your name: $"
LimitPrompt1 db 0dh,0ah,0dh,0ah,"Welcome $"
LimitPrompt2 db ", enter upper limit: $"
StartMessage1 db 0dh,0ah,0dh,0ah,"Guess my number between 1 and $"
StartMessage2 db "!",0dh,0ah,0dh,0ah,"$"
GuessPrompt db "Guess: $"
OutOfRange db 0dh,0ah,"Out of range.",0dh,0ah,"$"
Wrong db 0dh,0ah,"That's just plain wrong.",0dh,0ah,"$"
TooHigh db 0dh,0ah,"Too high!",0dh,0ah,"$"
TooLow db 0dh,0ah,"Too low!",0dh,0ah,"$"
WellDone1 db 0dh,0ah,0dh,0ah,"Well done $"
WellDone2 db ", you guessed my number from $"
TryWord db " try!",0dh,0ah,"$"
TriesWord db " tries!",0dh,0ah,"$"
PlayAgain db 0dh,0ah,"Play again [y/N]? $"
OkayBye db 0dh,0ah,0dh,0ah,"Okay, bye.$"

; End of game custom messages
Custom1 db "You're one lucky bastard!$"
CustomLessMax db "You are the master of this game!$"
CustomMax db "You are a machine!$"
CustomWithin10p db "Very good result!$"
CustomOver10p db "Try harder, you can do better!$"
CustomOverLimit db "I find your lack of skill disturbing!$"

; Input buffer for player name
PlayerMax db 255
PlayerLength db 0
PlayerName db 256 dup (0)
DefaultName db "Player$"

; Temporary I/O buffer for subroutines
IOBufferMax db 255
IOBufferLength db 0
IOBuffer db 256 dup (0)

; Random number generator state
RandomSeed dd 65535

; Game variables
Limit dd 0
MaxTries dw 0
MaxTriesPlus10p dw 0
Tries dw 0
Number dd 0

.code

assume ds:@data

;;
;; Main program
;;

main proc
		mov ax, @data
		mov ds, ax

		; initialise random seed
		call randomize

		; print welcome message and name prompt
		push offset Welcome
		call print

		; get player name
		push offset PlayerName
		call input

		; check if player name is empty
		cmp PlayerLength, 0
		jne got_name

		; copy default name to player name buffer
		mov di, offset PlayerName
		mov si, offset DefaultName
	copy_loop:
		mov al, [si]
		mov [di], al
		inc si
		inc di
		cmp al, '$'
		jne copy_loop

	got_name:
		; print limit prompt
		push offset LimitPrompt1
		call print
		push offset PlayerName
		call print
		push offset LimitPrompt2
		call print

		; get input and check if valid
		call getNumber
		cmp cx, 0
		jne limit_fail
		cmp eax, 10
		jae limit_ok

	limit_fail:
		; set default limit
		mov eax, 10

	limit_ok:
		; store limit
		mov Limit, eax

		; calculate maximum tries needed
		mov bx, 0

	process_limit:
		inc bx
		shr eax, 1
		jnz process_limit

		; save max tries
		mov MaxTries, bx

		; calculate max tries plus 10%
		mov ax, MaxTries
		mov dx, 0
		mov bx, 10
		div bx
		add ax, MaxTries
		mov MaxTriesPlus10p, ax

	start_game:
	
		; initialise game variables
		mov Tries, 0
		mov eax, Limit
		call randomLimit
		mov Number, eax

		; print start message
		push offset StartMessage1
		call print
		mov eax, Limit
		call printNumber
		push offset StartMessage2
		call print

	guess_loop:
		push offset GuessPrompt
		call print
		call getNumber

		; check if valid input
		cmp cx, 0
		jne invalid_input

		; check if out of range
		cmp eax, 0
		je out_of_range

		cmp eax, Limit
		jbe check_success

	out_of_range:
		push offset OutOfRange
		call print
		jmp guess_loop

	invalid_input:
		push offset Wrong
		call print
		jmp guess_loop

	check_success:
		; counts as a try
		inc Tries

		cmp eax, Number
		ja too_high
		jb too_low
		jmp success

	too_high:
		push offset TooHigh
		call print
		jmp guess_loop

	too_low:
		push offset TooLow
		call print
		jmp guess_loop

	success:
		; number guessed, print well done message
		push offset WellDone1
		call print
		push offset PlayerName
		call print
		push offset WellDone2
		call print

		mov eax, 0
		mov ax, Tries
		call printNumber
		cmp ax, 1
		jne plural

		push offset TryWord
		call print
		jmp custom_message

	plural:
		push offset TriesWord
		call print

	custom_message:
		; eax has number of tries
		cmp ax, 1
		je custom_1
		cmp ax, MaxTries
		jb custom_less_max
		je custom_max
		cmp ax, MaxTriesPlus10p
		jbe custom_within_10p

		; compare tries to limit (tries is only 16 bits)
		cmp eax, Limit
		ja custom_over_limit
		jmp custom_over_10p

	custom_1:
		push offset Custom1
		call print
		jmp play_again

	custom_less_max:
		push offset CustomLessMax
		call print
		jmp play_again

	custom_max:
		push offset CustomMax
		call print
		jmp play_again

	custom_within_10p:
		push offset CustomWithin10p
		call print
		jmp play_again

	custom_over_10p:
		push offset CustomOver10p
		call print
		jmp play_again

	custom_over_limit:
		push offset CustomOverLimit
		call print

	play_again:
		push offset PlayAgain
		call print
		push offset IOBuffer
		call input

		cmp IOBufferLength, 1
		jne exit_program
		cmp IOBuffer, 'y'
		je restart_game
		cmp IOBuffer, 'Y'
		je restart_game
		jmp exit_program

	restart_game:
		; inverted logic needed for long jump
		jmp start_game

	exit_program:
		push offset OkayBye
		call print

		; exit
		mov ax,4c00h
		int 21h
main endp

;;
;; Subroutines
;;

; Prints a $ terminated string
; takes 2 byte buffer offset on the stack
print proc
		push bp
		mov bp, sp
		push ax
		push dx

		mov dx, [bp+4]
		mov ah, 9
		int 21h

		pop dx
		pop ax
		pop bp
		ret 2
print endp

; Gets string input into buffer
; takes 2 byte buffer offset on the stack
; the two bytes before the buffer is used for max and actual length
input proc
		push bp
		mov bp, sp
		push ax
		push dx
		push di

		; set pointer back by 2 bytes to max length and read string
		mov dx, [bp+4]
		sub dx, 2
		mov ah, 0ah
		int 21h

		; add $ to the end of the string
		mov di, [bp+4]
		dec di
		mov al, [di]
		mov ah, 0
		inc di
		add di, ax
		mov al, '$'
		mov [di], al

		pop di
		pop dx
		pop ax
		pop bp
		ret 2
input endp

; Gets user input and returns:
; 31 bit positive integer in eax
; cx is set to 1 on parse error
getNumber proc
		push ebx
		push edx
		push di

		; set pointer to max length and read string
		mov dx, offset IOBufferMax
		mov ah, 0ah
		int 21h

		; clear eax
		mov eax, 0

		; check if input is empty
		mov ecx, 0
		mov cl, IOBufferLength
		cmp ecx, 0
		je parse_error

		; loop digits
		mov di, offset IOBuffer

	parse_loop:
		; multiply eax by 10
		mov ebx, 10
		mul ebx
		jc parse_error

		mov ebx, 0
		mov bl, [di]

		; check for invalid character
		cmp bl, '0'
		jb parse_error
		cmp bl, '9'
		ja parse_error

		; add to eax
		sub bl, '0'
		add eax, ebx
		jc parse_error

		inc di
		loop parse_loop

		; due to the limitation of our random function, limit numbers to 31 bits
		; it is the same positive limit of a signed 32 bit number
		and eax, 7fffffffh

		; cx is zero, return success
		pop di
		pop edx
		pop ebx
		ret

	parse_error:
		mov cx, 1
		pop di
		pop edx
		pop ebx
		ret
getNumber endp

; Prints 32 bit number in eax
printNumber proc
		pusha

		; set pointer to output buffer
		mov di, offset IOBuffer

	convert_loop:

		; find mod 10 of eax
		mov edx, 0
		mov ebx, 10
		div ebx

		; add digit to buffer
		add dl, '0'
		mov [di], dl
		inc di

		; carry on converting if needed
		cmp eax, 0
		jne convert_loop

	print_digits:
		; see how many chars we got
		mov ecx, 0
		mov cx, di
		sub cx, offset IOBuffer

	print_loop:
		dec di
		mov dl, [di]
		mov ah, 2
		int 21h
		loop print_loop

		popa
		ret
printNumber endp

; Generate random seed and initialise RNG
; Makes sure seed it coprime to 48271
randomize proc
		pusha

	generate_seed:
		; get system time in cx:dx
		mov ah, 0
		int 1ah
		
		; could be too small number, xor it up and set second highest bit
		xor cx, dx
		or cx, 4000h
		
		; move seed to eax
		mov eax, 0
		mov ax, dx
		shl eax, 16
		mov ax, cx

		; unlikely, but re-generate if seed is zero
		cmp eax, 0
		je generate_seed

		; also re-generate if seed matches our random multiplier
		cmp eax, 48271
		je generate_seed

		; kill highest bit to prevent div overflow
		and eax, 7fffffffh

		mov di, offset RandomSeed
		mov [di], eax

		; check if number is a multiple of 48271
		mov edx, 0
		mov ebx, 48271
		div ebx
		cmp edx, 0
		je generate_seed

		popa
		ret
randomize endp

; Generate a 31 bit random number into eax
; Uses simple MINSTD implementation with multiplier 48271
random proc
		push ebx
		push edx
		push di

		; load seed
		mov di, offset RandomSeed
		mov eax, [di]

		; multiply seed
		mov ebx, 48271
		mul ebx

		; at this point, multiplied seed is 48 bit edx:eax
		; mod it by 2^31-1
		mov ebx, 7fffffffh
		div ebx

		; put result into eax
		mov eax, edx

		; store seed
		mov [di], eax

		pop di
		pop edx
		pop ebx
		ret
random endp

; Generate a 31 bit random number into eax
; Before calling this proc, pre-fill eax with the limit
; The range is 1..limit, inclusive
randomLimit proc
		push ecx
		push bp
		mov bp, sp

		; save limit
		push eax
		
	rlim_generate:
		; generate 31-bit random number
		call random

		; mod eax with nearest power of two
		; if still over the limit, regenerate
		; there is at most 50% chance of re-iteration, unlikely to cause an infinite loop
		; this prevents bias for lower numbers
		
		mov ecx, 1
	rlim_mask_loop:
		cmp ecx, [bp-4]
		jae rlim_mask_done
		shl ecx, 1
		inc ecx
		jmp rlim_mask_loop
		
	rlim_mask_done:
		; apply mask
		and eax, ecx

		; add 1
		add eax, 1

		; check if result is less than the limit
		; if not, re-generate
		
		cmp eax, [bp-4]
		ja rlim_generate

		; discard dword from the stack
		pop ecx

		; return
		pop bp
		pop ecx
		ret
randomLimit endp

end main
