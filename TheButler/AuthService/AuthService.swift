//
//  NetworkManager.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 25.06.2022.
//

import Foundation
import Alamofire

class AuthService {
    static let shared = AuthService()
    
    private init() {
    }
    
    var networkToken: String? {
        get {
            return UserDefaults.standard.string(forKey: "NETWORK_TOKEN")
        }
        
        set (newValue) {
            UserDefaults.standard.set(newValue, forKey: "NETWORK_TOKEN")
        }
    }
    
    typealias InitWebServiceResponse = (InitResponseModel) -> Void
    typealias StartWebServiceResponse = (StartResponseModel) -> Void
    typealias VerifyWebServiceResponse = (VerifyResponseModel) -> Void
    typealias LoginWebServiceResponse = (LoginResponseModel) -> Void
    typealias LogoutWebServiceResponse = (LogoutResponseModel) -> Void
    
    typealias FailedHandler = (Error) -> Void
    
    func initRequest(model: InitRequestModel, completion: @escaping InitWebServiceResponse, fail: @escaping FailedHandler) {
        
        let params = ["device_uuid": model.deviceUUID,
                      "manufacturer": model.manufacturer,
                      "model": model.model,
                      "platform": model.platform,
                      "os_version": model.osVersion,
                      "app_version": model.appVersion] as [String: Any]
        
        AF.request(Constants.baseURL + APIRoutes.initURL.urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: InitResponseModel.self ) { response in
            
            if let error = response.error {
                fail(error)
            } else {
                if let res = response.value {
                    completion(res)
                }
            }
        }
    }
    
    func startRequest(model: StartRequestModel, completion: @escaping StartWebServiceResponse, fail: @escaping FailedHandler) {
        
        let params = ["email_or_number": model.emailOrNumber] as [String: Any]
        
        AF.request(Constants.baseURL + APIRoutes.startURL.urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: StartResponseModel.self ) { response in
            
            if let error = response.error {
                fail(error)
            } else {
                if let res = response.value {
                    completion(res)
                }
            }
        }
    }
    
    func verifyRequest(model: VerifyRequestModel, completion: @escaping VerifyWebServiceResponse, fail: @escaping FailedHandler) {
        
        let params = ["email_or_number": model.emailOrNumber,
                      "code": model.code,
                      "second_auth_token": model.secondAuthToken] as [String: Any]
        
        AF.request(Constants.baseURL + APIRoutes.verifyURL.urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseDecodable(of: VerifyResponseModel.self ) { response in
            
            if let error = response.error {
                fail(error)
            } else {
                if let res = response.value {
                    self.networkToken = res.data.token
                    completion(res)
                }
            }
        }
    }
    
    func loginRequest(model: LoginRequestModel, success: @escaping LoginWebServiceResponse, fail: @escaping FailedHandler) {
        let interceptor = InterQrRequestInterceptor()

        let params = ["device_uuid": model.deviceUUID] as [String: Any]
        
        AF.request(Constants.baseURL + APIRoutes.loginURL.urlString, method: .post, parameters: params, encoding: JSONEncoding.default, interceptor: interceptor).responseDecodable(of: LoginResponseModel.self ) { response in
            
            switch response.result {
            case .failure(let error) :
                fail(error)
            case .success(let res) :
                success(res)
            }
        }
    }
    
    func logoutRequest(model: LogoutRequestModel, completion: @escaping LogoutWebServiceResponse, fail: @escaping FailedHandler) {
        let interceptor = InterQrRequestInterceptor()
        let params = ["device_uuid": model.deviceUUID] as [String: Any]
        
        AF.request(Constants.baseURL + APIRoutes.logoutURL.urlString, method: .post, parameters: params, encoding: JSONEncoding.default, interceptor: interceptor).responseDecodable(of: LogoutResponseModel.self ) { response in
            guard let successCode = response.response?.statusCode else { return }
            if let error = response.error {
                fail(error)
            } else {
                if successCode == 200 {
                    guard let res = response.value else { return }
                    completion(res)
                }
            }
        }
    }
}

class InterQrRequestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
//        let headers = ["Authorization": "Bearer \(self.networkToken ?? "")"]
//        let params = ["device_uuid": model.deviceUUID] as [String: Any]
        if let token = AuthService.shared.networkToken {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
//        if let deviceUUID = 
        completion(.success(urlRequest))
    }
}
