# Classes and Inheritance

March 21<sup>st</sup> 2021

## [Creating your own classes](https://www.hackingwithswift.com/sixty/8/1/creating-your-own-classes)

Classes have additional capabilities that structures don’t have:

* Inheritance enables one class to inherit the characteristics of another.
* Type casting enables you to check and interpret the type of a class instance at runtime.
* Deinitializers enable an instance of a class to free up any resources it has assigned.
* Reference counting allows more than one reference to a class instance.

~~~
class Dog {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}

let poppy = Dog(name: "Poppy", breed: "Poodle")
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)

## [Class inheritance](https://www.hackingwithswift.com/sixty/8/2/class-inheritance)

A class can inherit methods, properties, and other characteristics from another class. When one class inherits from another, the inheriting class is known as a subclass, and the class it inherits from is known as its superclass.

>NOTE
>>Swift classes don’t inherit from a universal base class. Classes you define without specifying a superclass automatically become base classes for you to build upon.

~~~
class Poodle: Dog {
    init(name: String) {
        super.init(name: name, breed: "Poodle")
    }
}
~~~

For safety reasons, Swift always makes you call super.init() from child classes – just in case the parent class does some important work when it’s created.

## [Overriding methods](https://www.hackingwithswift.com/sixty/8/3/overriding-methods)

A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.

~~~
class Dog {
    func makeNoise() {
        print("Woof!")
    }
}

class Poodle: Dog {
    override func makeNoise() {
        print("Yip!")
    }
}
~~~

## [Final classes](https://www.hackingwithswift.com/sixty/8/4/final-classes)

You can prevent a method, property, or subscript from being overridden by marking it as final. Do this by writing the final modifier before the method, property, or subscript’s introducer keyword (such as final var, final func, final class func, and final subscript).

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html)

## [Copying objects](https://www.hackingwithswift.com/sixty/8/5/copying-objects)

Structures and Enumerations are a value type and Classes are a reference type.
When you copy a struct, both the original and the copy are different things – changing one won’t change the other. When you copy a class, both the original and the copy point to the same thing, so changing one does change the other.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html)

## [Deinitializers](https://www.hackingwithswift.com/sixty/8/6/deinitializers)

A deinitializer is called immediately before a class instance is deallocated. You write deinitializers with the deinit keyword, similar to how initializers are written with the init keyword. Deinitializers are only available on class types.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Deinitialization.html)

## [Mutability](https://www.hackingwithswift.com/sixty/8/7/mutability)

Classes don’t need the mutating keyword with methods that change properties; that’s only needed with structs.

~~~
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)
