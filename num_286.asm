.286
.model small
.stack

.data

; String messages
Welcome db "Welcome to NumGuess x86 Assembly version!",0dh,0ah,0dh,0ah,"Enter your name: $"
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
		cmp dx, 0
		jne limit_ok
		cmp ax, 10
		jae limit_ok

	limit_fail:
		; set default limit
		mov dx, 0
		mov ax, 10

	limit_ok:
		; store limit
		mov [word ptr Limit], dx
		mov [word ptr Limit+2], ax

		; calculate maximum tries needed

		; check if limit is dword
		mov bx, 0
		cmp dx, 0
		je process_limit
		
		; if dword, start result from 16 and process high word
		mov bx, 16
		mov ax, dx

	process_limit:
		inc bx
		shr ax, 1
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
		mov dx, [word ptr Limit]
		mov ax, [word ptr Limit+2]
		call randomLimit
		mov [word ptr Number], dx
		mov [word ptr Number+2], ax

		; print start message
		push offset StartMessage1
		call print
		mov dx, [word ptr Limit]
		mov ax, [word ptr Limit+2]
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
		mov bx, ax
		or bx, dx
		jz out_of_range

		cmp dx, [word ptr Limit]
		ja out_of_range
		jb check_success

		cmp ax, [word ptr Limit+2]
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

		cmp dx, [word ptr Number]
		ja too_high
		jb too_low
		cmp ax, [word ptr Number+2]
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

		mov dx, 0
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
		; ax has number of tries
		cmp ax, 1
		je custom_1
		cmp ax, MaxTries
		jb custom_less_max
		je custom_max
		cmp ax, MaxTriesPlus10p
		jbe custom_within_10p

		; compare tries to limit (tries is only 16 bits)
		cmp [word ptr Limit], 0
		jne custom_over_10p
		cmp ax, [word ptr Limit+2]
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
; 31 bit positive integer in dx:ax
; cx is set to 1 on parse error
getNumber proc
		push bx
		push di

		; set pointer to max length and read string
		mov dx, offset IOBufferMax
		mov ah, 0ah
		int 21h

		; clear dx:ax
		mov dx, 0
		mov ax, 0

		; check if input is empty
		mov ch, 0
		mov cl, IOBufferLength
		cmp cx, 0
		je parse_error

		; loop digits
		mov di, offset IOBuffer

	parse_loop:
		; multiply dx:ax by 10
		mov bx, 10
		push ax
		mov ax, dx
		mul bx
		mov dx, ax
		pop ax
		push dx
		mul bx
		pop bx
		add dx, bx

		mov bl, [di]

		; check for invalid character
		cmp bl, '0'
		jb parse_error
		cmp bl, '9'
		ja parse_error

		; add to dx:ax
		mov bh, 0
		sub bl, '0'
		add ax, bx
		adc dx, 0

		inc di
		loop parse_loop

		; due to the limitation of our random function, limit numbers to 31 bits
		; it is the same positive limit of a signed 32 bit number
		and dx, 7fffh

		; cx is zero, return success
		pop di
		pop bx
		ret

	parse_error:
		mov cx, 1
		pop di
		pop bx
		ret
getNumber endp

; Prints 32 bit number in dx:ax
printNumber proc
		pusha

		; set pointer to output buffer
		mov di, offset IOBuffer

	convert_loop:

		; find mod 10 of dx:ax

		mov bx, 10
		cmp dx, 10
		jae div_32bit

		; div won't overflow, do 16 bit division
		div bx

		; add digit to buffer
		add dl, '0'
		mov [di], dl
		inc di

		; carry on converting if needed
		mov dx, 0
		cmp ax, 0
		je print_digits
		jmp convert_loop

	div_32bit:

		; simple div would overflow, do 32 bit division

		; save low-order word and divide high-order word
		mov cx, ax
		mov ax, dx
		mov dx, 0
		div bx

		; save result of high-order division
		push ax

		; leave remainder in dx, restore and divide low-order word
		mov ax, cx
		div bx

		; add digit to buffer
		add dl, '0'
		mov [di], dl
		inc di

		; restore high-order result into dx
		pop dx

		; carry on converting if needed
		cmp dx, 0
		jne convert_loop
		cmp ax, 0
		jne convert_loop

	print_digits:
		; see how many chars we got
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

		; unlikely, but re-generate if seed is zero
		mov ax, dx
		or ax, cx
		jz generate_seed

		; also re-generate if seed matches our random multiplier
		mov ax, dx
		sub ax, 48271
		or ax, cx
		jz generate_seed

		; kill highest bit to prevent div overflow
		and cx, 7fffh

		mov di, offset RandomSeed
		mov [di], cx
		mov [di+2], dx

		; check if number is a multiple of 48271
		mov dx, cx
		mov ax, dx
		mov bx, 48271
		div bx
		cmp dx, 0
		je generate_seed

		popa
		ret
