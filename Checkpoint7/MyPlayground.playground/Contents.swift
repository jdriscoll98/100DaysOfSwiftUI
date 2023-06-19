import Cocoa

var greeting = "Hello, playground"

//Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.
//
//But there’s more:
//
//The Animal class should have a legs integer property that tracks how many legs the animal has.
//The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
//The Cat class should have a matching speak() method, again with each subclass printing something different.
//The Cat class should have an isTame Boolean property, provided using an initializer.

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    func speak() {
        print("Bark!")
    }
    
    init() {
        super.init(legs: 4)
    }
}

class Cat: Animal {
    var isTame: Bool = false
    func speak() {
        print("Meow!")
    }
    
    init(isTame: Bool)  {
        self.isTame = isTame
        super.init(legs: 4)
    }
}

class Corgi: Dog {
    override func speak() {
        print("Bark! I'm a corgi.")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Bark! I'm a poodle.")
    }
}

class Persian: Cat {
    override func speak() {
        print("Meow, I'm a persian")
    }
    
    init() {
        super.init(isTame: true)
    }
}

class Lion: Cat {
    override func speak() {
        print("Roar!")
    }
    
    init() {
        super.init(isTame: false)
    }
}

let dog = Dog()
dog.speak()
let cat = Cat(isTame: false)
cat.speak()
let corgi = Corgi()
corgi.speak()

let lion = Lion()
lion.speak()
print(lion.isTame)
let persian = Persian()
print(persian.isTame)
persian.speak()
