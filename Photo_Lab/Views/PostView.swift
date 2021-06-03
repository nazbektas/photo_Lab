//
//  PostView.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI
import URLImage // Import the package module
import Kingfisher

struct PostView: View {
    var post: PostData
    var colWidth: CGFloat
    @State var action: Bool = false
    @State var user: User = User(id: "", username: Username(_content: ""), realname: Realname(_content: ""), profileurl: ProfileURL(_content: ""))
    
    var body: some View {
        NavigationLink(
            destination: ProfileView(user: self.user),
            isActive: $action,
            label: {
                HStack {
                    //profile image
                    VStack {
                        KFImage.url(URL(string: post.profileURL))
                            .aspectRatio(contentMode: .fit)
                            //.resizable()
                            .frame(width: 30)
                            .cornerRadius(15)
                            .clipShape(Circle())
                            .overlay(Circle()
                                        .stroke(Color.gray, lineWidth: 1))
                    }
                    //username
                    Text(post.username)
                        .font(.system(size: 12, weight: .bold))
                        .onTapGesture {
                            self.fetch()
                        }
                }
                .padding(.horizontal, 16)
            })
            
        //post image

        VStack {
            KFImage.url(URL(string: "https://live.staticflickr.com/\(post.postServer)/\(post.photoID)_\(post.postSecret).jpg")!)
                .aspectRatio(contentMode: .fit)
                .frame(width: colWidth)
        }
        
        //post title
        Text(post.photoTitle)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.top, 8)
        
        Spacer()
            .frame(height: 64)
    }
    
    func fetch() {
        self.user = NetworkManager().userProfile(ownerId: post.userID)
        print("------------------------")
        print(self.user)
        if self.user != nil {
            action = true
            
        }
    }
}


