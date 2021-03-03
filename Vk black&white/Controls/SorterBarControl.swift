//
//  SorterBarControl.swift
//  Vk black&white
//
//  Created by Macbook on 13.12.2020.
//

import UIKit

class SorterBarControl: UIControl {
    var letters = [String]() {
        didSet {
            setupView()
        }
    }
    
    private var letterButtons = [UIButton]()
    
    private var stackView = UIStackView()
    var choosedLetter = ""
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        isUserInteractionEnabled = true
        
        self.letterButtons.removeAll()
        for letter in letters {
            let button = UIButton(type: .system)
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.white, for: .selected)
            //button.frame = CGRect(x: 0, y: 0, width: 15, height: 10)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            self.letterButtons.append(button)
        }
        
        stackView.removeFromSuperview()
        stackView = UIStackView(arrangedSubviews: self.letterButtons)
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.frame = CGRect(x: 0, y: 0, width: 20, height: 15 * letters.count)
        stackView.spacing = 1
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        
        }
    
    @objc private func selectLetter(_ sender: UIButton) {
        if let index = letterButtons.firstIndex(of: sender) {
            choosedLetter = letters[index]
            sendActions(for: .valueChanged)
        }
    }
}
