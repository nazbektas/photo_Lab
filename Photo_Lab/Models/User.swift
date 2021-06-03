//
//  User.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import Foundation

struct User: Decodable {
    var id: String
    var username: Username
    var realname: Realname
    var profileurl: ProfileURL
}

struct Person: Decodable {
    var person: User
}

struct Username: Decodable {
    var _content: String
}

struct Realname: Decodable {
    var _content: String
}

struct ProfileURL: Decodable {
    var _content: String
}
