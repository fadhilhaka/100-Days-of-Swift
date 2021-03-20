# Functions, Parameters, and Errors

March 20<sup>th</sup> 2021

## [Writing functions](https://www.hackingwithswift.com/sixty/5/1/writing-functions)

When you define a function, you can optionally define one or more named, typed values that the function takes as input, known as [parameters](https://www.hackingwithswift.com/sixty/5/2/accepting-parameters). You can also optionally define a type of value that the function will pass back as output when it’s done, known as its [return type](https://www.hackingwithswift.com/sixty/5/3/returning-values).
The function in the example below is called greet(person:), because that’s what it does—it takes a person’s name as input and returns a greeting for that person. To accomplish this, you define one input parameter—a String value called person—and a return type of String, which will contain a greeting for that person:

~~~
func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}
~~~

## [Specifying Argument Labels](https://www.hackingwithswift.com/sixty/5/4/parameter-labels)

You write an argument label before the parameter name, separated by a space.
Here’s a variation of the greet(person:) function that takes a person’s name and hometown and returns a greeting:

~~~
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
print(greet(person: "Bill", from: "Cupertino"))
// Prints "Hello Bill!  Glad you could visit from Cupertino."
~~~

## [Omitting Argument Labels](https://www.hackingwithswift.com/sixty/5/5/omitting-parameter-labels)

If you don’t want an argument label for a parameter, write an underscore (_) instead of an explicit argument label for that parameter.

~~~
func someFunction(_ firstParameterName: Int, secondParameterName: Int) {
    // In the function body, firstParameterName and secondParameterName
    // refer to the argument values for the first and second parameters.
}
someFunction(1, secondParameterName: 2)
~~~

If a parameter has an argument label, the argument must be labeled when you call the function.

## [Default Parameter Values](https://www.hackingwithswift.com/sixty/5/6/default-parameters)

You can define a default value for any parameter in a function by assigning a value to the parameter after that parameter’s type. If a default value is defined, you can omit that parameter when calling the function.

~~~
func someFunction(parameterWithoutDefault: Int, parameterWithDefault: Int = 12) {
    // If you omit the second argument when calling this function, then
    // the value of parameterWithDefault is 12 inside the function body.
}
someFunction(parameterWithoutDefault: 3, parameterWithDefault: 6) // parameterWithDefault is 6
someFunction(parameterWithoutDefault: 4) // parameterWithDefault is 12
~~~

## [Variadic Parameters](https://www.hackingwithswift.com/sixty/5/7/variadic-functions)

A variadic parameter accepts zero or more values of a specified type. You use a variadic parameter to specify that the parameter can be passed a varying number of input values when the function is called. Write variadic parameters by inserting three period characters (...) after the parameter’s type name.

~~~
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
~~~

## [In-Out Parameters](https://www.hackingwithswift.com/sixty/5/10/inout-parameters)

If you want a function to modify a parameter’s value, and you want those changes to persist after the function call has ended, define that parameter as an in-out parameter instead.
You write an in-out parameter by placing the inout keyword right before a parameter’s type. An in-out parameter has a value that’s passed in to the function, is modified by the function, and is passed back out of the function to replace the original value. For a detailed discussion of the behavior of in-out parameters and associated compiler optimizations, see [In-Out Parameters](https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID545).

~~~
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
~~~

>NOTE
>>In-out parameters can’t have default values, and variadic parameters can’t be marked as inout.

## [Throwing Functions](https://www.hackingwithswift.com/sixty/5/8/writing-throwing-functions)

To indicate that a function, method, or initializer can throw an error, you write the throws keyword in the function’s declaration after its parameters. A function marked with throws is called a throwing function. If the function specifies a return type, you write the throws keyword before the return arrow (->).

~~~
func canThrowErrors() throws -> String

func cannotThrowErrors() -> String
~~~

A throwing function propagates errors that are thrown inside of it to the scope from which it’s called.

>NOTE
>>Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.

## [Handling Errors Using Do-Catch](https://www.hackingwithswift.com/sixty/5/9/running-throwing-functions)

You use a do-catch statement to handle errors by running a block of code. If an error is thrown by the code in the do clause, it’s matched against the catch clauses to determine which one of them can handle the error.
Here is the general form of a do-catch statement:

~~~
do {
    try expression
    statements
} catch pattern 1 {
    statements
} catch pattern 2 where condition {
    statements
} catch pattern 3, pattern 4 where condition {
    statements
} catch {
    statements
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)