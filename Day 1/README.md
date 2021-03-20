# Variables, Simple data types, and String interpolation

March 20<sup>th</sup> 2021

## [Variables](https://www.hackingwithswift.com/quick-start/understanding-swift/why-does-swift-have-variables) and [Constant](https://www.hackingwithswift.com/sixty/1/6/constants)

Constants and variables must be declared before they’re used. You declare constants with the let keyword and variables with the var keyword. Here’s an example of how constants and variables can be used to track the number of login attempts a user has made:

~~~~
let maximumNumberOfLoginAttempts = 10
var currentLoginAttempt = 0
~~~~

This code can be read as:

>“Declare a new constant called maximumNumberOfLoginAttempts, and give it a value of 10. Then, declare a new variable called currentLoginAttempt, and give it an initial value of 0.”

In this example, the maximum number of allowed login attempts is declared as a constant, because the maximum value never changes. The current login attempt counter is declared as a variable, because this value must be incremented after each failed login attempt.

You can declare multiple constants or multiple variables on a single line, separated by commas:

~~~~
var x = 0.0, y = 0.0, z = 0.0
~~~~

> NOTE
>>If a stored value in your code won’t change, always declare it as a constant with the let keyword. Use variables only for storing values that need to be able to change.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

## [Strings](https://www.hackingwithswift.com/sixty/1/2/strings-and-integers)

Swift is what’s known as a type-safe language, which means that every variable must be of one specific type.

>NOTE
>>Swift’s String type is bridged with Foundation’s NSString class. Foundation also extends String to expose methods defined by NSString. This means, if you import Foundation, you can access those NSString methods on String without casting. For more information about using String with Foundation and Cocoa, see [Bridging Between String and NSString](https://developer.apple.com/documentation/swift/string#2919514).

## [Multiline Strings](https://www.hackingwithswift.com/sixty/1/3/multi-line-strings)

A multiline string literal includes all of the lines between its opening and closing quotation marks. The string begins on the first line after the opening quotation marks (""") and ends on the line before the closing quotation mark.
If you want to use line breaks to make your source code easier to read, but you don’t want the line breaks to be part of the string’s value, write a backslash (\) at the end of those lines:

~~~
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
~~~

However, if you write whitespace at the beginning of a line in addition to what’s before the closing quotation marks, that whitespace is included.

![Alt](https://docs.swift.org/swift-book/_images/multilineStringWhitespace_2x.png "Title")

## [String Interpolation](https://www.hackingwithswift.com/sixty/1/5/string-interpolation)

String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal. You can use string interpolation in both single-line and multiline string literals. Each item that you insert into the string literal is wrapped in a pair of parentheses, prefixed by a backslash (\):

~~~
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
// message is "3 times 2.5 is 7.5"
~~~

You can use extended string delimiters to create strings containing characters that would otherwise be treated as a string interpolation. For example:

~~~
print(#"Write an interpolated string in Swift using \(multiplier)."#)
// Prints "Write an interpolated string in Swift using \(multiplier)."
~~~

To use string interpolation inside a string that uses extended delimiters, match the number of number signs after the backslash to the number of number signs at the beginning and end of the string. For example:

~~~
print(#"6 times 7 is \#(6 * 7)."#)
// Prints "6 times 7 is 42."
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html)

## [Type Annotations](https://www.hackingwithswift.com/sixty/1/7/type-annotations)

You can be explicit about the type of your data rather than relying on Swift’s type inference, like this:

~~~
let album: String = "Reputation"
let year: Int = 1989
let height: Double = 1.78
let taylorRocks: Bool = true
~~~