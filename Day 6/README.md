# Closures Part 1

March 21<sup>th</sup> 2021

## [Creating basic closures](https://www.hackingwithswift.com/sixty/6/1/creating-basic-closures)

Closures are self-contained blocks of functionality that can be passed around and used in your code. Closures in Swift are similar to blocks in C and Objective-C and to lambdas in other programming languages.

Closures can capture and store references to any constants and variables from the context in which they’re defined. This is known as closing over those constants and variables. Swift handles all of the memory management of capturing for you.

>NOTE
>>Don’t worry if you aren’t familiar with the concept of capturing. It’s explained in detail below in [Capturing Values](https://docs.swift.org/swift-book/LanguageGuide/Closures.html#ID103).

Closure expression syntax has the following general form:

~~~
{ (parameters) -> return type in
    statements
}
~~~

The parameters in closure expression syntax can be in-out parameters, but they can’t have a default value. Variadic parameters can be used if you name the variadic parameter. Tuples can also be used as parameter types and return types.

~~~
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
~~~

## [Accepting parameters in a closure](https://www.hackingwithswift.com/sixty/6/2/accepting-parameters-in-a-closure)

We could make a closure that accepts a **place name** string as its only parameter like this:

~~~
let driving = { (place: String) in
    print("I'm going to \(place) in my car")
}
~~~

One of the differences between functions and closures is that you don’t use parameter labels when running closures. So, to call driving() now we’d write this:

~~~
driving("London")
~~~

## [Returning values from a closure](https://www.hackingwithswift.com/sixty/6/3/returning-values-from-a-closure)

Closures can also return values, and they are written similarly to parameters: you write them inside your closure, directly before the in keyword.

Example for closure that returns a string, add **-> String** before **in**, then use return just like a normal function:

~~~
let drivingWithReturn = { (place: String) -> String in
    return "I'm going to \(place) in my car"
}
~~~

## [Closures as parameters](https://www.hackingwithswift.com/sixty/6/4/closures-as-parameters)

First, here’s our basic driving() closure again

~~~
let driving = {
    print("I'm driving in my car")
}
~~~

If we wanted to pass that closure into a function so it can be run inside that function, we would specify the parameter type as () -> Void. That means “accepts no parameters, and returns Void” – Swift’s way of saying “nothing”.

So, we can write a travel() function that accepts different kinds of traveling actions, and prints a message before and after:

~~~
func travel(action: () -> Void) {
    print("I'm getting ready to go.")
    action()
    print("I arrived!")
}

travel(action: driving)
~~~

## [Trailing closure](https://www.hackingwithswift.com/sixty/6/5/trailing-closure-syntax)

If you need to pass a closure expression to a function as the function’s final argument and the closure expression is long, it can be useful to write it as a trailing closure instead. You write a trailing closure after the function call’s parentheses, even though the trailing closure is still an argument to the function. When you use the trailing closure syntax, you don’t write the argument label for the first closure as part of the function call. A function call can include multiple trailing closures.

~~~
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)