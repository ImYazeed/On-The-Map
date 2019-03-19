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
        
        
        var stringValue: String {
            switch self {
            case .studentLocation:
                return "\(Endpoints.ParseBase)"
         
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    
    class func getStudentsLocation(success: @escaping ([StudentInformation])-> Void, failure: @escaping (Error) -> Void) {
        
        var request = URLRequest(url: Endpoints.studentLocation(limit: 100).url)
        request.addValue(ParseAppID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    failure(error!)
                }
                return
            }
            
            guard let data = data else {
                return
            }
            print(String(data: data, encoding: .utf8)!)
            
            do {
                
                let studentsInfoResonse = try JSONDecoder().decode(StudentsInfoResponse.self, from: data)
                
                DispatchQueue.main.async {
                    success(studentsInfoResonse.results)
                }
                
            }catch{
                failure(error)
            }
            
        }
        task.resume()
    }
    
}
