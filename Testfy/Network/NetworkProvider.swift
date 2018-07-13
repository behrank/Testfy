//
//  NetworkProvider.swift
//  Testfy
//
//  Created by Behran Kankul on 11.07.2018.
//  Copyright © 2018 Be Moebil. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class NetworkProvider {
    
    static let shared = NetworkProvider()
    let provider = MoyaProvider<NetworkAPI>()
    
    fileprivate init() { }
    
    func call<T: Decodable>(target:NetworkAPI, completion:@escaping (T) -> (), failureCompletion:@escaping (String)-> Void) {
        provider.request(target) { [weak self] result in
            
            if result.value == nil {
                return failureCompletion("")
            }
            
            switch result.value!.statusCode {
            case 200:
                do {
                    let data = try JSONDecoder().decode(T.self, from: result.value!.data)
                    completion(data)
                }
                catch let jsonErr{
                    //debugPrint(String(data:  result.value!.data, encoding: .utf8))
                    debugPrint(jsonErr)
                    return failureCompletion("")
                }
                return
            case 500,400:
                return failureCompletion("")
            default:
                return failureCompletion("")
            }
        }
    }
}
