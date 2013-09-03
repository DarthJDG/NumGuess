# NumGuess collection
*Number guessing games in multiple programming languages*

**Contents:**

1. What is NumGuess?
2. Programming languages and compilers
3. Guidelines
4. Notes
5. License and copyright

## 1. What is NumGuess?

This is a collection of small sample applications for multiple programming languages. While a simple hello world application works, a number guessing game demonstrates user input, basic output, generating a random number, simple logic and some maths as well.

The original programs have been written a long time ago in just a few minutes, and they should not be considered well written or good programming practices. Since then the project has received numerous contributions, both new programs and improvements. A development guideline has also been written to give you a consistent number guessing experience, regardless of which programming language you choose.

Originally published as part of a [short article at CodeBin](http://codebin.co.uk/blog/number-guessing-hello-world-games/).

## 2. Programming languages and compilers

- **libnumguess.js**: JavaScript library *(see notes)*
- **num_c64.bas**: Commodore Basic (C64)
- **num_domwindow.html**: DOM Window wrapper for JavaScript library
- **num_dos.c**: Borland C (compiles with 3.1 under DOS)
- **num_dos.cpp**: Borland C++ (compiles with 3.1 under DOS)
- **num_jquery.html**: HTML/jQuery wrapper for JavaScript library
- **num_node.js**: Node.js console wrapper for JavaScript library
- **num_oop.pas**: Turbo Pascal 6.0, FreePascal (OOP)
- **numguess.asm**: DOS x86 Assembly (compiles with TASM 3.1)
- **numguess.bas**: QBasic 1.0
- **numguess.bat**: Windows shell batch file (Windows 2000 onwards)
- **numguess.bf**: Brainfuck *(see notes)*
- **numguess.c**: C (compiles with GCC, *see notes*)
- **numguess.cpp**: C++ (compiles with GCC)
- **numguess.cs**: C# command line
- **NumGuess.j**: JVM bytecode (aka. "Java Assembly") for Jasmin
- **NumGuess.java**: Java (can be run from command line)
- **numguess.lua**: Lua terminal
- **numguess.pas**: Turbo Pascal 6.0, FreePascal
- **numguess.php**: PHP (CLI)
- **numguess.pl**: Perl
- **numguess.prg**: dBase IV
- **numguess.py**: Python terminal
- **numguess.rb**: Ruby (1.9.3+)
- **numguess.sh**: Bash script
- **numguess.tcl**: Tcl script
- **numguess.uvb**: UniVerse Basic (might work on other pick-likes)

## 3. Guidelines

With the increasing number of contributions, it has become necessary to define clear-cut coding standards to make sure all programs work in a consistent manner and give the best possible user experience while keeping the game simple. Please see the GUIDELINES file for more details.

If a program does not conform to the guidelines and doesn't qualify for an exception as a language limitation, it must be mentioned in the list below and explained in the notes section further down.

Non-compliant programs and features:

- **numguess.asm**: output formatting, variable names, default player name, custom limit, custom messages
- **numguess.bf**: almost everything *(see notes)*
- **NumGuess.j**: output formatting, default player name, default limit to 10 instead of looping, out of range message, custom messages

## 4. Notes

### Brainfuck

Due to the complexity of this version, it has no extra features at the moment. It is not yet optimised, I was just learning as I went along and refactoring is not the main strength of this language. It simply gives you a range of 1 to 100 to guess and exits when you have guessed correctly.

An interesting issue is that due to the simplicity of its design, there is no way to generate a random number in Brainfuck without input from the user. The program starts with asking for a random seed, which can be any number of characters. The program then creates a 1-byte checksum of the seed, and takes modulo 100 to get a "random" number. Pressing about 10 random keys on the keyboard should give a good enough seed unless you can sum up ASCII codes in real time. A more sophisticated hashing function could be implemented as a future improvement.

### C

Tested on CentOS. As the man page for ```log2``` states, needs to be compiled with ```-std=c99``` and linked with ```-lm``` when using GCC.

### Commodore Basic

Output formatting is a bit off in this version, due to the absence of lowercase characters and square brackets. Due to the limited number of characters in a line, a couple of extra linebreaks have been added. Furthermore, there doesn't seem to be a way to get rid of the question mark prompt when asking for input, so they are used in place of colons.

### JavaScript library

This one defines a NumGuessEngine framework that can be used by other implementations, so in itself it does not fulfill all the guidelines. It can be played from the browser console though by manually calling its methods.

## 5. License and copyright

These programs are available under GPL3, please see the LICENSE, COPYRIGHT and AUTHORS files for details. Not that anyone would want to use them commercially...
