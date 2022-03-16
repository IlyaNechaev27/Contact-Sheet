//
//  Contact.swift
//  Contact Sheet
//
//  Created by Илья Нечаев on 15.03.2022.
//

import Foundation

// MARK: - Result
struct Contact: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
    
    init(value: [String: Any]) {
        gender = value["gender"] as? String
        email = value["email"] as? String
        phone = value["phone"] as? String
        cell = value["cell"] as? String
        nat = value["nat"] as? String
        
        let nameDict = value["name"] as? [String: String] ?? [:]
        name = Name(value: nameDict)
        
        let locationDict = value["location"] as? [String: Any] ?? [:]
        location = Location(value: locationDict)
        
        let loginDict = value["login"] as? [String: String] ?? [:]
        login = Login(value: loginDict)
        
        let dobDict = value["dob"] as? [String: Any] ?? [:]
        dob = Dob(value: dobDict)
        
        let registeredDict = value["registered"] as? [String: Any] ?? [:]
        registered = Dob(value: registeredDict)
        
        let idDict = value["id"] as? [String: String] ?? [:]
        id = ID(value: idDict)
        
        let pictureDict = value["picture"] as? [String: String] ?? [:]
        picture = Picture(value: pictureDict)
    }
    
    static func getContacts(from value: Any) -> [Contact]? {
        guard let value = value as? [String: Any] else { return [] }
        guard let results = value["results"] as? [[String: Any]] else { return [] }
        return results.compactMap { Contact(value: $0)}
    }
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
    
    init(value: [String: Any]) {
        date = value["date"] as? String
        age = value["age"] as? Int
    }
}

// MARK: - ID
struct ID: Codable {
    let name, value: String?
    
    init(value: [String: String]) {
        name = value["name"]
        self.value = value["name"]
    }
}

// MARK: - Location
struct Location: Codable {
    let street: Street?
    let city, state, country: String?
    let postcode: Int?
    let coordinates: Coordinates?
    let timezone: Timezone?
    
    init(value: [String: Any]) {
        let streetDict = value["street"] as? [String: Any] ?? [:]
        street = Street(value: streetDict)
        
        city = value["city"] as? String
        state = value["state"] as? String
        country = value["country"] as? String
        postcode = value["postcode"] as? Int
        
        let coordinatesDict = value["coordinates"] as? [String: String] ?? [:]
        coordinates = Coordinates(value: coordinatesDict)
        
        let timezoneDict = value["timezone"]  as? [String: String] ?? [:]
        timezone = Timezone(value: timezoneDict)
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
    
    init(value: [String: String]) {
        latitude = value["latitude"]
        longitude = value["longitude"]
    }
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
    
    init(value: [String: Any]) {
        number = value["number"] as? Int
        name = value["name"] as? String
    }
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, description: String?
    
    init(value: [String: String]) {
        offset = value["offset"]
        description = value["description"]
    }

}

// MARK: - Login
struct Login: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
    
    init(value: [String: String]) {
        uuid = value["uuid"]
        username = value["username"]
        password = value["password"]
        salt = value["salt"]
        md5 = value["md5"]
        sha1 = value["sha1"]
        sha256 = value["sha256"]
    }
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String?
    
    init(value: [String: String]) {
        title = value["title"]
        first = value["first"]
        last = value["last"]
    }
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
    
    init(value: [String: String]) {
        large = value["large"]
        medium = value["medium"]
        thumbnail = value["thumbnail"]
    }
}
