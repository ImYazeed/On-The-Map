//
//  NetworkManager.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


class NetworkManager {
    
    static let ParseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let ParseApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    
    enum Endpoints {
        static let udacityBase = "https://onthemap-api.udacity.com/v1/"
        static let ParseBase = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        
        case createSessionId
        
        var stringValue: String {
            switch self {
            case .createSessionId:
                return "\(Endpoints.udacityBase)session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func login(username: String, password: String, sucssess: @escaping () -> Void, failure: @escaping (Error) -> Void ) {
        let user = PersonalInfo(username: username, password: password)
        var request = URLRequest(url: Endpoints.createSessionId.url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let loginInfo = LoginRequest(udacity: user)
        
        do {
            request.httpBody = try JSONEncoder().encode(loginInfo)
        }catch {
            DispatchQueue.main.async {
                failure(error)
            }
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    failure(error!)
                }

                return
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: newData)
                
                if loginResponse.account.registered {
                    DispatchQueue.main.async {
                      sucssess()
                    }
    
                }
                
            }catch {
                
                do {
                   let failureResponse = try JSONDecoder().decode(FailureResponse.self, from: newData)
                    DispatchQueue.main.async {
                        failure(failureResponse)
                    }
                   
                }catch {
                    DispatchQueue.main.async {
                        failure(error)
                    }
                }
            }
            
        }
        
        task.resume()
    }
    
    
    
    
    
    
}
