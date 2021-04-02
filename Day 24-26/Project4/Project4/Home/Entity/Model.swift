//
//  Model.swift
//  Project4
//
//  Created by Fadhil Hanri on 02/04/21.
//

enum Website: String, CaseIterable {
    case apple = "apple.com"
    case hackingWithSwift = "hackingwithswift.com"
    case hundredDaysOfSwift = "github.com/fadhilhaka/100-Days-of-Swift"
}

@propertyWrapper
struct Title {
    var value: String

    init(wrappedValue value: String) {
        self.value = value
    }
    
    func getTitleFormat(value: String) -> String {
        var formattedValue = value.prefix(1).capitalized + value.dropFirst()
        
        for char in formattedValue {
            if char.isUppercase {
                formattedValue = formattedValue.replacingOccurrences(of: String(char), with: " " + String(char))
            }
        }
        
        return formattedValue
    }

    var wrappedValue: String {
        get { getTitleFormat(value: value) }
    }
}

struct WebsiteDetail {
    let path: String
    let type: Website
    
    @Title
    var title: String
}
