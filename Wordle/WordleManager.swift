//
//  WordleManager.swift
//  Wordle
//
//  Created by Ankur on 27/1/22.
//

import Foundation
import UIKit

class WordleManager {
    static let shared = WordleManager()
    
    private let words: [String] = [String]()
    private(set) var selectedWord: String = "Hello".uppercased()
    
    private init() { }
    
    func fetchWords() {
        // fetch words ....
    }
    
    func compare(with words: String) -> [Color] {
        var result: [Color] = Array(repeating: .black, count: words.count)
        let selectedWordArray = Array(selectedWord)
        for (index, word) in words.enumerated() {
            if word == selectedWordArray[index] {
                result[index] = .green
                continue
            }
            if selectedWordArray.contains(word) {
                result[index] = .yellow
            }
        }
        return result
    }
}

enum Color: Equatable {
    case green, black, yellow
    
    var color: UIColor {
        switch self {
        case .yellow:
            return UIColor(red: 181/255, green: 159/255, blue: 59/255, alpha: 1)
        case .black:
            return .black
        case .green:
            return .green
        }
    }
}
