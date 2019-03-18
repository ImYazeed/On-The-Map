//
//  FailureResponse.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


struct FailureResponse: Codable {
    let status: Int
    let error: String
}

extension FailureResponse: LocalizedError {
    
    var errorDescription: String? {
        return error
    }
    
}
