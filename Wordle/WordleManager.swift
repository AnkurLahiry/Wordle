//
//  WordleManager.swift
//  Wordle
//
//  Created by Ankur on 27/1/22.
//

import Foundation
import UIKit

enum WordleError: Error {
    case wordNotFound
}

class WordleManager {
    static let shared = WordleManager()
    private var words: [String] = [String]()
    private(set) var selectedWord: String = ""
    
    private init() { }
    
    func fetchWords() {
        DispatchQueue.global(qos: .background).async {
            guard let path = Bundle.main.path(forResource: "Wordlist", ofType: "txt") else { return }
            guard let string = try? String(contentsOfFile: path, encoding: String.Encoding.utf8) else { return }
            self.words = string.components(separatedBy: .whitespacesAndNewlines).filter({$0.count == 5})
            self.words = self.words.map({ word in
                word.uppercased()
            })
        }
    }
    
    func selectRandomWord(completion: @escaping (Bool) -> Void) {
        guard let random = words.randomElement() else {
            completion(false)
            return
        }
        self.selectedWord = random.uppercased()
        print(self.selectedWord)
        completion(true)
    }
    
    func compare(with givenWord: String) throws -> [Color] {
        var result: [Color] = Array(repeating: .black, count: givenWord.count)
        guard !selectedWord.isEmpty else { return result }
        guard words.contains(givenWord) else {
            throw WordleError.wordNotFound
        }
        
        let selectedWordArray = Array(selectedWord)
        for (index, word) in givenWord.enumerated() {
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
