# Loops

March 20<sup>th</sup> 2021

## [For-In Loops](https://www.hackingwithswift.com/sixty/4/1/for-loops)

You use the for-in loop to iterate over a sequence, such as items in an array, ranges of numbers, or characters in a string.

This example uses a for-in loop to iterate over the items in an array:

~~~
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// Hello, Anna!
// Hello, Alex!
// Hello, Brian!
// Hello, Jack!
~~~

## [While Loops](https://www.hackingwithswift.com/sixty/4/2/while-loops)

A while loop starts by evaluating a single condition. If the condition is true, a set of statements is repeated until the condition becomes false.
Here’s the general form of a while loop:

~~~
while condition {
    statements
}
~~~

## [Repeat-While Loops](https://www.hackingwithswift.com/sixty/4/3/repeat-loops)

The other variation of the while loop, known as the repeat-while loop, performs a single pass through the loop block first, before considering the loop’s condition. It then continues to repeat the loop until the condition is false.

>NOTE
>>The repeat-while loop in Swift is analogous to a do-while loop in other languages.
Here’s the general form of a repeat-while loop:

~~~
repeat {
    statements
} while condition
~~~

## [Exiting Loops](https://www.hackingwithswift.com/sixty/4/4/exiting-loops)

You can exit a loop at any time using the break keyword.

## [Exiting Multiple Loops](https://www.hackingwithswift.com/sixty/4/5/exiting-multiple-loops)

If we wanted to exit part-way through we need to do two things. First, we give the outside loop a label, like this:

~~~
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
    }
}
~~~

Second, add our condition inside the inner loop, then use **break** outerLoop to exit both loops at the same time:

~~~
outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}
~~~

With a regular **break**, only the inner loop would be exited – the outer loop would continue where it left off.

## [Continue Loops](https://www.hackingwithswift.com/sixty/4/6/skipping-items)

The continue statement tells a loop to stop what it’s doing and start again at the beginning of the next iteration through the loop. It says “I am done with the current loop iteration” without leaving the loop altogether.

The following example removes all vowels and spaces from a lowercase string to create a cryptic puzzle phrase:

~~~
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// Prints "grtmndsthnklk"
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html)

>NOTE
>>Swift has built-in support for checking API availability, which ensures that you don’t accidentally use APIs that are unavailable on a given deployment target.

~~~
if #available(platform name version, ..., *) {
    statements to execute if the APIs are available
} else {
    fallback statements to execute if the APIs are unavailable
}
~~~