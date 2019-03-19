//
//  GeneralTabBarController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class GeneralTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getStudentInformation()
        
    }
    
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        UdacityClient.logout(sucssess: {
        self.dismiss(animated: true, completion: nil)
        }) { (error) in
            
             self.showErrorAlert(messege: error.localizedDescription)
        }
    }
    
    func getStudentInformation() {
        
        ParseClient.getStudentsLocation(success: { (studentsInformationResults) in
            StudentInformationModel.results = studentsInformationResults
        }) { (error) in
            self.showErrorAlert(messege: error.localizedDescription)
        }
    }
    
    
    func showErrorAlert(messege: String) {

        AlertManager.showLoginFailureFromViewController(viewController: self, message: messege)
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
