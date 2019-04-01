//
//  GeneralTabBarController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class GeneralTabBarController: UITabBarController {
    
    var activityIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getStudentInformation()
    }
    
    // MARK: ACTIONS
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        UdacityClient.logout(
            sucssess: {
                self.dismiss(animated: true, completion: nil)
        },
            failure: { (error) in
                
                self.showErrorAlert(messege: error.localizedDescription)
        })
    }
    
    @IBAction func refershTapped(_ sender: Any) {
        getStudentInformation()
    }
    
    // MARK: UI Configration
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func performRefereshIndicator() {
        
        if activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
        }else {
            activityIndicator.startAnimating()
        }
        
    }
    
    func showErrorAlert(messege: String) {
        AlertManager.shared.showFailureFromViewController(viewController: self, message: messege)
    }
    
    
    // MARK: GET DATA
    
    func getStudentInformation() {
        
        performRefereshIndicator()
        ParseClient.getStudentsLocation(
            success: {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
                self.performRefereshIndicator()
        },
            failure: { (error) in
                self.performRefereshIndicator()
                self.showErrorAlert(messege: error.localizedDescription)
                
        })
    }
    
}
