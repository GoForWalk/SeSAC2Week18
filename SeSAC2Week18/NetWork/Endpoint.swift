//
//  Endpoint.swift
//  SeSAC2Week18
//
//  Created by sae hun chung on 2022/11/02.
//

import Foundation
import Alamofire

enum SeSACAPI {

    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case profile
}

extension SeSACAPI {
    
    var url: URL {
        
        let baseURL = "http://api.memolease.com"

        switch self {
        case .signup:
            return URL(string: "\(baseURL)/api/v1/users/signup")!
        case .login:
            return URL(string: "\(baseURL)/api/v1/users/login")!
        case .profile:
            return URL(string: "\(baseURL)/api/v1/users/me")!
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type":"application/x-www-form-urlencoded"]
        case .profile:
           return ["Authorization":"Bearer \(UserDefaults.standard.string(forKey: "token")!)",
                "Content-Type":"application/x-www-form-urlencoded"]
        }
    }
    
    var params: [String: String] {
        switch self {
        case .signup(let username, let email, let password):
            return [
                "userName":"\(username)",
                "email":"\(email)",
                "password":"\(password)"
            ]
        case .login(let email, let password):
            return [
                "email":"\(email)",
                "password":"\(password)"
            ]
            
        default:
            return ["":""]
        }
    }
    
}

