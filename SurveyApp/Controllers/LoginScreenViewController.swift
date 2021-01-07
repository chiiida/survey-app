//
//  ViewController.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//

import UIKit

class LoginScreenViewController: UIViewController {
    
    private let logoImageView = UIImageView()
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginBtn = UIButton(type: .system)
    private let forgotBtn = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpLayout()
        setUpText()
        setUpColor()
        setUpConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setUpText() {
        emailField.placeholder = "Email"
        passwordField.placeholder = "Password"
        loginBtn.setTitle("Log in", for: .normal)
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        forgotBtn.setTitle("Forgot?", for: .normal)
    }
    
    func setUpColor() {
        emailField.backgroundColor = DARK_GRAY
        emailField.textColor = .white
        
        passwordField.backgroundColor = DARK_GRAY
        passwordField.textColor = .white
        
        loginBtn.setTitleColor(.black, for: .normal)
        loginBtn.backgroundColor = .white
        
        forgotBtn.setTitleColor(LIGHT_GRAY, for: .normal)
        forgotBtn.backgroundColor = DARK_GRAY
    }
    
    func setUpLayout() {
        let colorTop =  UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.frame = view.bounds
                
        view.layer.insertSublayer(gradientLayer, at:0)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        
        let logoImage = UIImage(named: "logo")
        logoImageView.frame = CGRect(x: 50, y: 110, width: 180, height: 180)
        logoImageView.image = logoImage
        logoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        logoImageView.center.x = view.center.x
    
        emailField.frame = CGRect(x: 50, y: 350, width: UIScreen.main.bounds.width - 50, height: 50.0)
        emailField.center.x = view.center.x
        emailField.layer.cornerRadius = 10.0
        emailField.font = UIFont.systemFont(ofSize: 15)
        emailField.borderStyle = UITextField.BorderStyle.roundedRect
        emailField.autocorrectionType = UITextAutocorrectionType.no
        emailField.keyboardType = UIKeyboardType.default
        emailField.returnKeyType = UIReturnKeyType.done
        emailField.clearButtonMode = UITextField.ViewMode.whileEditing
        emailField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        emailField.delegate = self
        
        passwordField.frame = CGRect(x: 50, y: 420, width: UIScreen.main.bounds.width - 50, height: 50.0)
        passwordField.layer.cornerRadius = 10.0
        passwordField.center.x = view.center.x
        passwordField.font = UIFont.systemFont(ofSize: 15)
        passwordField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordField.autocorrectionType = UITextAutocorrectionType.no
        passwordField.keyboardType = UIKeyboardType.default
        passwordField.returnKeyType = UIReturnKeyType.done
        passwordField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        passwordField.delegate = self
        passwordField.isSecureTextEntry = true
        
        forgotBtn.frame = CGRect(x: UIScreen.main.bounds.width - 95, y: 420, width: 70, height: 50.0)
        forgotBtn.addCorners(radius: 10.0)
        
        loginBtn.frame = CGRect(x: 50, y: 490, width: UIScreen.main.bounds.width - 50 , height: 50.0)
        loginBtn.center.x = view.center.x
        loginBtn.addCorners(radius: 10.0)
        loginBtn.addTarget(self, action: #selector(loginBtnWasTapped), for: .touchUpInside)
        
        view.addSubview(blurEffectView)
        view.addSubview(logoImageView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(forgotBtn)
        view.addSubview(loginBtn)
    }
    
    func setUpConstraint() {
        NSLayoutConstraint(item: emailField, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: logoImageView, attribute: .bottom, multiplier: 1, constant: 50).isActive = true
        NSLayoutConstraint(item: passwordField, attribute: .top, relatedBy: .greaterThanOrEqual, toItem: emailField, attribute: .bottom, multiplier: 1, constant: 20).isActive = true
    }
    
    @objc func loginBtnWasTapped() {
        let inputEmail = emailField.text ?? ""
        let inputPassword = passwordField.text ?? ""
        
        if inputEmail.isEmpty == false && inputPassword.isEmpty == false {
            if inputEmail.isValidEmail() {
                AuthenticationService.instance.login(email: inputEmail, password: inputPassword) {
                    
                }
                
                let homeViewController = HomeViewController()
                self.navigationController?.pushViewController(homeViewController, animated: true)
            }
        }
    }

}

extension LoginScreenViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField!) {    //delegate method

    }

    func textFieldShouldEndEditing(textField: UITextField!) -> Bool {  //delegate method
        return false
    }

    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
      textField.resignFirstResponder()

        return true
    }
}

