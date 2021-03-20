# Variables, Simple data types, and String interpolation

March 20<sup>th</sup> 2021

## [Arithmetic Operators](https://www.hackingwithswift.com/sixty/3/1/arithmetic-operators)

Operators are unary, binary, or ternary:

* *Unary operators operate on a single target (such as -a). Unary prefix operators appear immediately before their target (such as !b), and unary postfix operators appear immediately after their target (such as c!).
* Binary operators operate on two targets (such as 2 + 3) and are infix because they appear in between their two targets.
* [Ternary operators](https://www.hackingwithswift.com/sixty/3/7/the-ternary-operator) operate on three targets. Like C, Swift has only one ternary operator, the ternary conditional operator (a ? b : c).

The values that operators affect are operands. In the expression 1 + 2, the + symbol is a binary operator and its two operands are the values 1 and 2.

## [Operator Overloading](https://www.hackingwithswift.com/sixty/3/2/operator-overloading)

Swift supports operator overloading, which is a fancy way of saying that what an operator does depends on the values you use it with. For example, + sums integers like this:

~~~
let meaningOfLife = 42
let doubleMeaning = 42 + 42
~~~

But + also joins strings, like this:

~~~
let fakers = "Fakers gonna "
let action = fakers + "fake"
~~~

## [Compound Assignment Operators](https://www.hackingwithswift.com/sixty/3/3/compound-assignment-operators)

The assignment operator (a = b) initializes or updates the value of a with the value of b:

~~~
let b = 10
var a = 5
a = b
// a is now equal to 10
~~~

If the right side of the assignment is a tuple with multiple values, its elements can be decomposed into multiple constants or variables at once:

~~~
let (x, y) = (1, 2)
// x is equal to 1, and y is equal to 2
~~~

## [Comparison Operators](https://www.hackingwithswift.com/sixty/3/4/comparison-operators)

Swift supports the following comparison operators:

~~~
Equal to (a == b)
Not equal to (a != b)
Greater than (a > b)
Less than (a < b)
Greater than or equal to (a >= b)
Less than or equal to (a <= b)
~~~

>NOTE
>>Swift also provides two identity operators (=== and !==), which you use to test whether two object references both refer to the same object instance. For more information, see [Identity Operators](https://docs.swift.org/swift-book/LanguageGuide/ClassesAndStructures.html#ID90).

## [Logical Operators](https://www.hackingwithswift.com/sixty/3/9/range-operators)

Logical operators modify or combine the Boolean logic values true and false. Swift supports the three standard logical operators found in C-based languages:

* Logical NOT (!a)
* Logical AND (a && b)
* Logical OR (a || b)

## [Range Operators](https://www.hackingwithswift.com/sixty/3/6/combining-conditions)

#### **Closed Range Operator**
The closed range operator (a...b) defines a range that runs from a to b, and includes the values a and b. The value of a must not be greater than b.
#### **Half-Open Range Operator**
The half-open range operator (a..<b) defines a range that runs from a to b, but doesn’t include b.
#### **One-Sided Ranges**
The closed range operator has an alternative form for ranges that continue as far as possible in one direction—for example, a range that includes all the elements of an array from index 2 to the end of the array. In these cases, you can omit the value from one side of the range operator. This kind of range is called a one-sided range because the operator has a value on only one side. For example:

~~~
for name in names[2...] {
    print(name)
}
// Brian
// Jack

for name in names[...2] {
    print(name)
}
// Anna
// Alex
// Brian
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html)

## [Conditions](https://www.hackingwithswift.com/sixty/3/4/comparison-operators)

In its simplest form, the if statement has a single if condition. It executes a set of statements only if that condition is true.

~~~
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// Prints "It's very cold. Consider wearing a scarf."
~~~

## [Switch Statements](https://www.hackingwithswift.com/sixty/3/8/switch-statements)

In its simplest form, a switch statement compares a value against one or more values of the same type.

~~~
switch some value to consider {
case value 1:
    respond to value 1
case value 2,
     value 3:
    respond to value 2 or 3
default:
    otherwise, do something else
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/ControlFlow.html)