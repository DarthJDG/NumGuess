open System

// Random generator
let rnd = Random()
let random n = rnd.Next(n) + 1

// Reads a string from the console with default value
let read def =
    let s = Console.ReadLine()
    if s = "" then def else s

// Reads an int from the console
let readInt def =
    try
        (int (read ""), true)
    with
        | ex -> (def, false)

// Returns a message if guess is high or low
let highOrLow guess number =
    if fst guess < number then "Too low!"
    elif fst guess > number then "Too high!"
    else ""

// Returns custom message
let message tries limit =
    let max_tries = int (floor (log (float limit) / log 2.0)) + 1
    if tries = 1 then "You're one lucky bastard!"
    elif tries < max_tries then "You are the master of this game!"
    elif tries = max_tries then "You are a machine!"
    elif tries <= int (float max_tries * 1.1) then "Very good result!"
    elif tries <= limit then "Try harder, you can do better!"
    else "I find your lack of skill disturbing!"

// Main program
printf "Welcome to NumGuess F# version!\n\nEnter your name: "
let name = read "Player"

printf "\nWelcome %s, enter upper limit: " name
let limit = max (fst (readInt 10)) 10

let mutable again = true
while again do
    let mutable tries = 0
    let mutable guess = (0, true)
    let mutable number = random limit
    printfn "\nGuess my number between 1 and %d!\n" limit
    while number <> fst guess do
        printf "Guess: "
        guess <- readInt 0
        if not (snd guess) then
            printfn "That's just plain wrong."
        elif fst guess > limit || fst guess < 1 then
            printfn "Out of range."
        else
            tries <- tries + 1
            printfn "%s" (highOrLow guess number)
    printfn "Well done %s, you guessed my number from %d %s!" name tries (if tries = 1 then "try" else "tries")
    printfn "%s" (message tries limit)
    printf "Play again [y/N]? "
    again <- (read "y").ToLower() = "y"
printfn "\nOkay, bye."
