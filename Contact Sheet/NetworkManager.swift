//
//  NetworkManager.swift
//  Contact Sheet
//
//  Created by Илья Нечаев on 15.03.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let parameters = [
        "results":"\(100)"
    ]
    
    private init() {}
    
    func fetchContact(completion: @escaping ([Contact]) -> Void) {
        AF.request(Link.api.rawValue, parameters: parameters)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    
                    guard let results = Contact.getContacts(from: value) else { return }
                    
                    completion(results)
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}

enum Link: String {
    case api = "https://randomuser.me/api/"
}
