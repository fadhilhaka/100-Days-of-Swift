# Protocols, Extensions, and Protocol extensions

March 21<sup>th</sup> 2021

## [Protocols](https://www.hackingwithswift.com/sixty/9/1/protocols)

A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

~~~
protocol Identifiable {
    var id: String { get set }
}

struct User: Identifiable {
    var id: String
}
~~~

## [Protocol inheritance](https://www.hackingwithswift.com/sixty/9/2/protocol-inheritance)

~~~
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}
~~~

We can now create a single Employee protocol that brings them together in one protocol. We don’t need to add anything on top, so we’ll just write open and close braces:

~~~
protocol Employee: Payable, NeedsTraining, HasVacation { }
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)

## [Extensions](https://www.hackingwithswift.com/sixty/9/3/extensions)

Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you don’t have access to the original source code (known as retroactive modeling).

Extensions in Swift can:

* Add computed instance properties and computed type properties
* Define instance methods and type methods
* Provide new initializers
* Define subscripts
* Define and use new nested types
* Make an existing type conform to a protocol

>NOTE
>>Extensions can add new functionality to a type, but they can’t override existing functionality.

~~~
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
number.squared()
~~~

Swift doesn’t let you add stored properties in extensions, so you must use computed properties instead. For example, we could add a new isEven computed property to integers that returns true if it holds an even number:

~~~
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Extensions.html)

## [Protocol extensions](https://www.hackingwithswift.com/sixty/9/4/protocol-extensions)

Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.

For example, the RandomNumberGenerator protocol can be extended to provide a randomBool() method, which uses the result of the required random() method to return a random Bool value:

~~~
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
~~~

By creating an extension on the protocol, all conforming types automatically gain this method implementation without any additional modification.

~~~
let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
// Prints "Here's a random number: 0.3746499199817101"
print("And here's a random Boolean: \(generator.randomBool())")
// Prints "And here's a random Boolean: true"
~~~

## [Protocol-oriented programming](https://www.hackingwithswift.com/sixty/9/5/protocol-oriented-programming)

Protocol extensions can provide default implementations for our own protocol methods. This makes it easy for types to conform to a protocol, and allows a technique called “protocol-oriented programming” – crafting your code around protocols and protocol extensions.

First, here’s a protocol called Identifiable that requires any conforming type to have an id property and an identify() method:

~~~
protocol Identifiable {
    var id: String { get set }
    func identify()
}
~~~

We could make every conforming type write their own identify() method, but protocol extensions allow us to provide a default:

~~~
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}
~~~

Now when we create a type that conforms to Identifiable it gets identify() automatically:

~~~
struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Protocols.html)