randomize endp

; Generate a 31 bit random number into dx:ax
; Uses simple MINSTD implementation with multiplier 48271
random proc
		push bx
		push cx
		push di

		; load seed

		mov di, offset RandomSeed
		mov dx, [di]
		mov ax, [di+2]

		; multiply seed

		mov bx, 48271
		mov cx, dx    ; save high order word of seed
		mul bx        ; multiply low order word of seed
		push ax       ; save low order word of result
		push dx       ; save high order word of result
		mov ax, cx    ; load high order word of seed
		mul bx        ; multiply high order word of seed
		pop bx
		add ax, bx    ; add high order word of previous result to dx:ax
		adc dx, 0
		pop cx

		; at this point, multiplied seed is 48 bit dx:ax:cx
		; to mod it by 2^31-1, we'll do some shifting and adding

		; shift highest bit of ax into dx
		shl dx, 1
		shl ax, 1
		adc dx, 0
		shr ax, 1

		; add dx to ax:cx
		add cx, dx
		adc ax, 0

		; put result into dx:ax
		mov dx, ax
		mov ax, cx

		; final check is if result = 2^31-1, set to zero

		cmp ax, 0ffffh
		jne random_done
		cmp dx, 7fffh
		jne random_done

		mov dx, 0
		mov ax, 0

	random_done:

		; kill highest bit to be sure
		and dx, 7fffh

		; store seed
		mov [di], dx
		mov [di+2], ax

		pop di
		pop cx
		pop bx
		ret
random endp

; Generate a 31 bit random number into dx:ax
; Before calling this proc, pre-fill dx:ax with the limit
; The range is 1..limit, inclusive
randomLimit proc
		push bx
		push cx
		push bp
		mov bp, sp

		; save limit
		push dx
		push ax

	rlim_generate:

		; generate 31-bit random number
		call random

		; mod dx:ax with nearest power of two
		; if still over the limit, regenerate
		; there is at most 50% chance of re-iteration, unlikely to cause an infinite loop
		; easier than 32bit mod 32bit, and prevents bias for lower numbers

		; start with high-order bits
		mov bx, [bp-2]
		cmp bx, 0
		jne rlim_32bit

	rlim_16bit:
		; limit is only 16 bits
		mov dx, 0
		mov bx, [bp-4]
		mov cx, 1
	rlim_16bit_mask_loop:
		cmp cx, bx
		jae rlim_16bit_mask_done
		shl cx, 1
		inc cx
		jmp rlim_16bit_mask_loop

	rlim_16bit_mask_done:
		and ax, cx
		jmp rlim_mask_finished

	rlim_32bit:
		; limit is 32 bits, process high-order only
		; bx already has high-order bits of limit
		mov cx, 1
	rlim_32bit_mask_loop:
		cmp cx, bx
		jae rlim_32bit_mask_done
		shl cx, 1
		inc cx
		jmp rlim_32bit_mask_loop

	rlim_32bit_mask_done:
		and dx, cx
		jmp rlim_mask_finished

	rlim_mask_finished:

		; add 1
		add ax, 1
		adc dx, 0

		; check if result is less than the limit
		; if not, re-generate

		cmp dx, [bp-2]
		ja rlim_generate
		jb rlim_return
		cmp ax, [bp-4]
		ja rlim_generate

	rlim_return:

		; discard two words from the stack
		pop bx
		pop bx

		; return
		pop bp
		pop cx
		pop bx
		ret
randomLimit endp

end main
