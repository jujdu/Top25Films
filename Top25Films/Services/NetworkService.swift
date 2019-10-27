//
//  NetworkService.swift
//  Top25Films
//
//  Created by Michael Sidoruk on 25.10.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation

import Foundation
import Alamofire

protocol Networking {
    func request<T: Decodable>(url: String, parameters: Parameters?, completion: @escaping (T?) -> ())
}

class NetworkService: Networking {
        
    func request<T: Decodable>(url: String, parameters: Parameters? = nil, completion: @escaping (T?) -> ()) {
        
        var param: Parameters = [:]
        
        if let parameters = parameters {
            param = parameters
        }
        
        Alamofire.request(url, method: .get, parameters: param).responseJSON { (response) in
            
            if let error = response.error {
                debugPrint("Error: Can't received data", error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data = response.data else {
                completion(nil)
                return }
            
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(T.self, from: data)
                completion(response)
                return
            } catch {
                debugPrint("Error: Can't decode data", error.localizedDescription)
                completion(nil)
                return
            }
        }
    }
}
