//
//  File.swift
//  OnTheMap-App
//
//  Created by Yazeedo on 19/03/2019.
//  Copyright © 2019 Yazeedo. All rights reserved.
//

import Foundation

class ParseClient {
    
    static let ParseAppID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
    static let ParseApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
    
    
    enum Endpoints {
        
        static let ParseBase = "https://parse.udacity.com/parse/classes/StudentLocation"
        
        
        case studentLocation(limit: Int)
        case postStudentLocation
        
        var stringValue: String {
            switch self {
            case let .studentLocation(limit):
                return "\(Endpoints.ParseBase)?limit=\(limit)&order=-updatedAt"
         
            case .postStudentLocation:
                return "\(Endpoints.ParseBase)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func getStudentsLocation(success: @escaping ()-> Void, failure: @escaping (Error) -> Void) {
        
        var request = URLRequest(url: Endpoints.studentLocation(limit: 100).url)
        request.addValue(ParseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
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
            
            do {
                
                let studentsInfoResonse = try JSONDecoder().decode(StudentsInfoResponse.self, from: data)
                StudentInformationModel.results = studentsInfoResonse.results
                DispatchQueue.main.async {
                    success()
                }
                
            }catch{
                DispatchQueue.main.async {
                    failure(error)
                }
                
            }
            
        }
        task.resume()
    }
    
    
    class func postStudentLocation(student:StudentInfoToSend, success: @escaping () -> Void, failure: @escaping (Error) -> Void) {
        
        var request = URLRequest(url: Endpoints.postStudentLocation.url)
        request.httpMethod = "POST"
        request.addValue(ParseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
             let encoder = JSONEncoder()
             let body = try encoder.encode(student)
             request.httpBody = body
        }catch{
            failure(error)
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            do {
                // just to make sure of success post location
                let _ = try JSONDecoder().decode(PostLocationResponse.self, from: data!)
                DispatchQueue.main.async {
                    success()
                }
            }catch {
                
                do {
                    let failureResponse = try JSONDecoder().decode(FailurePostLocationResponse.self, from: data!)
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
