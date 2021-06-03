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

    
    var body: some View {
        NavigationLink(
            destination: ProfileView(ownerID: post.userID),
            isActive: $action,
            label: {
                HStack {
                    //profile image
                    VStack(alignment: .leading)
                    {
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
                        .font(.system(size: 14, weight: .bold))
                }
                .padding(.top, 30)
                .padding(.bottom, 10)
                .padding(.horizontal, 20)

            })
            
        //post image
        KFImage.url(URL(string: "https://live.staticflickr.com/\(post.postServer)/\(post.photoID)_\(post.postSecret).jpg")!)
            .aspectRatio(contentMode: .fill)
            .frame(width: colWidth)
        
        //post title
        Text(post.photoTitle)
            .font(.subheadline)
            .padding(.horizontal, 16)
            .padding(.top, 8)
        
        Spacer()
            .frame(height: 24)
    }
}


