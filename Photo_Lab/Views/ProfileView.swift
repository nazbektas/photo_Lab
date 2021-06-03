//
//  ProfileView.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    var ownerID: String
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        GeometryReader { geometry in
            let colWidth = geometry.size.width
            ScrollView {
                //profile image
                    Image("profileImage")
                        .resizable()
                        .aspectRatio(contentMode: ContentMode.fit)
                        .frame(width: 80, height: 80)
                        .cornerRadius(40)

//                    KFImage.url(URL(string: self.networkManager.userProfileData.profileurl._content))
//                        .resizable()
//                        .aspectRatio(contentMode: ContentMode.fit)
//                        .frame(width: 80, height: 80)
//                        .cornerRadius(40)
//                        .clipShape(Circle())
//                        .overlay(Circle()
//                        .stroke(Color.gray, lineWidth: 1))
                
                
                //username
                Text("@ \(self.networkManager.userProfileData.username._content)")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                    //Name
                Text(self.networkManager.userProfileData.realname._content)
                    .font(.subheadline)
                    .padding(.bottom, 32)
        
                Divider()
                    .padding(.vertical, 20)
                VStack(alignment: .leading) {
                    ForEach(networkManager.postArrProfile , id: \.photoID) { post in
                        PostView(post: post, colWidth: colWidth)
                    }
                }
                
            }
            .onAppear {
                self.networkManager.userProfile(ownerId: ownerID)
            }
        }
    }
}
