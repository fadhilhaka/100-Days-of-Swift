# Variables, Simple data types, and String interpolation

March 20<sup>th</sup> 2021

## [Arrays](https://www.hackingwithswift.com/sixty/2/1/arrays)

An array stores values of the same type in an ordered list. The same value can appear in an array multiple times at different positions.

>NOTE
>>Swift’s Array type is bridged to Foundation’s NSArray class.
For more information about using Array with Foundation and Cocoa, see [Bridging Between Array and NSArray](https://developer.apple.com/documentation/swift/array#2846730).

## [Sets](https://www.hackingwithswift.com/sixty/2/2/sets)

A set stores distinct values of the same type in a collection with no defined ordering. You can use a set instead of an array when the order of items isn’t important, or when you need to ensure that an item only appears once.

>NOTE
>>Swift’s Set type is bridged to Foundation’s NSSet class.
For more information about using Set with Foundation and Cocoa, see [Bridging Between Set and NSSet](https://developer.apple.com/documentation/swift/set#2845530).

## [Dictionaries](https://www.hackingwithswift.com/sixty/2/5/dictionaries)

A dictionary stores associations between keys of the same type and values of the same type in a collection with no defined ordering. Each value is associated with a unique key, which acts as an identifier for that value within the dictionary. Unlike items in an array, items in a dictionary don’t have a specified order. You use a dictionary when you need to look up values based on their identifier, in much the same way that a real-world dictionary is used to look up the definition for a particular word.

>NOTE
>>Swift’s Dictionary type is bridged to Foundation’s NSDictionary class.
For more information about using Dictionary with Foundation and Cocoa, see [Bridging Between Dictionary and NSDictionary](https://developer.apple.com/documentation/swift/dictionary#2846239).

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)

## [Dictionary Default Values](https://www.hackingwithswift.com/sixty/2/5/dictionaries)

~~~
let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Charlotte", default: "Unknown"]
~~~

## [Tuples](https://www.hackingwithswift.com/sixty/2/3/tuples)

A tuple type is a comma-separated list of types, enclosed in parentheses.
When an element of a tuple type has a name, that name is part of the type.

~~~
var someTuple = (top: 10, bottom: 12)  // someTuple is of type (top: Int, bottom: Int)
someTuple = (top: 4, bottom: 42) // OK: names match
someTuple = (9, 99)              // OK: names are inferred
someTuple = (left: 5, right: 5)  // Error: names don't match
~~~

All tuple types contain two or more types, except for Void which is a type alias for the empty tuple type, ().

[Swift documentation](https://docs.swift.org/swift-book/ReferenceManual/Types.html#ID448)

## [Enumerations](https://www.hackingwithswift.com/sixty/2/8/enumerations)

An enumeration defines a common type for a group of related values and enables you to work with those values in a type-safe way within your code.
Multiple cases can appear on a single line, separated by commas:

~~~
enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead = CompassPoint.west
~~~

## [Enumerations Associated Values](https://www.hackingwithswift.com/sixty/2/9/enum-associated-values)

In Swift, an enumeration to define product barcodes of either type might look like this:

~~~
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
~~~

This can be read as:

>“Define an enumeration type called Barcode, which can take either a value of upc with an associated value of type (Int, Int, Int, Int), or a value of qrCode with an associated value of type String.”

## [Enumerations Raw Values](https://www.hackingwithswift.com/sixty/2/10/enum-raw-values)

As an alternative to associated values, enumeration cases can come prepopulated with default values (called raw values), which are all of the same type.
Here’s an example that stores raw ASCII values alongside named enumeration cases:

~~~
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)
