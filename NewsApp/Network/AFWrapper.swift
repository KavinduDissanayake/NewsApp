//
//  AFWrapper.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-10.
//

import Alamofire


struct APIErrorResponse: Codable {
    let status: String?
    let code: String?
    let message: String?
}

enum AFWrapperError: Error {
    case requestFailed(String)
    case decodingFailed
    
    var errorMessage: String {
        switch self {
        case .requestFailed(let message):
            return message
        case .decodingFailed:
            return "Decoding failed."
        }
    }
}


final class AFWrapper {
    
    static let shared = AFWrapper()
    
    private init() {} // Private initializer to ensure Singleton usage
    
    
    
    func request<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        headers: HTTPHeaders? = nil,
        success: @escaping (T) -> Void,
        failure: @escaping (Error) -> Void
    ) {
        var allParameters = parameters ?? Parameters()
        allParameters["apiKey"] = Constant.apiKey

        // Remove any nil, NSNull, and empty string values
        allParameters = allParameters.compactMapValues {
            if $0 is NSNull || $0 as? String == "" {
                return nil
            }
            return $0
        }

        //remove null values
        let requestURL = Constant.getBaseURL.appending(endpoint)
        
        print("🔹Prerquest data : Url \(requestURL)\n🔹")
        
        
        let request = AF.request(requestURL, method: method, parameters: allParameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .failure(let error):
                    
                    if let data = response.data, let decodingError = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                        failure(AFWrapperError.requestFailed(decodingError.message ?? ""))
                        return
                    }else{
                        let message = "Request failed: \(error.localizedDescription)"
                        failure(AFWrapperError.requestFailed(message))
                    }
                    
                case .success(let data):
                    self.decode(data: data, success: success, failure: failure)
                }
            }
        
        DispatchQueue.main.async {
            // your code here
            print("REQUEST = \(request.debugLog())")
        }
    }
    
    
    private func decode<T: Decodable>(data: Data, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try decoder.decode(T.self, from: data)
            success(result)
        } catch {
            failure(AFWrapperError.decodingFailed)
        }
    }
}

struct Constant {
    static let apiKey = AppConfig.getValueFor(.apiKey) ?? ""
    static let getBaseURL =  "\(AppConfig.getValueForURL(.baseURL) ?? "")"
}


extension Request {
    public func debugLog() -> Self {
#if DEBUG
        cURLDescription(calling: { (curl) in
            debugPrint("=======================================")
            print(curl)
            debugPrint("=======================================")
        })
#endif
        return self
    }
}
