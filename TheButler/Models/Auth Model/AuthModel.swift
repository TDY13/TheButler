//
//  AuthModel.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 25.06.2022.
//

import Foundation

//MARK: - Init collection
struct InitRequestModel: Codable {
    var deviceUUID: String
    var manufacturer: String
    var model: String
    var platform: String
    var osVersion: String
    var appVersion: String
}

struct InitResponseModel: Decodable {
    var message: String
}

//MARK: - Start2fa collection
struct StartRequestModel: Codable {
    var emailOrNumber: String
    
    enum CodingKeys: String, CodingKey {
        case emailOrNumber = "email_or_number"
    }
}

struct StartResponseModel: Decodable {
    var message: String
}

//MARK: - Verify2fa collection
struct VerifyRequestModel: Codable {
    var emailOrNumber: String
    var code: String
    var secondAuthToken: String
    
    enum CodingKeys: String, CodingKey {
        case emailOrNumber = "email_or_number"
        case code
        case secondAuthToken = "second_auth_token"
    }
}

struct VerifyResponseModel: Decodable {
    var data: VerifyData
    var message: String
}

struct VerifyData: Decodable {
    var token: String
    var uuid: String
}

//MARK: - Login collection
struct LoginRequestModel: Codable {
    var deviceUUID: String
    
    enum CodingKeys: String, CodingKey {
        case deviceUUID = "device_uuid"
    }
}

struct LoginResponseModel: Decodable {
    var message: String?
}

//MARK: - Logout collection

struct LogoutRequestModel: Codable {
    var deviceUUID: String
    
    enum CodingKeys: String, CodingKey {
        case deviceUUID = "device_uuid"
    }
}

struct LogoutResponseModel: Decodable {
    var message: String?
}
