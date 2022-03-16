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
    
    func fetchData(with urlString: String, completion: @escaping (Data) -> Void) {
        AF.request(urlString)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

enum Link: String {
    case api = "https://randomuser.me/api/"
}

enum Segue: String {
    case showContact = "ShowContact"
}
