package main

import (
	"fmt"
	"bufio"
	"os"
	"strings"
	"time"
	"math"
	"math/rand"
)

func main() {
	var err error
	rand.Seed(time.Now().Unix())
	fmt.Printf("Welcome to NumGuess Go version!\n\n")

	print("Enter your name: ")
	name := readLine()
	if name == "" { name = "Player" }

	fmt.Printf("\nWelcome %v, enter upper limit: ", name)
	limit, _ := readInt(10)
	if limit < 10 { limit = 10 }
	maxTries := int(math.Log2(float64(limit))) + 1

	for {
		fmt.Printf("\nGuess my number between 1 and %v!\n\n", limit);
		tries, num := 0, rand.Intn(limit) + 1
		guess := 0

		for guess != num {
			fmt.Printf("Guess: ")
			guess, err = readInt(0)

			if err != nil {
				fmt.Printf("That's just plain wrong.\n")
			} else {
				if guess < 1 || guess > limit {
					fmt.Printf("Out of range.\n")
				} else {
					tries++
					switch {
						case guess < num: fmt.Printf("Too low!\n")
						case guess > num: fmt.Printf("Too high!\n")
					}
				}
			}
		}

		triesWord := "try"
		if tries != 1 { triesWord = "tries" }
		fmt.Printf("\nWell done %v, you guessed my number from %v %v!\n", name, tries, triesWord)

		switch {
			case tries == 1:
				fmt.Printf("You're one lucky bastard!")
			case tries < maxTries:
				fmt.Printf("You are the master of this game!")
			case tries == maxTries:
				fmt.Printf("You are a machine!")
			case tries <= int(float64(maxTries) * 1.1):
				fmt.Printf("Very good result!")
			case tries > limit:
				fmt.Printf("I find your lack of skill disturbing!")
			default:
				fmt.Printf("Try harder, you can do better!")
		}

		fmt.Printf("\nPlay again [y/N]? ")
		if strings.ToUpper(readLine()) != "Y" { break }
	}

	fmt.Printf("\nOkay, bye.")
}

// Reads a whole line from stdin
func readLine() string {
	reader := bufio.NewReader(os.Stdin)
	line, _ := reader.ReadString('\n')
	return strings.Trim(line, "\n\r")
}

func readInt(def int) (int, error) {
	reader := bufio.NewReader(os.Stdin)
	line, _ := reader.ReadString('\n')
	_, err := fmt.Sscan(strings.Trim(line, "\n\r"), &def)
	return def, err
}
