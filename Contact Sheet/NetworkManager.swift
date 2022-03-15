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
    
    private init() {}
    
    func fetchContact(completion: @escaping ([Contact]) -> Void) {
        AF.request(Link.api.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let contactsData = value as? [[String: Any]] else { return }
                    
                    var contacts: [Contact] = []
                    for contactsDatum in contactsData {
                        let contact = Contact(
                            gender: contactsDatum["gender"] as? String,
                            name: Name(
                                title: contactsDatum["title"] as? String,
                                first: contactsDatum["first"] as? String,
                                last: contactsDatum["last"] as? String
                            ),
                            location: Location(
                                street: Street(
                                    number: contactsDatum["number"] as? Int,
                                    name: contactsDatum["name"] as? String
                                ),
                                city: contactsDatum["city"] as? String,
                                state: contactsDatum["state"] as? String,
                                country: contactsDatum["country"] as? String,
                                postcode: contactsDatum["postcode"] as? Int,
                                coordinates: Coordinates(
                                    latitude: contactsDatum["latitude"] as? String,
                                    longitude: contactsDatum["longitude"] as? String
                                ),
                                timezone: Timezone(
                                    offset: contactsDatum["offset"] as? String,
                                    description: contactsDatum["description"] as? String
                                )
                            ),
                            email: contactsDatum["email"] as? String,
                            login: Login(
                                uuid: contactsDatum["uuid"] as? String,
                                username: contactsDatum["username"] as? String,
                                password: contactsDatum["password"] as? String,
                                salt: contactsDatum["salt"] as? String,
                                md5: contactsDatum["md5"] as? String,
                                sha1: contactsDatum["sha1"] as? String,
                                sha256: contactsDatum["sha256"] as? String
                            ),
                            dob: Dob(
                                date: contactsDatum["date"] as? String,
                                age: contactsDatum["age"] as? Int
                            ),
                            registered: Dob(
                                date: contactsDatum["date"] as? String,
                                age: contactsDatum["age"] as? Int
                            ),
                            phone: contactsDatum["phone"] as? String,
                            cell: contactsDatum["cell"] as? String,
                            id: ID(
                                name: contactsDatum["name"] as? String,
                                value: contactsDatum["value"] as? String
                            ),
                            picture: Picture(
                                large: contactsDatum["large"] as? String,
                                medium: contactsDatum["medium"] as? String,
                                thumbnail: contactsDatum["thumbnail"] as? String
                            ),
                            nat: contactsDatum["nat"] as? String
                        )
                        contacts.append(contact)
                    }
                    
                    completion(contacts)
                case .failure(let error):
                    print(error)
                }
            }
    }
}

enum Link: String {
    case api = "https://randomuser.me/api/"
}
