//
//  TerminalViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 2/10/2023.
//

//
//  ViewController.swift
//
//  Created by Mohammad Farhan on 5/16/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

class TerminalViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Properties
    
    var presenter: TelnetPresenter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

// MARK: - TextView Helper

private extension TerminalViewController {
    
    func changeContentInsetOfTextView() {
        var inset: UIEdgeInsets = .zero
        inset.top = textView.bounds.size.height - textView.contentSize.height
        textView.contentInset = inset
        textView.scrollToBotom()
    }
    
    func append(toTextView text: String?) {
        textView.text = "\(textView.text ?? "")\(text ?? "")"
    }
}

// MARK: - Telnet Presentation

extension TerminalViewController: TelnetPresentation {
    
    func configure() {
        textField.isHidden = true
        textField.delegate = self
        textField.tintColor = .clear
    }
    
    func clearText() {
        textField.text = nil
    }
    
    func drop() {
        DispatchQueue.main.async(execute: {
            self.textView.text.removeLast()
        })
    }
    
    func append(text: String) {
        DispatchQueue.main.async(execute: {
            self.textField.becomeFirstResponder()
            self.append(toTextView: text)
            self.changeContentInsetOfTextView()
        })
    }
    
    func replace(text: String) {
        DispatchQueue.main.async(execute: {
            self.textView.text = text
        })
    }
    
    func setTextFieldEnabled(isEnabled: Bool) {
        DispatchQueue.main.async(execute: {
            self.textField.isEnabled = isEnabled
            self.textField.resignFirstResponder()
        })
    }
}

// MARK: - UITextField Delegate

extension TerminalViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        return presenter.shouldChangeTextIn(string)
    }
}

extension UITextView {
    
    func scrollToBotom() {
        let range = NSMakeRange(text.utf8.count - 1, 1);
        scrollRangeToVisible(range);
    }
    
}
