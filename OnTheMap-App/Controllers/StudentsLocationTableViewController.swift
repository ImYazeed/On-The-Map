//
//  StudentsLocationTableViewController.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import UIKit

class StudentsLocationTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       subscribeToStudentInformationNotifications()
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToStudentInformationNotifications()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInformationModel.results.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationTableViewCell
        cell.configureCell(studentInfo: StudentInformationModel.results[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
         let mediaURL = StudentInformationModel.results[indexPath.row].mediaURL
        
            if let url = URL(string: mediaURL) {
                let app = UIApplication.shared
                if app.canOpenURL(url){
                    app.open(url, options: [:], completionHandler: nil)
                }else{
                     AlertManager.shared.showFailureFromViewController(viewController: self, message: "Invalid Link")
                }
            }else{
               AlertManager.shared.showFailureFromViewController(viewController: self, message: "No Link Found")
            }
        
    }
    
    // MARK: Notifications
    
    func subscribeToStudentInformationNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(relodData), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
    }
    
    func unsubscribeToStudentInformationNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @objc func relodData() {
        tableView.reloadData()
    }
    
}
