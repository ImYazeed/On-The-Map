//
//  StudentInformation.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct StudentInformation: Codable {
    let objectId: String?
    let uniqueKey: String?
    let firstName: String?
    let lastName: String?
    let mapString: String?
    let mediaURL: String?
    let latitude: Double?
    let longitude: Double?
    let createdAt: String?
    let updatedAt: String?
}

struct StudentInfoToSend: Encodable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    var mapString: String
    var mediaURL: String
    let latitude: Double
    let longitude: Double
}

class StudentInformationModel {
    static var results = [StudentInformation]()
    
    // initial User data, it will change after user logged in
    static var currentUser = User(firstName:"", lastName:"", key:"")
}
