//
//  ProfileView.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    var user: User
    
    var body: some View {
        VStack {
            ScrollView {
                //profile image
//                KFImage.url(URL(string: post.profileURL))
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 60)
//                   
//                    .cornerRadius(30)
                
                //username
                Text("@ \(user.username._content)")
                    .font(.headline)
                    .padding(.bottom, 8)
                //Name
                Text(self.user.realname._content)
                    .font(.subheadline)
                    .padding(.bottom, 32)
                
                //photo count
                Text("233 Photos")
                    .font(.title2)
                    .onTapGesture {
                        self.console()
                    }
                Divider()
                Spacer()
            }
            
        }
        
    }
    
    func console(){
        print(self.user)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(post: PostData)
//    }
//}
