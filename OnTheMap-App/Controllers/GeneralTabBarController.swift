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

        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    @IBAction func logOutTapped(_ sender: Any) {
        
        NetworkManager.logout(sucssess: {
        self.dismiss(animated: true, completion: nil)
        }) { (error) in
            
            guard let selectedVC = self.viewControllers?[self.selectedIndex] else {
                return
            }
            AlertManager.showLoginFailureFromViewController(viewController: selectedVC, message: error.localizedDescription)
        }
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
