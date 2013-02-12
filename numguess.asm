.MODEL SMALL
.CODE

start:

   mov ax,3h
   int 10h

   mov dx,OFFSET WelcomeMessage
   mov ax,SEG WelcomeMessage
   mov ds,ax
   mov ah,9
   int 21h
   mov dx,OFFSET EnterName
   mov ax,SEG EnterName
   mov ds,ax
   mov ah,9
   int 21h

   ;get player name
   mov dx,OFFSET PlayerName
   mov ax,SEG PlayerName
   mov ds,ax
   mov ah,3fh
   mov bx,0
   mov cx,1eh
   int 21h
   mov bp,ax

   ;welcome
   mov dx,OFFSET Welcome
   mov ax,SEG Welcome
   mov ds,ax
   mov ah,9
   int 21h

   ;$ to the end!
   mov di,OFFSET PlayerName
   mov ax,SEG PlayerName
   mov es,ax
   mov es:[di+bp-2],0124h

   mov dx,OFFSET PlayerName
   mov ds,ax
   mov ah,9
   int 21h
   mov dx,OFFSET Exclamation
   mov ax,SEG Exclamation
   mov ds,ax
   mov ah,9
   int 21h

   ;LetsGuess
   mov dx,OFFSET LetsGuess
   mov ax,SEG LetsGuess
   mov ds,ax
   mov ah,9
   int 21h

startgame:

   mov ah,2ch
   int 21h
   xor ax,ax
   mov al,dl

   inc ax
   mov num,ax

   cmp ax,64h
   jae startgame

   mov guesses,0

readguess:

   mov ax,guesses
   inc ax
   mov guesses,ax

   mov dx,OFFSET GuessPrompt
   mov ax,SEG GuessPrompt
   mov ds,ax
   mov ah,9
   int 21h

   ;get guess
   mov dx,OFFSET Guess
   mov ax,SEG Guess
   mov ds,ax
   mov ah,3fh
   mov bx,0
   mov cx,1eh
   int 21h
   mov dx,ax
   mov bp,dx

   ;$ to the end!
   mov di,OFFSET Guess
   mov ax,SEG Guess
   mov es,ax
   mov es:[di+bp-2],0124h

   xor cx,cx

checkifnum:

   mov di,OFFSET Guess
   mov ax,SEG Guess
   mov es,ax
   mov bp,cx
   mov al,es:[di+bp]

   cmp al,24h
   je  itisanumber
   cmp al,30h
   jb  itisnotanumber
   cmp al,39h
   ja  itisnotanumber

   inc cx
   jmp checkifnum

itisnotanumber:

   mov dx,OFFSET NotANumber
   mov ax,SEG NotANumber
   mov ds,ax
   mov ah,9
   int 21h
   jmp readguess

itisanumber:

   xor cx,cx
   xor ax,ax

processnum:

   mov di,OFFSET Guess
   mov dx,SEG Guess
   mov es,dx
   mov bp,cx
   mov bl,es:[di+bp]

   cmp bl,24h
   je  numprocessed

   mul ten

   cmp bl,30h
   je  num0
   cmp bl,31h
   je  num1
   cmp bl,32h
   je  num2
   cmp bl,33h
   je  num3
   cmp bl,34h
   je  num4
   cmp bl,35h
   je  num5
   cmp bl,36h
   je  num6
   cmp bl,37h
   je  num7
   cmp bl,38h
   je  num8
   cmp bl,39h
   je  num9
   jmp exit

num9:
   inc ax
num8:
   inc ax
num7:
   inc ax
num6:
   inc ax
num5:
   inc ax
num4:
   inc ax
num3:
   inc ax
num2:
   inc ax
num1:
   inc ax
num0:

   inc cx
   jmp  processnum

numprocessed:

   mov gnum,ax
   cmp ax,64h
   ja  rangeerror
   cmp ax,num
   ja  damntoohigh
   jb  damntoolow
   je  hurray

damntoohigh:

   mov dx,OFFSET TooHigh
   mov ax,SEG TooHigh
   mov ds,ax
   mov ah,9
   int 21h
   jmp readguess

damntoolow:

   mov dx,OFFSET TooLow
   mov ax,SEG TooLow
   mov ds,ax
   mov ah,9
   int 21h
   jmp readguess

rangeerror:

   mov dx,OFFSET OutOfRange
   mov ax,SEG OutOfRange
   mov ds,ax
   mov ah,9
   int 21h
   jmp readguess

hurray:

   mov dx,OFFSET Victory
   mov ax,SEG Victory
   mov ds,ax
   mov ah,9
   int 21h

   cmp guesses,10
   jna wanttoplay

   mov dx,OFFSET OverTen
   mov ax,SEG OverTen
   mov ds,ax
   mov ah,9
   int 21h

wanttoplay:

   mov dx,OFFSET PlayAgain
   mov ax,SEG PlayAgain
   mov ds,ax
   mov ah,9h
   int 21h

   mov ah,00h
   int 16h
   mov bl,al

   mov ax,3h
   int 10h

   cmp bl,"y"
   je  pagain
   cmp bl,"Y"
   je  pagain

exit:

   mov dx,OFFSET ThankYou
   mov ax,SEG ThankYou
   mov ds,ax
   mov ah,9h
   int 21h

   mov ax,4c00h
   int 21h

pagain:

   jmp StartGame


.DATA

WelcomeMessage  db  "Welcome to NumGuess for ASM!$"
EnterName       db  0dh,0ah,0dh,0ah,"Enter your name (max 15 chars): $"
Welcome         db  "Welcome $"
Exclamation     db  "!",0dh,0ah,0dh,0ah,"$"
LetsGuess       db  "Let's see how good you are!",0dh,0ah,"Guess my number between 1 and 100!",0dh,0ah,0dh,0ah,"$"
GuessPrompt     db  "Guess: $"
TooHigh         db  "Too high!",0dh,0ah,0dh,0ah,"$"
TooLow          db  "Too low!",0dh,0ah,0dh,0ah,"$"
NotANumber      db  "This is not a number!",0dh,0ah,0dh,0ah,"$"
OutOfRange      db  "Out of range!",0dh,0ah,0dh,0ah,"$"
Victory         db  "You won! How did you do that?",0dh,0ah,0dh,0ah,"$"
OverTen         db  "Over ten guesses? Lame!",0dh,0ah,0dh,0ah,"$"
PlayAgain       db  0dh,0ah,"Play again (Y/N)?$"
ThankYou        db  "Thank you for playing NumGuess ASM version!",0dh,0ah,"Copyright(C) 2000, DarthJDG",0dh,0ah,"$"

guesses         dw  0
num             dw  0
gnum            dw  0
ten             dw  10

PlayerName      db  "                                 "
Guess           db  "                                 "

   END