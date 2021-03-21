# Closures Part 1

March 21<sup>th</sup> 2021

## [Using closures as parameters when they accept parameters](https://www.hackingwithswift.com/sixty/6/6/using-closures-as-parameters-when-they-accept-parameters)

~~~
func travel(action: (String) -> Void) {
    print("I'm getting ready to go.")
    action("London")
    print("I arrived!")
}
~~~

When travel() is called using trailing closure syntax, the closure code is required to accept a string:

~~~
travel { (place: String) in
    print("I'm going to \(place) in my car")
}
~~~

## [Using closures as parameters when they return values](https://www.hackingwithswift.com/sixty/6/7/using-closures-as-parameters-when-they-return-values)

~~~
func travel(action: (String) -> String) {
    print("I'm getting ready to go.")
    let description = action("London")
    print(description)
    print("I arrived!")
}
~~~

When travel() is called using trailing closure syntax, the closure code is required to accept a string:

~~~
travel { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
~~~

## [Shorthand parameter names](https://www.hackingwithswift.com/sixty/6/8/shorthand-parameter-names)

Swift knows the parameter to that closure must be a string, so we can remove it:

~~~
travel { place -> String in
    return "I'm going to \(place) in my car"
}
~~~

It also knows the closure must return a string, so we can remove that:

~~~
travel { place in
    return "I'm going to \(place) in my car"
}
~~~

As the closure only has one line of code that must be the one that returns the value, so Swift lets us remove the return keyword too:

~~~
travel { place in
    "I'm going to \(place) in my car"
}
~~~

Swift has a shorthand syntax that lets you go even shorter. Rather than writing place in we can let Swift provide automatic names for the closure’s parameters. These are named with a dollar sign, then a number counting from 0.

~~~
travel {
    "I'm going to \($0) in my car"
}
~~~

## [Closures with multiple parameters](https://www.hackingwithswift.com/sixty/6/9/closures-with-multiple-parameters)

~~~
func travel(action: (String, Int) -> String) {
    print("I'm getting ready to go.")
    let description = action("London", 60)
    print(description)
    print("I arrived!")
}
~~~

Because this accepts two parameters, we’ll be getting both $0 and $1:

~~~
travel {
    "I'm going to \($0) at \($1) miles per hour."
}
~~~

## [Returning closures from functions](https://www.hackingwithswift.com/sixty/6/10/returning-closures-from-functions)

**travel()** function that accepts no parameters, but returns a closure. The closure that gets returned must be called with a string, and will return nothing.

~~~
func travel() -> (String) -> Void {
    return {
        print("I'm going to \($0)")
    }
}

let result = travel()
result("London")
~~~

## [Capturing values](https://www.hackingwithswift.com/sixty/6/11/capturing-values)

A closure can capture constants and variables from the surrounding context in which it’s defined. The closure can then refer to and modify the values of those constants and variables from within its body, even if the original scope that defined the constants and variables no longer exists.

Closure capturing happens if we create values in travel() that get used inside the closure. For example, we might want to track how often the returned closure is called:

~~~
func travel() -> (String) -> Void {
    var counter = 1

    return {
        print("\(counter). I'm going to \($0)")
        counter += 1
    }
}
~~~

Even though that counter variable was created inside travel(), it gets captured by the closure so it will still remain alive for that closure.

>NOTE
>>As an optimization, Swift may instead capture and store a copy of a value if that value isn’t mutated by a closure, and if the value isn’t mutated after the closure is created.
Swift also handles all memory management involved in disposing of variables when they’re no longer needed.

>NOTE
>>If you assign a closure to a property of a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the closure and the instance. Swift uses capture lists to break these strong reference cycles. For more information, see [Strong Reference Cycles for Closures](https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html#ID56).

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)