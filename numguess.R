##########################################################################################
##
## Use the "source" command in the R console to run this game! E.g.:
##
##   library(RCurl)
##   source(textConnection(
##     getURL('https://raw.githubusercontent.com/daroczig/NumGuess/master/numguess.R')))
##
##########################################################################################

## say hello
cat('\nWelcome to NumGuess R version!\n\n')

## get username
name <- readline('Enter your name: ')

## and set the default one if nothing was provided
if (name == '')
    name <- 'Player'

## get upper limit
limit <- readline(paste0('\nWelcome ', name, ', enter upper limit: '))
## validate limit
limit <- as.integer(limit)
if (xor(is.na(limit), limit < 10))
    limit <- 10

## maximum number of tries
max_tries <- floor(log2(limit)) + 1

## infinite loop
while (TRUE) {

    cat(sprintf('\nGuess my number between 1 and %d!\n\n', limit))

    ## generate a number between 1 and limit
    number <- sample(1:limit, 1)
    tries  <- 0

    ## internal loop for guessing
    while (TRUE) {

        ## ask for a number
        guess <- readline('Guess: ')

        ## validate guess
        guess <- as.integer(guess)
        if (is.na(guess)) {
            cat('That\'s just plain wrong.\n')
            next()
        }
        if (guess < 1 | guess > limit) {
            cat('Out of range.\n')
            next()
        }

        ## check if we have a winner
        tries <- tries + 1
        if (number == guess)
            break()
        if (number < guess)
            cat('Too high!\n')
        if (number > guess)
            cat('Too low!\n')

    }

    ## congrats
    cat(sprintf(
        '\nWell done %s, you guessed my number from %d %s!\n',
        name,
        tries,
        ifelse(tries == 1, 'try', 'tries')))

    ## custom message
    if (tries == 1)
        cm <- 'You\'re one lucky bastard!'
    if (tries < max_tries)
        cm <- 'You are the master of this game!'
    if (tries == max_tries)
        cm <- 'You are a machine!'
    if (tries > max_tries && tries < max_tries * 1.1)
        cm <- 'Very good result!'
    if (tries > max_tries * 1.1)
        cm <- 'Try harder, you can do better!'
    if (tries > limit)
        cm <- 'I find your lack of skill disturbing!'
    cat(cm, '\n')

    ## next round
    nr <- readline('Play again [y/N]?')
    if (nr != tolower('Y'))
        break()

}

## say goodbye
cat('\n\nOkay, bye.\n')
