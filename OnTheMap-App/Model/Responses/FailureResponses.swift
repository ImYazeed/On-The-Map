//
//  FailureResponse.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


// Failure login response
struct FailureLoginResponse: Codable {
    let status: Int
    let error: String
}

extension FailureLoginResponse: LocalizedError {
    
    var errorDescription: String? {
        return error
    }
}

// Failure PostLocationResponse
struct FailurePostLocationResponse:Codable {
    let code: Int
    let error: String
}

extension FailurePostLocationResponse: LocalizedError {
    var errorDescription: String? {
        return error
    }
}
