import System.IO
import System.Random

getName s = if length s == 0 then "Player" else s

getLimit :: String -> Int
getLimit [] = 10
getLimit s = max 10 (fst (readNumber s))

readNumber :: String -> (Int, Bool)
readNumber [] = (0, False)
readNumber s = if length r == 0 then readNumber [] else (fst (head r), True)
    where r = reads s :: [(Int, String)]

evaluate :: (Int, Bool) -> Int -> Int -> (String, Int, Bool)
evaluate (guess, valid) num limit
    | not valid              = ("That's just plain wrong.", 0, False)
    | num < 1 || num > limit = ("Out of range.", 0, False)
    | guess < num            = ("Too low!", 1, False)
    | guess > num            = ("Too high!", 1, False)
    | guess == num           = ("", 1, True)

customMessage :: Int -> Int -> String
customMessage tries limit
    | tries == 1          = "You're one lucky bastard!"
    | tries < maxTries    = "You are the master of this game!"
    | tries == maxTries   = "You are a machine!"
    | tries <= maxTries10 = "Very good result!"
    | tries <= limit      = "Try harder, you can do better!"
    | otherwise           = "I find your lack of skill disturbing!"
    where maxTries = floor (logBase 2 (fromIntegral limit)) + 1
          maxTries10 = floor (fromIntegral maxTries * 1.1)

playAgain :: String -> Bool
playAgain input
    | input == "Y" || input == "y" = True
    | otherwise                    = False

main = do
    hSetBuffering stdout NoBuffering
    putStr "Welcome to NumGuess Haskell version!\n\nEnter your name: "
    input <- getLine
    let name = getName input
    putStr ("\nWelcome " ++ name ++ ", enter upper limit: ")
    input <- getLine
    let limit = getLimit input
    play name limit

play name limit = do
    putStrLn ("\nGuess my number between 1 and " ++ show limit ++ "!\n")
    num <- randomRIO (1, limit)
    guess name limit num 0
    putStr "Play again [y/N]? "
    input <- getLine
    if playAgain input then
        play name limit
    else
        putStrLn "\nOkay, bye."

guess name limit num tries = do
    putStr "Guess: "
    input <- getLine
    let (message, add, finished) = evaluate (readNumber input) num limit
    putStrLn message
    if not finished then
        guess name limit num (tries + add)
    else do
        let t = tries + add
        putStr ("Well done " ++ name ++ ", you guessed my number from " ++ show t ++ " ")
        putStrLn (if t == 1 then "try!" else "tries!")
        putStrLn (customMessage t limit)
