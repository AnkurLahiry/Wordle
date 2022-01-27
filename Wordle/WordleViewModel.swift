//
//  WordleViewModel.swift
//  Wordle
//
//  Created by Ankur on 27/1/22.
//

import Foundation

class WordleViewModel {
    let originalString: String
    
    init(originalString: String) {
        self.originalString = originalString.uppercased()
    }
    
    func compare(with input: String) -> [Color] {
        WordleManager.shared.compare(with: input.uppercased())
    }
}
