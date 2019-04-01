//
//  NetworkManager.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 18/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation


class UdacityClient {
    
    static var userKey = ""
    
    enum Endpoints {
        static let udacityBase = "https://onthemap-api.udacity.com/v1/"
        
        
        case session
        case getUserData
        
        var stringValue: String {
            switch self {
            case .session:
                return "\(Endpoints.udacityBase)session"
            case .getUserData:
                return "\(Endpoints.udacityBase)users/\(userKey)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func login(username: String, password: String, sucssess: @escaping () -> Void, failure: @escaping (Error) -> Void) {
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
            
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: newData)
                
                if loginResponse.account.registered {
                    
                    DispatchQueue.main.async {
                        userKey = loginResponse.account.key
                        sucssess()
                    }
                    
                }else {
                    let RegisterationError = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "You are not registered"])
                    DispatchQueue.main.async {
                        failure(RegisterationError)
                    }
                }
                
            }catch {
                
                do {
                    let failureResponse = try JSONDecoder().decode(FailureLoginResponse.self, from: newData)
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
            
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
                // just to make sure of success logout
                _ = try JSONDecoder().decode(LogoutResponse.self, from: newData)
                DispatchQueue.main.async {
                    sucssess()
                }
            }catch{
                
                do {
                    let failureResponse = try JSONDecoder().decode(FailureLoginResponse.self, from: newData)
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
    
    
    
    class func getUserData(success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        
        let request = URLRequest(url: Endpoints.getUserData.url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            let range = 5..<data.count
            let newData = data.subdata(in: range)
            
            do {
               let decoder = JSONDecoder()
               let user = try decoder.decode(User.self, from: newData)
               
                StudentInformationModel.currentUser = user
                DispatchQueue.main.async {
                    success()
                }
            }catch {
                DispatchQueue.main.async {
                    failure(error)
                }
            }
        }
        task.resume()
    }
    
    
    
    
}
