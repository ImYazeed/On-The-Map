//
//  LoginResponse.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


struct LoginResponse: Codable {
    let account: Account
    let session: Session
}

struct Account: Codable {
    let key: String
    let registered: Bool
}

struct Session: Codable {
    let expiration: String
    let id: String
}
