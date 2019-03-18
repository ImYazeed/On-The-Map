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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loginButton.layer.cornerRadius = 4.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    // MARK: LOGIN BUTTON HANDLING

    @IBAction func textFieldDidChange(_ sender: Any) {
        configureLoginButton()
    }
    
    func configureLoginButton() {
        loginButton.isEnabled = emailTextField.text != "" && passwordTextField.text != ""
        loginButton.alpha = emailTextField.text != "" && passwordTextField.text != "" ? 1.0 : 0.7
    }
    
}

