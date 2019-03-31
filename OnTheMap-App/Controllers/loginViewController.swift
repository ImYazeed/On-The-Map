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
        loginButton.layer.cornerRadius = 4.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: ACTIONS
    
    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        
        UdacityClient.login(username: emailTextField.text!, password: passwordTextField.text!,
                            sucssess: handleSuccessLogin,
                            failure: handleFailureLogin(error:))
        
    }
    
    
    // MARK: LOGIN BUTTON HANDLING
    
    @IBAction func textFieldDidChange(_ sender: Any) {
        configureLoginButton()
    }
    
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
    
    func handleSuccessLogin() {
        
        UdacityClient.getUserData(
            success: {
                self.performSegue(withIdentifier: "mainNav", sender: nil)
                
        },
            failure: {(error) in
            AlertManager.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        })
        setLoggingIn(false)
        
    }
    
    func handleFailureLogin(error: Error){
        AlertManager.showFailureFromViewController(viewController: self, message: error.localizedDescription)
        self.setLoggingIn(false)
    }
    
}

