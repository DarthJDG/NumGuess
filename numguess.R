##########################################################################################
##
## Use the "source" command in the R console to run this game! E.g.:
##
##   library(RCurl)
##   source(textConnection(
##     getURL('https://raw.githubusercontent.com/DarthJDG/NumGuess/master/numguess.R')))
##
##########################################################################################

#' Transform string into integer
#' @param x character vector
#' @return integer
int <- function(x)
    suppressWarnings(ifelse(as.numeric(x) == as.integer(x), as.integer(x), NA))
#' Cat sprintf results with ending line-break
#' @param fmt "character vector of format strings" to be passed to \code{sprintf}
#' @param ... values to be passed to \code{sprintf}
catsn <- function(fmt, ...)
    cat(sprintf(fmt, ...), '\n')

## say hello
catsn('Welcome to NumGuess R version!\n')

## get username
name <- readline('Enter your name: ')

## and set the default one if nothing was provided
if (name == '')
    name <- 'Player'

## get upper limit
limit <- readline(sprintf('\nWelcome %s, enter upper limit: ', name))

## validate limit
limit <- int(limit)
if (is.na(limit) || limit < 10)
    limit <- 10L

## maximum number of tries
max_tries <- floor(log2(limit)) + 1

## infinite loop
while (TRUE) {

    catsn('\nGuess my number between 1 and %d!\n', limit)

    ## generate a number between 1 and limit
    number <- sample(1:limit, 1)
    tries  <- 0

    ## internal loop for guessing
    while (TRUE) {

        ## ask for a number
        guess <- readline('Guess: ')

        ## validate guess
        guess <- int(guess)
        if (is.na(guess)) {
            catsn('That\'s just plain wrong.')
            next()
        }
        if (guess < 1 | guess > limit) {
            catsn('Out of range.')
            next()
        }

        ## check if we have a winner
        tries <- tries + 1
        if (number == guess)
            break()
        if (number < guess)
            catsn('Too high!')
        if (number > guess)
            catsn('Too low!')

    }

    ## congrats
    catsn(
        '\nWell done %s, you guessed my number from %d %s!',
        name,
        tries,
        ifelse(tries == 1, 'try', 'tries'))

    ## custom message
    cm <- ifelse(
        tries == 1,
        'You\'re one lucky bastard!',
        ifelse(
            tries < max_tries,
            'You are the master of this game!',
            ifelse(
                tries == max_tries,
                'You are a machine!',
                ifelse(
                    tries < max_tries * 1.1,
                    'Very good result!',
                    ifelse(
                        tries < limit,
                        'Try harder, you can do better!',
                        'I find your lack of skill disturbing!'
                    )
                )
            )
        )
    )
    catsn(cm)

    ## next round
    nr <- readline('Play again [y/N]? ')
    if (tolower(nr) != 'y')
        break()

}

## say goodbye
catsn('\nOkay, bye.')
