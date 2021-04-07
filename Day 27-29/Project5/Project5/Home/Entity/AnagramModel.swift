//
//  AnagramModel.swift
//  Project5
//
//  Created by Fadhil Hanri on 07/04/21.
//

import Foundation

@propertyWrapper
struct ContentList {
    var value: [String]

    init(wrappedValue value: [String]) {
        self.value = value
    }

    func getContentList() -> [String] {
        guard let filepath = Bundle.main.path(forResource: "start", ofType: "txt"),
              let contents = try? String(contentsOfFile: filepath)
        else { return ["silkworm"] }
        
        return autoreleasepool { contents.components(separatedBy: "\n") }
    }
    
    var wrappedValue: [String] {
        get { getContentList() }
    }
}
