//
//  StudentInformation.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    let objectId: String
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Double
    let longitude: Double
    let createdAt: String
    let updatedAt: String
}

class StudentInformationModel {
    
    // MARK: - Shared Instance
    
    static let shared = StudentInformationModel()

    var results = [StudentInformation]()
    
    // initial User data, it will change after user logged in
    static var currentUser = User(firstName:"", lastName:"", key:"")
}
