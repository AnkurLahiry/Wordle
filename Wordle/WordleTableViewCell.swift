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
    
    @IBOutlet weak var textField: AppTextField! {
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
        guard let text = sender.text, text.count <= count else { return }
        stackview.arrangedSubviews.forEach({($0 as? AppLabel)?.text = nil})
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
    
    func executeWrongWord() {
        self.textField.isEnabled = true
        for case let view in stackview.arrangedSubviews where view is AppLabel {
            view.shake()
        }
    }
}

extension WordleTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard string.isEmpty else { return true }
        let allowedCharacter = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        if !allowedCharacter.isSuperset(of: characterSet) {
            return false
        }
        return range.location < 5
    }
}

class AppTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        false
    }

    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        []
    }

    override func caretRect(for position: UITextPosition) -> CGRect {
        .null
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
    
    func shakeAnimation() {
        self.shake()
    }
}

extension UIView {
    func shake(for duration: TimeInterval = 0.5, withTranslation translation: CGFloat = 10) {
        let propertyAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.3) {
            self.transform = CGAffineTransform(translationX: translation, y: 0)
        }
        
        propertyAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: 0.2)
        
        propertyAnimator.startAnimation()
    }
}
