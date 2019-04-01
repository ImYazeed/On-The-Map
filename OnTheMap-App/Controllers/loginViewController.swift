//
//  ViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class loginViewController: UIViewController,UITextFieldDelegate {
    
    // UI Element
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: Login handling
    
    func handleSuccessLogin() {
        
        UdacityClient.getUserData(
            success: {
                self.performSegue(withIdentifier: "mainNav", sender: nil)
                
        },
            failure: {(error) in
                AlertManager.shared.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        })
        setLoggingIn(false)
        
    }
    
    func handleFailureLogin(error: Error){
        AlertManager.shared.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        self.setLoggingIn(false)
    }
    
    
    // MARK: ACTIONS
    
    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        
        UdacityClient.login(username: emailTextField.text!, password: passwordTextField.text!,
                            sucssess: handleSuccessLogin,
                            failure: handleFailureLogin(error:))
        
    }
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        configureLoginButton()
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        UIApplication.shared.open(URL(string: "https://auth.udacity.com/sign-up")!, options: [:], completionHandler: nil)
    }
    
    
    
    // MARK: UI Confegration
    
    func configureLoginButton() {
        
        let isTexFieldsFilled = emailTextField.text != "" && passwordTextField.text != ""
        loginButton.isEnabled = isTexFieldsFilled
        loginButton.alpha = isTexFieldsFilled ? 1.0 : 0.7
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
        if loggingIn {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
        signUpButton.isEnabled = !loggingIn
        emailTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        loginButton.alpha = !loggingIn ? 1.0 : 0.7
    }
    
}

