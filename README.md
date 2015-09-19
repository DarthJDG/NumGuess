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

[Visit the NumGuess project page](http://codebin.co.uk/projects/numguess/)

## 2. Programming languages and compilers

- **libnumguess.js**: JavaScript library *(see notes)*
- **num_286.asm**: DOS 286 Assembly (compiles with TASM 3.0 and MASM 6.11)
- **num_386.asm**: DOS 386 Assembly (compiles with TASM 3.0 and MASM 6.11)
- **num_c64.bas**: Commodore Basic (C64, *see notes*)
- **num_domwindow.html**: DOM Window wrapper for JavaScript library
- **num_dos.c**: Borland C (compiles with 3.1 under DOS)
- **num_dos.cpp**: Borland C++ (compiles with 3.1 under DOS)
- **num_jquery.html**: HTML/jQuery wrapper for JavaScript library
- **num_node.js**: Node.js console wrapper for JavaScript library
- **num_oop.pas**: Turbo Pascal 6.0, FreePascal (OOP)
- **numguess.awk**: AWK script
- **numguess.bas**: QBasic 1.0
- **numguess.bat**: Windows shell batch file (Windows 2000 onwards)
- **numguess.bf**: Brainfuck *(see notes)*
- **numguess.c**: C (compiles with GCC, *see notes*)
- **numguess.cpp**: C++ (compiles with GCC)
- **numguess.cr**: [Crystal](http://crystal-lang.org/) *(see notes)*
- **numguess.cs**: C# command line
- **numguess.d**: [D Programming Language](http://dlang.org)
- **numguess.dart**: Google Dart console
- **numguess.fal**: [Falcon](http://falconpl.org)
- **numguess.fs**: F# command line
- **numguess.go**: [The Go Programming Language](http://golang.org)
- **NumGuess.hx**: [Haxe](http://haxe.org/)
- **NumGuess.j**: JVM bytecode (aka. "Java Assembly") for Jasmin
- **NumGuess.java**: Java (can be run from command line)
- **numguess.lua**: Lua terminal
- **numguess.pas**: Turbo Pascal 6.0, FreePascal
- **numguess.php**: PHP (CLI)
- **numguess.pl**: Perl
- **numguess.prg**: dBase IV
- **numguess.ps1**: Windows PowerShell script
- **numguess.py**: Python terminal
- **numguess.R**: [R](http://r-project.org) script
- **numguess.rb**: Ruby (1.9.3+)
- **numguess.sh**: Bash script
- **numguess.tcl**: Tcl script
- **numguess.uvb**: UniVerse Basic (might work on other pick-likes)
- **numguess.vb**: VB.NET command line
- **numguess.vbs**: VBScript (Windows Script Host, *see notes*)
- **numguess.wsf**: JScript (Windows Script Host, *see notes*)

## 3. Guidelines

With the increasing number of contributions, it has become necessary to define clear-cut coding standards to make sure all programs work in a consistent manner and give the best possible user experience while keeping the game simple. Please see the GUIDELINES file for more details.

If a program does not conform to the guidelines and doesn't qualify for an exception as a language limitation, it must be mentioned in the list below and explained in the notes section further down.

Non-compliant programs and features:

- **numguess.bf**: almost everything *(see notes)*

## 4. Notes

### Brainfuck

Due to the complexity of this version, it has no extra features at the moment. It is not yet optimised, I was just learning as I went along and refactoring is not the main strength of this language. It simply gives you a range of 1 to 100 to guess and exits when you have guessed correctly.

An interesting issue is that due to the simplicity of its design, there is no way to generate a random number in Brainfuck without input from the user. The program starts with asking for a random seed, which can be any number of characters. The program then creates a 1-byte checksum of the seed, and takes modulo 100 to get a "random" number. Pressing about 10 random keys on the keyboard should give a good enough seed unless you can sum up ASCII codes in real time. A more sophisticated hashing function could be implemented as a future improvement.

### C

Tested on CentOS. As the man page for ```log2``` states, needs to be compiled with ```-std=c99``` and linked with ```-lm``` when using GCC.

### Commodore Basic

Output formatting is a bit off in this version, due to the absence of lowercase characters and square brackets. Due to the limited number of characters in a line, a couple of extra linebreaks have been added. Furthermore, there doesn't seem to be a way to get rid of the question mark prompt when asking for input, so they are used in place of colons.

### Crystal

The project is still in alpha stage, compiled and tested with version 0.7.7. If the compiler becomes more forgiving about nullable types, the code could be optimised a bit (e.g. inputNumber could just return Nil on invalid input instead of a tuple).

### JavaScript library

This one defines a NumGuessEngine framework that can be used by other implementations, so in itself it does not fulfill all the guidelines. It can be played from the browser console though by manually calling its methods.

### VBScript

To run the fully compliant console version under Windows, run ```cscript numguess.vbs``` from the command line. Alternatively, you can use pop up windows instead of the console (similar to the DOM window JavaScript wrapper) by either double-clicking on the program file or running ```wscript numguess.vbs```.

### JScript

JScript has no input box implemented for ```wscript```, it had to be invoked from VBScript code. This is why the code is embedded in XML and the file extension is ```.wsf```. The JScript part can be run as a simple ```.js``` file with ```cscript```.

The code uses the compatible JavaScript library. See VBScript version above for running instructions.

## 5. License and copyright

These programs are available under GPL3, please see the LICENSE, COPYRIGHT and AUTHORS files for details. Not that anyone would want to use them commercially...
