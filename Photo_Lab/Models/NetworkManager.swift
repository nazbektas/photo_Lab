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
    @Published var user = User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: ""))

    var postData = PostData(userID: "", username: "", profileURL: "", photoTitle: "", postServer: "", photoID: "", postSecret: "")
    var userData = Person(person: User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: "")))
    
    
    func fetchData() {
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=9c18bd0a31ccafffd6e0888680b5ae86&format=json&nojsoncallback=1&extras=1") {
            //if creating an url from this string start session
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
                                    self.getUserInfo(ownerId: item.owner, photoID: item.id)
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
    
    func userProfile(ownerId: String) -> User {
        if let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.people.getInfo&api_key=9c18bd0a31ccafffd6e0888680b5ae86&user_id=\(ownerId)&format=json&nojsoncallback=1") {
            //if creating an url from this string start session
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data { //because data is optional, check first
                        do {
                            let userData = try decoder.decode(User.self, from: safeData)
                            
                            DispatchQueue.main.async {
                                self.user = userData
                                print(self.user)
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        return self.user
    }
}



