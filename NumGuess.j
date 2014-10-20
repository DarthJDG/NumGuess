.source NumGuess.j
.class public NumGuess
.super java/lang/Object

.field private static reader Ljava/io/BufferedReader;

; ================================
.method static public <clinit>()V
.limit stack 5

	; initialize static field "reader" with a BufferedReader
	; based on stdin

	new java/io/BufferedReader
	dup

	new java/io/InputStreamReader
	dup
	getstatic java/lang/System/in Ljava/io/InputStream;
	invokespecial java/io/InputStreamReader/<init>(Ljava/io/InputStream;)V

	invokespecial java/io/BufferedReader/<init>(Ljava/io/Reader;)V
	putstatic NumGuess/reader Ljava/io/BufferedReader;

	return

.end method

; =======================
.method public <init>()V

	aload_0
	invokenonvirtual java/lang/Object/<init>()V
	return

.end method


; ===============================================
.method public static main([Ljava/lang/String;)V
.throws java/lang/Exception
.limit stack 20
.limit locals 20

; display greeting

	ldc "Welcome to NumGuess Jasmin version!\n\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V


; get the player's name
; stored in local variable 11

	ldc "Enter your name: "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	invokestatic NumGuess/readString()Ljava/lang/String;
	astore 11


; check if empty length

	aload 11
	invokevirtual java/lang/String/length()I

	ifne NameOK
	ldc "Player"
	astore 11

NameOK:


; settings summary
	
	ldc "\nWelcome "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	aload 11
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	ldc ", enter upper limit: "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	invokestatic NumGuess/readInt()I
	dup
	ldc 10
	if_icmpge LimitOK

; use 10 if input is smaller
	
	pop
	ldc 10

LimitOK:

	; limit
	istore 12

; a single game starts here
PlayLoop:

; generate random number (in the range of 1-limit)
; stored in local variable 13

	invokestatic java/lang/Math/random()D
	iload 12
	i2d
	dmul
	d2i
	iconst_1
	iadd
	istore 13

; start message

	ldc "\nGuess my number between 1 and "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	iload 12
	invokestatic NumGuess/printInt(I)V

	ldc "!\n\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V

; guesses counted in local variable 14

	iconst_0
	istore 14

; a single guess (loop while no match)
GuessLoop:

        iload 12
	invokestatic NumGuess/readGuess(I)I

; increase guess count
	iinc 14 1

; get the difference
	iload 13
	isub

	dup

	ifge NumberGE
	pop
	ldc "Too low!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto GuessLoop

; greater or equal
NumberGE:

	ifle Win
	ldc "Too high!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto GuessLoop

; win - the numbers are matching
Win:

; display game summary

	ldc "\nWell done "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	; player name
	aload 11
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	ldc ", you guessed my number from "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	; guess count
	iload 14
	invokestatic NumGuess/printInt(I)V

	iload 14
	iconst_1
	if_icmpeq OneTry

	; multiple tries
	ldc " tries!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto CustomMessage

OneTry:
	; a single try
	ldc " try!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto CustomMessage

; display custom message
CustomMessage:

; calculate "max" and store it to local variable 15
	iload 12
	i2d
	invokestatic java/lang/Math/log(D)D
	iconst_2
	i2d
	invokestatic java/lang/Math/log(D)D
	ddiv
	d2i
	iconst_1
	iadd
	istore 15

	; keep guesses on stack for faster access (needs cleanup later)
	iload 14

	dup
	iconst_1
	if_icmpeq GuessCountOne
	dup
	iload 15
	if_icmplt GuessCountLessThanMax
	dup
	iload 15
	if_icmpeq GuessCountMax
	dup
	iload 15
	i2d
	ldc 1.1
	f2d
	dmul
	d2i
	if_icmple GuessCountMaxPlus
	dup
	iload 12
	if_icmple GuessCountLTELimit
	goto GuessCountMoreThanLimit


GuessCountOne:
	ldc "You're one lucky bastard!\n"
	goto DisplayCustomMessage

GuessCountLessThanMax:
	ldc "You are the master of this game!\n"
	goto DisplayCustomMessage

GuessCountMax:
	ldc "You are a machine!\n"
	goto DisplayCustomMessage

GuessCountMaxPlus:
	ldc "Very good result!\n"
	goto DisplayCustomMessage

GuessCountLTELimit:
	ldc "Try harder, you can do better!\n"
	goto DisplayCustomMessage

GuessCountMoreThanLimit:
	ldc "I find your lack of skill disturbing!\n"
	goto DisplayCustomMessage

DisplayCustomMessage:
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	; pop guesses from stack (cleanup)
	pop


; play again?
	ldc "Play again [y/N]? "
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	invokestatic NumGuess/readString()Ljava/lang/String;

; check if input is an empty string
	dup
	invokevirtual java/lang/String/length()I
	ifne CheckIfNot
	pop
	goto QuitGame

; check if first character of input is lower or upper case N
; please note: ifeq is executed on FALSE (as it converts to zero)
CheckIfNot:
	iconst_0
	iconst_1
	invokevirtual java/lang/String/substring(II)Ljava/lang/String;
	invokevirtual java/lang/String/toLowerCase()Ljava/lang/String;
	ldc "n"
	invokevirtual java/lang/String/equals(Ljava/lang/Object;)Z
	ifeq PlayLoop

QuitGame:
    ldc "\nOkay, bye.\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	
	return

.end method


; ===============================================
; method to read an integer
.method public static readGuess(I)I
.throws java/io/IOException
.limit stack 10
.limit locals 5
.catch java/lang/NumberFormatException from ReadIntTry to ReadIntCatch using ReadIntCatch

Read:
	ldc "Guess: "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	getstatic NumGuess/reader Ljava/io/BufferedReader;
	invokevirtual java/io/BufferedReader/readLine()Ljava/lang/String;

ReadIntTry:
	invokestatic java/lang/Integer/parseInt(Ljava/lang/String;)I
	goto ReadIntDone

ReadIntCatch:
	pop
	ldc "That's just plain wrong.\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
    goto Read

ReadIntDone:
    dup
    iconst_1
    if_icmplt OutOfRange
    dup
    iload_0
    if_icmpgt OutOfRange
    goto NumberOK

OutOfRange:
	ldc "Out of range.\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
    pop
    goto Read

NumberOK:
	ireturn

.end method


; ===============================================
; method to read an integer
.method public static readInt()I
.throws java/io/IOException
.limit stack 10
.limit locals 5
.catch java/lang/NumberFormatException from ReadIntTry to ReadIntCatch using ReadIntCatch

	getstatic NumGuess/reader Ljava/io/BufferedReader;
	invokevirtual java/io/BufferedReader/readLine()Ljava/lang/String;

ReadIntTry:
	invokestatic java/lang/Integer/parseInt(Ljava/lang/String;)I
	goto ReadIntDone

ReadIntCatch:
	pop
	iconst_0

ReadIntDone:
	ireturn

.end method


; ===============================================
; method to read a string
.method public static readString()Ljava/lang/String;
.throws java/io/IOException
.limit stack 10
.limit locals 5

	getstatic NumGuess/reader Ljava/io/BufferedReader;
	invokevirtual java/io/BufferedReader/readLine()Ljava/lang/String;
	areturn

.end method


; ===============================================
; method to output a string
.method public static printString(Ljava/lang/String;)V
.throws java/io/IOException
.limit stack 10
.limit locals 5

	getstatic java/lang/System/out Ljava/io/PrintStream;
	aload_0
	invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	return

.end method


; ===============================================
; method to output an integer
.method public static printInt(I)V
.throws java/io/IOException
.limit stack 10
.limit locals 5

	iload_0
	invokestatic java/lang/Integer/toString(I)Ljava/lang/String;
	getstatic java/lang/System/out Ljava/io/PrintStream;
	swap
	invokevirtual java/io/PrintStream/print(Ljava/lang/String;)V
	return

.end method
