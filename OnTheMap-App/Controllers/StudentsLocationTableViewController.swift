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
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(relodData), name: NSNotification.Name(rawValue: "studuntInformationUpdated"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        
        if let mediaURL = StudentInformationModel.results[indexPath.row].mediaURL {
            if let url = URL(string: mediaURL) {
                let app = UIApplication.shared
                if app.canOpenURL(url){
                    app.open(url, options: [:], completionHandler: nil)
                }else{
                     AlertManager.showFailureFromViewController(viewController: self, message: "Invalid Link")
                }
            }else{
               AlertManager.showFailureFromViewController(viewController: self, message: "No Link Found")
            }
        }
    }
    
    @objc func relodData() {
        tableView.reloadData()
    }
}
