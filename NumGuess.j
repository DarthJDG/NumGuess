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

	ldc "Welcome to NumGuess written in Jasmin!\n\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V

; get the player's name
; stored in local variable 11

	ldc "Please enter your name: "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	invokestatic NumGuess/readString()Ljava/lang/String;
	astore 11

; get the maximum value (repeat while less than 10)
; stored in local variable 12
GetMaxLoop:

	ldc "Limit (min 10): "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	invokestatic NumGuess/readInt()I
	dup
	istore 12

	bipush 10
	if_icmplt GetMaxLoop


; a single game starts here
PlayLoop:

; generate random number (in the range of 1-max)
; stored in local variable 13

	invokestatic java/lang/Math/random()D
	iload 12
	i2d
	dmul
	d2i
	iconst_1
	iadd
	istore 13

; guesses counted in local variable 14
	iconst_0
	istore 14

; a single guess (loop while no match)
GuessLoop:

	ldc "Guess: "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	invokestatic NumGuess/readInt()I

; increase guess count
	iinc 14 1
	
; get the difference
	iload 13
	isub

	dup

	ifge NumberGE
	pop
	ldc "Too Low!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto GuessLoop

; greater or equal
NumberGE:

	ifle Win
	ldc "Too High!\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	goto GuessLoop

; win - the numbers are matching
Win:

; display game summary

	ldc "Congratulations, "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	; player name
	aload 11
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	ldc "! It took "
	invokestatic NumGuess/printString(Ljava/lang/String;)V

	; guess count
	iload 14 
	invokestatic NumGuess/printInt(I)V

	ldc " guesses.\n"
	invokestatic NumGuess/printString(Ljava/lang/String;)V


; play again?
	ldc "Would you like to play again? (Y/n) "
	invokestatic NumGuess/printString(Ljava/lang/String;)V
	invokestatic NumGuess/readString()Ljava/lang/String;

; check if input is an empty string
	dup
	invokevirtual java/lang/String/length()I
	ifne CheckIfNot
	pop
	goto PlayLoop

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
	
	return

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
