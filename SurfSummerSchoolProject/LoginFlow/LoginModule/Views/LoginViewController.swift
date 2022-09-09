//
//  LoginViewController.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 19/08/22.
//

import UIKit

final class LoginViewController: UIViewController {
    
    //MARK: - Properties
    
    var presenter: LoginViewOutput?
    
    //MARK: - Views
    
    private let loginTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.configure(title: "Логин")
        tf.textField.keyboardType = .phonePad
        
        return tf
    }()
    
    private lazy var loginWarningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Поле не может быть пустым"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.warningBottomLineRed
        label.isHidden = true
        
        return label
    }()
    
    private let passwordTextField: CustomTextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.configure(title: "Пароль", isPassword: true)
        tf.textField.keyboardType = .alphabet
        tf.textField.autocorrectionType = .no
        
        return tf
    }()
    
    private lazy var passwordWarningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Поле не может быть пустым"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Color.warningBottomLineRed
        label.isHidden = true
        
        return label
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        button.configuration = .none
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("Войти", for: .normal)
        
        return button
    }()
    
    private lazy var warningView: WarningView = {
        let view = WarningView()
        view.alpha = 0
        return view
    }()
    
    private lazy var spinnerView: SpinnerView = {
        let spinnerView = SpinnerView()
        spinnerView.isHidden = true
        return spinnerView
    }()
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView(image: Icon.backgroundLogo)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Вход"
        configureAppearance()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingTextField))
        view.addGestureRecognizer(tapGesture)
    }
}

//MARK: - Private methods

private extension LoginViewController {
    func configureAppearance() {
        configureLoginTextFieldConstraint()
        configureLoginWarningLabelConstraint()
        configurePasswordTextFieldConstraint()
        configurePasswordWarningLabelConstraint()
        configureLoginButtonConstraint()
        configureWarningViewConstraint()
        configureSpinnerViewConstraint()
        configureBackgroundImageView()
    }
    
    func showWarningView(errorDescription: String? = nil) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.warningView.alpha = 1
        }
        warningView.configure(errorDescription: errorDescription)
        navigationItem.titleView = UIView()
    }
    
    func hideWarningView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn) {
            self.warningView.alpha = 0
        }
        navigationItem.titleView = nil
    }
    
    @objc func tappedLoginButton() {
        self.validateTextField()
        
        guard let phone = loginTextField.text,
              let password = passwordTextField.text else {
            return
        }
        if loginWarningLabel.isHidden && passwordWarningLabel.isHidden {
            let clearPhoneNumber = PhoneMask().clearPhoneNumber(phoneNumber: phone)
            startLoading()
            presenter?.performLogin(phone: clearPhoneNumber, password: password)
        }
    }
    
    @objc func endEditingTextField() {
        view.endEditing(true)
    }
    
    func configureView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditingTextField))
        view.addGestureRecognizer(tapGesture)
    }
    
    func configureLoginTextFieldConstraint() {
        view.addSubview(loginTextField)
        loginTextField.setDelegate(self, tag: 1)
        NSLayoutConstraint.activate([loginTextField.heightAnchor.constraint(equalToConstant: 55),
                                     loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     loginTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
                                     loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                                     loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)])
    }
    
    func configureLoginWarningLabelConstraint() {
        view.addSubview(loginWarningLabel)
        NSLayoutConstraint.activate([loginWarningLabel.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
                                     loginWarningLabel.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 8)])
    }
    
    func configurePasswordTextFieldConstraint() {
        view.addSubview(passwordTextField)
        passwordTextField.setDelegate(self, tag: 2)
        NSLayoutConstraint.activate([passwordTextField.heightAnchor.constraint(equalToConstant: 55),
                                     passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     passwordTextField.topAnchor.constraint(equalTo: loginWarningLabel.bottomAnchor, constant: 16),
                                     passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
                                     passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor)])
    }
    
    func configurePasswordWarningLabelConstraint() {
        view.addSubview(passwordWarningLabel)
        NSLayoutConstraint.activate([passwordWarningLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                                     passwordWarningLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8)])
    }
    
    func configureLoginButtonConstraint() {
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        NSLayoutConstraint.activate([loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                                     loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
                                     loginButton.topAnchor.constraint(equalTo: passwordWarningLabel.bottomAnchor, constant: 32),
                                     loginButton.heightAnchor.constraint(equalToConstant: 48)])
    }
    
    func configureWarningViewConstraint() {
        view.addSubview(warningView)
        NSLayoutConstraint.activate([warningView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     warningView.topAnchor.constraint(equalTo: view.topAnchor),
                                     warningView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     warningView.heightAnchor.constraint(equalToConstant: 93)])
    }
    
    func configureSpinnerViewConstraint() {
        loginButton.addSubview(spinnerView)
        NSLayoutConstraint.activate([spinnerView.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
                                     spinnerView.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor),
                                     spinnerView.heightAnchor.constraint(equalToConstant: 24),
                                     spinnerView.widthAnchor.constraint(equalToConstant: 24)])
    }
    
    func configureBackgroundImageView() {
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     backgroundImageView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
                                     backgroundImageView.widthAnchor.constraint(equalToConstant: 180),
                                     backgroundImageView.heightAnchor.constraint(equalToConstant: 240)])
    }
    
    func validateTextField()  {
        if loginTextField.isTextFieldEmpty() {
            loginTextField.incorrectFillingTextField()
            loginWarningLabel.isHidden = false
        }
        
        if passwordTextField.isTextFieldEmpty() {
            passwordTextField.incorrectFillingTextField()
            passwordWarningLabel.isHidden = false
        }

        if !(loginTextField.isTextFieldEmpty()) {
            loginTextField.correctFillingTextField()
            loginWarningLabel.isHidden = true
        }
        
        if !(passwordTextField.isTextFieldEmpty()) {
            passwordTextField.correctFillingTextField()
            passwordWarningLabel.isHidden = true
        }
    }
}

//MARK: - LoginViewInput

extension LoginViewController: LoginViewInput {
    func showMainFlow() {
        (UIApplication.shared.delegate as? AppDelegate)?.runMainFlow()
    }
    
    func showWarning(errorDescription: String?) {
        showWarningView(errorDescription: errorDescription)
    }
    
    func hideWarning() {
        hideWarningView()
    }
    
    func startLoading() {
        spinnerView.startLoading()
        loginButton.setTitle("", for: .normal)
    }
    
    func stopLoading() {
        spinnerView.hideLoading()
        loginButton.setTitle("Войти", for: .normal)
    }

}


//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            guard let text = textField.text else { return false }
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = PhoneMask().format(with: "+X (XXX) XXX XX XX", phone: newString)
            return false
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            guard let isEmpty = textField.text?.isEmpty else {
                return
            }
            if isEmpty {
                loginTextField.endEditingWithEmptyTextField()
            }
        } else if textField.tag == 2 {
            guard let isEmpty = textField.text?.isEmpty else {
                return
            }
            if isEmpty {
                passwordTextField.endEditingWithEmptyTextField()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 2 {
            textField.resignFirstResponder()
        }
        return true
    }
}
