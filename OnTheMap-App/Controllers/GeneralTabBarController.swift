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
         getStudentInformation()
    }
    @IBAction func logOutTapped(_ sender: Any) {
        
        UdacityClient.logout(sucssess: {
            self.dismiss(animated: true, completion: nil)
        }) { (error) in
            
            self.showErrorAlert(messege: error.localizedDescription)
        }
    }
    
    
//    override func viewWillDisappear(_ animated: Bool) {
//        print("")
//    }
    @IBAction func refershTapped(_ sender: Any) {
        getStudentInformation()
    }
    func getStudentInformation() {
        
        performRefereshIndicator()
        ParseClient.getStudentsLocation(success: { (studentsInformationResults) in
            StudentInformationModel.results = studentsInformationResults
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
           self.performRefereshIndicator()
        }) { (error) in
            self.performRefereshIndicator()
            self.showErrorAlert(messege: error.localizedDescription)
            
        }
    }
    
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
        
        AlertManager.showFailureFromViewController(viewController: self, message: messege)
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
