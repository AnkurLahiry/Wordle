//
//  WordleViewModel.swift
//  Wordle
//
//  Created by Ankur on 27/1/22.
//

import Foundation

class WordleViewModel {
    let originalString: String
    
    var count = 0
    
    init(originalString: String) {
        self.originalString = originalString.uppercased()
    }
    
    func compare(with input: String) throws -> [Color] {
        try WordleManager.shared.compare(with: input.uppercased())
    }
}
