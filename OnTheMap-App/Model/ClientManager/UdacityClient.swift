//
//  NetworkManager.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


class UdacityClient {
    
    enum Endpoints {
        static let udacityBase = "https://onthemap-api.udacity.com/v1/"
        
        
        case session
        
        
        var stringValue: String {
            switch self {
            case .session:
                return "\(Endpoints.udacityBase)session"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func login(username: String, password: String, sucssess: @escaping () -> Void, failure: @escaping (Error) -> Void ) {
        let user = PersonalInfo(username: username, password: password)
        var request = URLRequest(url: Endpoints.session.url)
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
    
    
    
    class func logout(sucssess: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        var request = URLRequest(url: Endpoints.session.url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil { // Handle error…
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            print(String(data: newData, encoding: .utf8)!)
            
            do {
                _ = try JSONDecoder().decode(LogoutResponse.self, from: newData)
                    DispatchQueue.main.async {
                        sucssess()
                }
            }catch{
                
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
