import Cocoa

//make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:
//
//A property storing how many rooms it has.
//A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
//A property storing the name of the estate agent responsible for selling the building.
//A method for printing the sales summary of the building, describing what it is along with its other properties.

protocol Building {
    var rooms: Int { get set }
    var cost: Double { get set }
    var agentName: String { get set }
    func printSummary() -> Void;
}

extension Building {
    func printSummary() {
        print("Cost: \(self.cost)\n Number of rooms: \(self.rooms)\n Agent: \(self.agentName)")
    }
}

struct House: Building {
    var rooms: Int
    var cost: Double;
    var agentName: String
    
    func printSummary() {
        print("A house.\n Cost: \(self.cost)\n Number of rooms: \(self.rooms)\n Agent: \(self.agentName)")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Double
    var agentName: String
    func printSummary() {
        print("An office.\n Cost: \(self.cost)\n Number of rooms: \(self.rooms)\n Agent: \(self.agentName)")
    }
}

let house: House = House(rooms: 4, cost: 100_000, agentName: "Jack")
house.printSummary()

let office: Office = Office(rooms: 4, cost: 250_000, agentName: "Jill")
office.printSummary()
