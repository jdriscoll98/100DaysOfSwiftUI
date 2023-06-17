import Cocoa

//create a struct to store information about a car, including its model, number of seats, and current gear,
// then add a method to change gears up or down.
// Have a think about variables and access control: what data should be a variable rather than a constant, and what data should be exposed publicly? Should the gear-changing method validate its input somehow?


enum Direction {
    case up, down
}

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear = 0
    
    mutating func changeGear(direction: Direction) {
        if (direction == .up) {
            currentGear += 1
        } else if currentGear > 0 {
            currentGear -= 1
        }
    }
}

var newCar = Car(model: "Mazda", numberOfSeats: 4)

print(newCar.model)
newCar.changeGear(direction: .up)
print(newCar.currentGear)
