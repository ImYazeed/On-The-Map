//
//  postLocationRequest.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 01/04/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct StudentInfoToSend: Encodable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    var mapString: String
    var mediaURL: String
    let latitude: Double
    let longitude: Double
}
