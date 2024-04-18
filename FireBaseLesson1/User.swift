//
//  User.swift
//  FireBaseLesson1
//
//  Created by Aldiyar Aitpayev on 17.04.2024.
//

import Foundation

struct User: Codable {
    var born: Int
    var firstName: String
    var lastName: String
}

struct UserResponse {
    var born: Int
    var firstName: String
    var lastName: String
    var id: String
    
    init(user: User, id: String) {
        self.born = user.born
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.id = id
    }
}
