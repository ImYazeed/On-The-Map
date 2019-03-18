//
//  LoginRequest.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

struct LoginRequest: Codable {
    let udacity:PersonalInfo
}
struct PersonalInfo: Codable {
    let username: String
    let password: String
}

