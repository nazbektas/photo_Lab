//
//  NetworkManager.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import Foundation

//making this class observable enables to broadcast its properties with @Published
class NetworkManager: ObservableObject {
    
    //@Published used, to be able to hear when the content changed
    
    @Published var responseData = ResponseData(photos: FeedData(photo: []))
    @Published var postArr = [PostData]()
    @Published var postArrProfile = [PostData]()
    @Published var userPhotos = ResponseData(photos: FeedData(photo: []))
    @Published var userProfileResponse = Person(person: User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: "")))
    @Published var userProfileData =  User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: ""))
    
    var postData = PostData(userID: "", username: "", profileURL: "", photoTitle: "", postServer: "", photoID: "", postSecret: "")
    var postDataProfile = PostData(userID: "", username: "", profileURL: "", photoTitle: "", postServer: "", photoID: "", postSecret: "")
    
    var userData = Person(person: User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: "")))
    
    var feedPage = 1
    var waitResponse = false
    
    func fetchData() {
        print(self.feedPage)
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=9c18bd0a31ccafffd6e0888680b5ae86&format=json&nojsoncallback=1&extras=1&per_page=5&page\(self.feedPage)") {
            //if creating an url from this string start session
            if(self.waitResponse){
                return
            }
            self.waitResponse = true
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data { //because data is optional, check first
                        do {
                            let photoData = try decoder.decode(ResponseData.self, from: safeData)
                            DispatchQueue.main.async {
                                for item in photoData.photos.photo {
                                    self.postData.photoTitle = item.title
                                    self.postData.postServer = item.server
                                    self.postData.photoID = item.id
                                    self.postData.postSecret = item.secret
                                    self.postData.userID = item.owner
                                    self.postArr.append(self.postData)
                                    ContentView().updateView()
                                    self.getUserInfo(ownerId: item.owner, photoID: item.id)
                                }
                                self.feedPage += 1
                                self.waitResponse = false
                            }
                        } catch {
                            self.waitResponse = false
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func getUserInfo(ownerId: String, photoID: String) {
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=9c18bd0a31ccafffd6e0888680b5ae86&user_id=\(ownerId)&format=json&nojsoncallback=1") {
            //if creating an url from this string start session
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data { //because data is optional, check first
                        do {
                            let userData = try decoder.decode(Person.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                for (index, item)in self.postArr.enumerated() {
                                    if(item.photoID == photoID){
                                        self.postArr[index].username = userData.person.username._content
                                        self.postArr[index].profileURL = userData.person.profileurl._content
                                    }
                                }
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func userProfile(ownerId: String) {
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=9c18bd0a31ccafffd6e0888680b5ae86&user_id=\(ownerId)&format=json&nojsoncallback=1") {
            //if creating an url from this string start session
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data { //because data is optional, check first
                        do {
                            let userData = try decoder.decode(Person.self, from: safeData)
                            DispatchQueue.main.async {
                                self.userProfileData = userData.person
                                self.userProfilePhotos(ownerId: ownerId, userData: userData.person)
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func userProfilePhotos(ownerId: String, userData: User) {
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.getPhotos&api_key=9c18bd0a31ccafffd6e0888680b5ae86&user_id=\(ownerId)&format=json&nojsoncallback=1&per_page=20") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data { //because data is optional, check first
                        do {
                            let photoData = try decoder.decode(ResponseData.self, from: safeData)
                            print(photoData)
                            DispatchQueue.main.async {
                                for item in photoData.photos.photo {
                                    self.postDataProfile.photoTitle = item.title
                                    self.postDataProfile.postServer = item.server
                                    self.postDataProfile.photoID = item.id
                                    self.postDataProfile.postSecret = item.secret
                                    self.postDataProfile.userID = ownerId
                                    self.postDataProfile.username = userData.username._content
                                    self.postDataProfile.profileURL = userData.profileurl._content
                                    self.postArrProfile.append(self.postDataProfile)
                                }
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}



