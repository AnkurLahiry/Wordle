//
//  WordleTableViewCell.swift
//  Wordle
//
//  Created by Ankur on 22/1/22.
//

import UIKit

class WordleTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "WordleTableViewCell"
    
    class Callback {
        var didFillup: (String) -> Void = { _ in }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet private weak var stackview: UIStackView!
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var count: Int = 5
    var callback = Callback()
    
    @IBAction func textFieldDidChangeEditing(_ sender: UITextField) {
        guard let text = sender.text else { return }
        for (index, char) in text.enumerated() {
            (stackview.arrangedSubviews[index] as? AppLabel)?.text = String(char).capitalized
        }
        if text.count == count {
            textField.isEnabled = false
            callback.didFillup(text)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        for _ in 0..<count {
            let view = AppLabel()
            stackview.addArrangedSubview(view)
        }
    }
    
    func updateView(with array: [Color]) {
        for (index, element) in array.enumerated() {
            if let label = stackview.arrangedSubviews[index] as? AppLabel {
                label.flip(color: element)
            }
        }
    }
}

extension WordleTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacter = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacter.isSuperset(of: characterSet) {
            return false
        }
        return true
    }
}

extension UITextField {
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
}

class AppLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 5.0
    }
    
    func flip(color: Color) {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            self.backgroundColor = color.color
            self.textColor = .white
        })
    }
}
