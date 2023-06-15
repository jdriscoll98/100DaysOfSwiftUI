import Cocoa

var greeting = "Hello, playground"

func stringsContainSameLetters(string1: String, string2: String) -> Bool {
    if (string1.count != string2.count){
        return false
    }
    
    return string1.sorted() == string2.sorted()
}

//print(stringsContainSameLetters(string1: "abc", string2: "bca"))
//print(stringsContainSameLetters(string1: "abc", string2: "dbe"))


func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

//print(pythagoras(a: 3, b: 4))

// write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number.

// You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
// If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
// You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
// If you can’t find the square root, throw a “no root” error.

enum MathError: Error {
    case outOfBounds, noRoot;
}

func intSqrRoot(_ number: Int) throws -> Int {
    if (number < 1 || number > 10_000) {
        throw MathError.outOfBounds
    }
    
    for i in 1...100 {
        if ((i * i) == number) {
            return i;
        }
        else if (i > number / 2) {
            throw MathError.noRoot;
        }
    }
    
    throw MathError.noRoot;
}

let num = 9999; // change this to try different things.
do  {
   let sqrRoot = try intSqrRoot(num)
    print(sqrRoot)
} catch MathError.outOfBounds {
    print("Out of bounds!")
} catch (MathError.noRoot) {
    print("No int root found.")
} catch {
    print("Unknown Erorr.")
}


