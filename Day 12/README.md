# Optionals, Unwrapping, and Typecasting

March 21<sup>th</sup> 2021

## [Handling missing data](https://www.hackingwithswift.com/sixty/10/1/handling-missing-data)

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

>NOTE
>>The concept of optionals doesn’t exist in C or Objective-C. The nearest thing in Objective-C is the ability to return nil from a method that would otherwise return an object, with nil meaning “the absence of a valid object.” However, this only works for objects—it doesn’t work for structures, basic C types, or enumeration values. For these types, Objective-C methods typically return a special value (such as NSNotFound) to indicate the absence of a value. This approach assumes that the method’s caller knows there’s a special value to test against and remembers to check for it. Swift’s optionals let you indicate the absence of a value for any type at all, without the need for special constants.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID330)

## [Unwrapping optionals](https://www.hackingwithswift.com/sixty/10/2/unwrapping-optionals)

**If Statements and Forced Unwrapping**
  
If an optional has a value, it’s considered to be “not equal to” nil:

~~~
if convertedNumber != nil {
    print("convertedNumber has an integer value of \(convertedNumber!).")
}
// Prints "convertedNumber has an integer value of 123."
~~~

**Optional Binding**
Write an optional binding for an if statement as follows:

~~~
if let constantName = someOptional {
    statements
}
~~~

You can rewrite the possibleNumber example from the Optionals section to use optional binding rather than forced unwrapping:

~~~
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
// Prints "The string "123" has an integer value of 123"
~~~

## [Unwrapping with guard](https://www.hackingwithswift.com/sixty/10/3/unwrapping-with-guard)

An alternative to if let is guard let, which also unwraps optionals. guard let will unwrap an optional for you, but if it finds nil inside it expects you to exit the function, loop, or condition you used it in.

~~~
func greet(_ name: String?) {
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }

    print("Hello, \(unwrapped)!")
}
~~~

## [Force unwrapping](https://www.hackingwithswift.com/sixty/10/4/force-unwrapping)

~~~
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // requires an exclamation point
~~~

## [Implicitly unwrapped optionals](https://www.hackingwithswift.com/sixty/10/5/implicitly-unwrapped-optionals)

>NOTE
>>Don’t use an implicitly unwrapped optional when there’s a possibility of a variable becoming nil at a later point. Always use a normal optional type if you need to check for a nil value during the lifetime of a variable.

## [Nil coalescing](https://www.hackingwithswift.com/sixty/10/6/nil-coalescing)

~~~
let user = username(for: 15) ?? "Anonymous"
~~~

That will check the result that comes back from the username() function: if it’s a string then it will be unwrapped and placed into user, but if it has nil inside then “Anonymous” will be used instead.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html#ID330)

## [Optional chaining](https://www.hackingwithswift.com/sixty/10/7/optional-chaining)

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

~~~
let names = ["John", "Paul", "George", "Ringo"]

let beatle = names.first?.uppercased()
~~~

>NOTE
>>Optional chaining in Swift is similar to messaging nil in Objective-C, but in a way that works for any type, and that can be checked for success or failure.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/OptionalChaining.html)

## [Optional try](https://www.hackingwithswift.com/sixty/10/8/optional-try)

~~~
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }

    return true
}
~~~

Using try? we can run checkPassword() like this:

~~~
if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("D'oh.")
}
~~~

The other alternative is try!, which you can use when you know for sure that the function will not fail. If the function does throw an error, your code will crash.

Using try! we can rewrite the code to this:

~~~
try! checkPassword("sekrit")
print("OK!")
~~~

## [Failable initializers](https://www.hackingwithswift.com/sixty/10/9/failable-initializers)

~~~
struct Person {
    var id: String

    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}
~~~

## [Typecasting](https://www.hackingwithswift.com/sixty/10/10/typecasting)

Type casting is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.

Type casting in Swift is implemented with the **is** and **as** operators. These two operators provide a simple and expressive way to check the type of a value or cast a value to a different type.

~~~
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/TypeCasting.html)