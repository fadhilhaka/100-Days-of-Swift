# Structs, Properties, and Methods

March 21<sup>st</sup> 2021

## [Creating your own structs](https://www.hackingwithswift.com/sixty/7/1/creating-your-own-structs)

Structures and classes have a similar definition syntax. You introduce structures with the struct keyword and classes with the class keyword. Both place their entire definition within a pair of braces:

~~~
struct SomeStructure {
    // structure definition goes here
}
~~~

>NOTE
>>Whenever you define a new structure or class, you define a new Swift type. Give types UpperCamelCase names (such as SomeStructure and SomeClass here) to match the capitalization of standard Swift types (such as String, Int, and Bool). Give properties and methods lowerCamelCase names (such as frameRate and incrementCount) to differentiate them from type names.

Here’s an example of a structure definition and a class definition:

~~~
struct Resolution {
    var width = 0
    var height = 0
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)

## [Computed properties](https://www.hackingwithswift.com/sixty/7/2/computed-properties)

In addition to stored properties, classes, structures, and enumerations can define computed properties, which don’t actually store a value. Instead, they provide a getter and an optional setter to retrieve and set other properties and values indirectly.

~~~
struct Sport {
    var name: String
    var isOlympicSport: Bool

    var olympicStatus: String {
        get { isOlympicSport ? "\(name) is an Olympic sport" : "\(name) is not an Olympic sport" }
    }
}
~~~

## [Property observers](https://www.hackingwithswift.com/sixty/7/3/property-observers)

Property observers observe and respond to changes in a property’s value. Property observers are called every time a property’s value is set, even if the new value is the same as the property’s current value.

You can add property observers in the following places:

* Stored properties that you define
* Stored properties that you inherit
* Computed properties that you inherit

You have the option to define either or both of these observers on a property:

1. willSet is called just before the value is stored.
2. didSet is called immediately after the new value is stored.

~~~
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
stepCounter.totalSteps = 896
// About to set totalSteps to 896
// Added 536 steps
~~~

>NOTE
>>The willSet and didSet observers of superclass properties are called when a property is set in a subclass initializer, after the superclass initializer has been called. They aren’t called while a class is setting its own properties, before the superclass initializer has been called.
For more information about initializer delegation, see [Initializer Delegation for Value Types](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID215) and [Initializer Delegation for Class Types](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html#ID219).

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Properties.html#ID259)

## [Methods](https://www.hackingwithswift.com/sixty/7/4/methods)

Methods are functions that are associated with a particular type. Classes, structures, and enumerations can all define instance methods, which encapsulate specific tasks and functionality for working with an instance of a given type.

~~~
struct City {
    var population: Int

    func collectTaxes() -> Int {
        return population * 1000
    }
}

let london = City(population: 9_000_000)
london.collectTaxes()
~~~

## [Mutating methods](https://www.hackingwithswift.com/sixty/7/5/mutating-methods)

Mutating methods can assign an entirely new instance to the implicit self property.

When you want to change a property inside a method, you need to mark it using the mutating keyword, like this:

~~~
struct Person {
    var name: String

    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}
~~~

Because it changes the property, Swift will only allow that method to be called on Person instances that are variables:

~~~
var person = Person(name: "Ed")
person.makeAnonymous()
~~~

## [Properties and methods of strings](https://www.hackingwithswift.com/sixty/7/6/properties-and-methods-of-strings)

We’ve used lots of strings so far, and it turns out they are structs – they have their own methods and properties we can use to query and manipulate the string.

First, let’s create a test string:

~~~
let string = "Do or do not, there is no try."
~~~

You can read the number of characters in a string using its count property:

~~~
print(string.count)
~~~

Strings have lots more properties and methods – try typing string. to bring up Xcode’s code completion options.

## [Properties and methods of arrays](https://www.hackingwithswift.com/sixty/7/7/properties-and-methods-of-arrays)

Arrays are also structs, which means they too have their own methods and properties we can use to query and manipulate the array.

Here’s a simple array to get us started:

~~~
var toys = ["Woody"]
~~~

You can read the number of items in an array using its count property:

~~~
print(toys.count)
~~~

Arrays have lots more properties and methods – try typing toys. to bring up Xcode’s code completion options.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Methods.html)