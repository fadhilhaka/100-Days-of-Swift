# Access control, Static properties, and Laziness

March 21<sup>st</sup> 2021

## [Initializers](https://www.hackingwithswift.com/sixty/7/8/initializers)

Initializers are called to create a new instance of a particular type. In its simplest form, an initializer is like an instance method with no parameters, written using the init keyword:

~~~
init() {
    // perform some initialization here
}
~~~

## [Referring to the current instance](https://www.hackingwithswift.com/sixty/7/9/referring-to-the-current-instance)

Inside methods you get a special constant called self, which points to whatever instance of the struct is currently being used. This self value is particularly useful when you create initializers that have the same parameter names as your property.

~~~
struct Person {
    var name: String

    init(name: String) {
        print("\(name) was born!")
        self.name = name
    }
}
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)

## [Lazy properties](https://www.hackingwithswift.com/sixty/7/10/lazy-properties)

A lazy stored property is a property whose initial value isn’t calculated until the first time it’s used. You indicate a lazy stored property by writing the lazy modifier before its declaration.

~~~
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // the DataManager class would provide data management functionality here
}
~~~

>NOTE
>>You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore can’t be declared as lazy.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)

## [Static properties and methods](https://www.hackingwithswift.com/sixty/7/11/static-properties-and-methods)

~~~
struct Student {
    static var classSize = 0
    var name: String

    init(name: String) {
        self.name = name
        Student.classSize += 1
    }
}
~~~

Because the classSize property belongs to the struct itself rather than instances of the struct, we need to read it using Student.classSize:

~~~
print(Student.classSize)
~~~

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/Methods.html)

## [Access control](https://www.hackingwithswift.com/sixty/7/12/access-control)

Access control restricts access to parts of your code from code in other source files and modules. This feature enables you to hide the implementation details of your code, and to specify a preferred interface through which that code can be accessed and used.

Swift provides five different access levels for entities within your code.

* **Open** access and **public** access enable entities to be used within any source file from their defining module, and also in a source file from another module that imports the defining module. You typically use open or public access when specifying the public interface to a framework. The difference between open and public access is described below.
* **Internal** access enables entities to be used within any source file from their defining module, but not in any source file outside of that module. You typically use internal access when defining an app’s or a framework’s internal structure.
* **File-private** access restricts the use of an entity to its own defining source file. Use file-private access to hide the implementation details of a specific piece of functionality when those details are used within an entire file.
* **Private** access restricts the use of an entity to the enclosing declaration, and to extensions of that declaration that are in the same file. Use private access to hide the implementation details of a specific piece of functionality when those details are used only within a single declaration.

[Swift documentation](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)