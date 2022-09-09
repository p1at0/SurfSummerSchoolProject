//
//  CustomTextField.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import Foundation
import UIKit


final class CustomTextField: UIView {
    
    //MARK: - Properties
    
    var text: String? {
        return textField.text
    }
    
    //MARK: - Views
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = .systemFont(ofSize: 16, weight: .medium)
        tf.isHidden = true
        return tf
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.titleForTextField
        label.isHidden = true
        return label
    }()
    
    private let bottomLine: UIView = {
        let line = UIView()
        line.translatesAutoresizingMaskIntoConstraints = false
        line.backgroundColor = Color.bottomLine
        return line
    }()
    
    private let firstResponderButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(Color.titleForTextField, for: .normal)
        button.configuration = .none
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.insetsLayoutMarginsFromSafeArea = true
        return button
    }()
    
    private lazy var securityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Icon.noSecurityMode, for: .normal)
        button.setImage(Icon.securityMode, for: .selected)
        button.tintColor = Color.eye
        button.addTarget(self, action: #selector(tappedSecurityButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Internal methods
    
    func setDelegate(_ delegate: UITextFieldDelegate, tag: Int) {
        textField.delegate = delegate
        textField.tag = tag
    }
    
    func configure(title: String, isPassword: Bool = false) {
        titleLabel.text = title
        firstResponderButton.setTitle(title, for: .normal)
        if isPassword {
            configureSecurityButton()
        }
    }
    
    func endEditingWithEmptyTextField() {
        configureOriginalView()
    }
    
    func incorrectFillingTextField() {
        bottomLine.backgroundColor = Color.warningBottomLineRed
    }
    
    func correctFillingTextField() {
        bottomLine.backgroundColor = Color.bottomLine
    }
    
    func isTextFieldEmpty() -> Bool {
        return textField.text?.isEmpty ?? false
    }
}

//MARK: - Private methods

private extension CustomTextField {
    
    func configureAppearance() {
        configureView()
        configureTextField()
        configureBottomLine()
        configureTitleLabel()
        configureFirstResponderButton()
    }
    
    @objc func tappedFirstResponder() {
        firstResponderButton.isHidden = true
        textField.isHidden = false
        titleLabel.isHidden = false
        textField.becomeFirstResponder()
    }
    
    @objc func tappedSecurityButton() {
        textField.isSecureTextEntry.toggle()
        securityButton.isSelected.toggle()
    }
    
    func configureView() {
        layer.cornerRadius = 10
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundColor = Color.textFieldBackground
    }
    
    func configureTextField() {
        addSubview(textField)
        NSLayoutConstraint.activate([textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
                                     textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44),
                                     textField.topAnchor.constraint(equalTo: topAnchor, constant: 22)])
    }
    
    func configureFirstResponderButton() {
        firstResponderButton.addTarget(self, action: #selector(tappedFirstResponder), for: .touchUpInside)
        addSubview(firstResponderButton)
        NSLayoutConstraint.activate([firstResponderButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
                                     firstResponderButton.topAnchor.constraint(equalTo: topAnchor),
                                     firstResponderButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     firstResponderButton.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    func configureTitleLabel() {
        addSubview(titleLabel)
        NSLayoutConstraint.activate([titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
                                     titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 20),
                                     titleLabel.widthAnchor.constraint(equalToConstant: 50)])
    }
    
    func configureBottomLine() {
        addSubview(bottomLine)
        NSLayoutConstraint.activate([bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     bottomLine.heightAnchor.constraint(equalToConstant: 1)])
    }
    
    func configureSecurityButton() {
        addSubview(securityButton)
        NSLayoutConstraint.activate([securityButton.heightAnchor.constraint(equalToConstant: 24),
                                     securityButton.widthAnchor.constraint(equalToConstant: 24),
                                     securityButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
                                     securityButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)])
        
    }
    
    func configureOriginalView() {
        firstResponderButton.isHidden = false
        textField.isHidden = true
        titleLabel.isHidden = true
    }
}
