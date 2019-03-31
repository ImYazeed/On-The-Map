//
//  File.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 31/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct User: Codable {
    
    let firstName: String
    let lastName: String
    let key: String
    
    enum CodingKeys: String, CodingKey {
        case lastName = "last_name"
        case firstName = "first_name"
        case key
    }
    
}
