import Cocoa

//write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100.
//
func returnRandom(_ input: [Int]?) -> Int {
    return input?.randomElement() ?? Int.random(in: 1...100) // This is exactly like javascript.
}

print(returnRandom(nil))
print(returnRandom([1, 2]))
print(returnRandom(nil))
print(returnRandom([1, 2, 3, 4, 5]))
