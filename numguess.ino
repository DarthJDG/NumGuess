int limit = -1;
int number = -1;
int guess = -1;
int tries = -1;


void setup() {
  Serial.begin(9600);
  
  randomSeed(analogRead(0));
  number = random(1, 100);

  limit = 100;
  tries = 0;

  Serial.println("Welcome to NumGuess Arduino version!");
  Serial.print("Guess my number between 1 and ");
  Serial.print(limit);
  Serial.println("!");
}


void loop() {
  if(Serial.available()) {
    guess = Serial.readString().toInt();
    tries += 1;
    
    if(guess > limit or guess < 1) {
      Serial.println("Out of range.");
    }
    else if(guess < number) {
      Serial.println("Too low.");
    }
    else if(guess > number) {
      Serial.println("Too high.");
    }
    else {
      Serial.print("Well done, you guessed my number from ");
      Serial.print(tries);
      Serial.print(" ");
      
      if(tries == 1) {
        Serial.print("try");
      }
      else {
        Serial.print("tries");
      }
      Serial.println("!");
      Serial.println("Reset your Arduino to start a new game!");
    }
  }
}
