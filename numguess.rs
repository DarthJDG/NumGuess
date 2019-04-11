extern crate rand;

use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {
    println!("guess a number:");

    let secret_number = rand::thread_rng().gen_range(10000, 99999);
    let mut tries = 0;

    loop {
        let mut guess = String::new();

        io::stdin().read_line(&mut guess)
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };
        tries = tries + 1;

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("higher"),
            Ordering::Greater => println!("lower"),
            Ordering::Equal => {
                println!("match found in {} tries", tries);
                break;
            }
        }
    }
}
