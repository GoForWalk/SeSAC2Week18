//
//  APIService.swift
//  SeSAC2Week18
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation

import Alamofire

struct APIService {
    
    func signUp(userName: String, email: String, password: String) {
        let signup = SeSACAPI.signup(userName: userName, email: email, password: password)
                
        AF.request(signup.url, method: .post, parameters: signup.params, headers: signup.headers).responseString { response in
            print(response)
            print(response.response?.statusCode)
        }
    }
    
    func login(email: String, password: String) {
        let login = SeSACAPI.login(email: email, password: password)
        
        AF.request(login.url, method: .post, parameters: login.params, headers: login.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Login.self) { response in
            
            switch response.result {
            case .success(let data):
                print(data.token)
                UserDefaults.standard.set(data.token, forKey: "token")
                
            case .failure(let error):
                print("error: \(error)")
                print(response.response?.statusCode)
            }
        }
        
    }
    
    func profile() {
        let profile = SeSACAPI.profile
        
        AF.request(profile.url, method: .get, headers: profile.headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: Profile.self) { response in
                
                switch response.result {
                case .success(let profile):
                    print(profile)
                case .failure(let error):
                    print("error: \(error)")
                    print(response.response?.statusCode)
                }
            }

    }
    
}


struct Login: Codable {
    var token: String
}

struct Profile: Codable {
    var user: UserProfile
}

struct UserProfile: Codable {
    /// photoURL
    var photo: String
//    var followers: [String]
//    var following: [String]
    var email: String
    var username: String
//    var id: String
}
