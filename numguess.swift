import Foundation

// Reads a string from the terminal with an optional default value
func inputString(prompt: String, def: String = "") -> String {
	print(prompt + " ", terminator: "")
	fflush(__stdoutp)
	let handle = NSFileHandle.fileHandleWithStandardInput()
	let data = handle.availableData
	var result = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
	result = result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
	return result == "" ? def : result
}

// Reads a number from the terminal with an optional default and minimum value
func inputNumber(prompt: String, def: Int? = nil, min: Int? = nil) -> Int? {
	var value = Int(inputString(prompt))
	if value == nil { return def }
	if min != nil { value = value < min ? min : value }
	return value
}

// Returns a message to evaluate player performance
func getCustomMessage(num: Int, _ limit: Int, _ tries: Int) -> String {
	let maxTries = Int(log2(Double(limit))) + 1
	let maxTries10 = Int(Double(maxTries) * 1.1)

	switch tries {
	case 1:                     return "You're one lucky bastard!"
	case 2..<maxTries:          return "You are the master of this game!"
	case maxTries:              return "You are a machine!"
	case maxTries...maxTries10: return "Very good result!"
	case maxTries10...limit:    return "Try harder, you can do better!"
	default:                    return "I find your lack of skill disturbing!"
	}
}

// Seed the random generator
srandom(UInt32(time(nil)))

print("Welcome to NumGuess Swift version!\n")
var name = inputString("Enter your name:", def: "Player")
var limit = inputNumber("\nWelcome \(name), enter upper limit:", def: 10, min: 10)!

repeat {
	print("\nGuess my number between 1 and \(limit)!\n")
	var num = random() % limit + 1
	var tries = 0
	var guess : Int?

	repeat {
		guess = inputNumber("Guess:")

		switch guess {
		case nil:
			print("That's just plain wrong.")
		case let g? where 1...limit ~= g:
			tries += 1
			print(guess < num ? "Too low!" : "Too high!")
		default:
			print("Out of range.")
		}

	} while guess != num

	let triesWord = tries == 1 ? "try" : "tries"
	print("\nWell done \(name), you guessed my number from \(tries) \(triesWord)!")
	print(getCustomMessage(num, limit, tries))

} while "Y" == inputString("Play again [y/N]?").uppercaseString

print("\nOkay, bye.")

