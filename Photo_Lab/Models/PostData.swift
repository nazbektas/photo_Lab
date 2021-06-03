//
//  PostData.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import Foundation


struct Photo: Decodable{
    var id: String
    var owner: String
    var title: String
    var server: String
    var secret: String
}

struct FeedData: Decodable {
//    var page: Int
//    var perpage: Int
    var photo: [Photo]
}

struct ResponseData: Decodable {
    var photos: FeedData
}

struct PostData: Decodable {
    var userID: String
    var username: String
    var profileURL: String
    var photoTitle: String
    var postServer: String
    var photoID: String
    var postSecret: String
}
