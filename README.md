# NumGuess collection
*Number guessing games in multiple programming languages*

Contents:

1. What is NumGuess?
2. Guidelines
3. Programming languages and compilers
4. Features
5. Notes
6. License and copyright

## 1. What is NumGuess?

This is a collection of little sample applications for multiple programming languages. While a small hello world application works, a simple number guessing game shows user input, basic output, generating a random number and simple logic as well.

These programs have been written a long time ago, and mostly in just a few minutes. In no way should they be considered well written or good programming practices. Published as part of the [short article at CodeBin](http://codebin.co.uk/blog/number-guessing-hello-world-games/).

## 2. Guidelines

With the increasing number of contributions, it has become necessary to define clear-cut coding standards to make sure all programs work in a consistent manner and give the best possible user experience while keeping the game simple. Please see the GUIDELINES file for more details.

If a program does not conform to the guidelines and doesn't qualify for an exception as a language limitation, it must be mentioned in the notes section in this file.

## 3. Programming languages and compilers

- **num_c64.bas**: C64 Basic
- **num_dos.c**: Borland C (compiles with 3.1 under DOS)
- **num_dos.cpp**: Borland C++ (compiles with 3.1 under DOS)
- **num_oop.pas**: Turbo Pascal 6.0 OOP
- **numguess.asm**: DOS x86 Assembly (compiles with TASM 3.1)
- **numguess.bas**: QBasic 1.0
- **numguess.bat**: Windows shell batch file (Windows 2000 onwards)
- **numguess.bf**: Brainfuck *(see notes)*
- **numguess.c**: C (compiles with GCC)
- **numguess.cpp**: C++ (compiles with GCC)
- **numguess.cs**: C# command line
- **NumGuess.j**: JVM bytecode (aka. "Java Assembly") for Jasmin
- **NumGuess.java**: Java (can be run from command line)
- **numguess.js**: Javascript
- **numguess.lua**: Lua terminal
- **numguess.pas**: Turbo Pascal 6.0
- **numguess.php**: PHP (CLI)
- **numguess.pl**: Perl
- **numguess.prg**: dBase IV
- **numguess.py**: Python terminal
- **numguess.uvb**: UniVerse Basic (might work on other pick-likes)

## 4. Features

- **num_c64.bas**: restart, guesses, limit, min10
- **num_dos.c**: guesses, limit, min10
- **num_dos.cpp**: guesses, limit, min10
- **num_oop.pas**: guesses, limit, min10
- **numguess.asm**: restart, name, guesses, message
- **numguess.bas**: restart, guesses, limit
- **numguess.bat**: restart, name, guesses, limit, min10
- **numguess.bf**: none *(see notes)*
- **numguess.c**: guesses, limit, min10
- **numguess.cpp**: guesses, limit, min10
- **numguess.cs**: restart, name, guesses, limit, min10
- **NumGuess.j**: restart, name, guesses, limit, min10
- **NumGuess.java**: restart, name, guesses, limit, min10
- **numguess.js**: restart, name, guesses, limit, min10
- **numguess.lua**: restart, name, guesses, limit, min10
- **numguess.pas**: guesses, limit, min10
- **numguess.php**: restart, name, guesses, message, limit, min10
- **numguess.pl**: restart, name, guesses, limit, min10
- **numguess.prg**: guesses
- **numguess.py**: restart, name, guesses, limit, min10
- **numguess.uvb**: restart, name, guesses, limit, min10

Feature descriptions:

- *restart*: Asks if you want to play again.
- *name*: Asks for player name.
- *guesses*: Shows number of guesses.
- *message*: Show customised message depending on number of guesses.
- *limit*: Asks for upper limit.
- *min10*: Upper limit must be at least 10 when asked.

## 5. Notes

### Brainfuck

Due to the complexity of this version, it has no extra features at the moment. It is not yet optimised, I was just learning as I went along and refactoring is not the main strength of this language. It simply gives you a range of 1 to 100 to guess and exits when you have guessed correctly.

An interesting issue is that due to the simplicity of its design, there is no way to generate a random number in Brainfuck without input from the user. The program starts with asking for a random seed, which can be any number of characters. The program then creates a 1-byte checksum of the seed, and takes modulo 100 to get a "random" number. Pressing about 10 random keys on the keyboard should give a good enough seed unless you can sum up ASCII codes in real time. A more sophisticated hashing function could be implemented as a future improvement.

### C

Tested on CentOS. As the man page for *log2* states, needs to be compiled with ```-std=c99``` and linked with ```-lm``` when using GCC.

## 6. License and copyright

These programs are available under GPL3, please see the LICENSE, COPYRIGHT and AUTHORS files for details. Not that anyone would want to use them commercially...
