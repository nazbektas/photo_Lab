//
//  ContentView.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI

struct ContentView: View {
    
    //to listen changes in NetworkManager
    @ObservedObject var networkManager = NetworkManager()

    var body: some View {
        GeometryReader { geometry in
            let colWidth = geometry.size.width 
            NavigationView {
                VStack {
                    NavBar(colWidth: colWidth)

                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            
                            ForEach(networkManager.postArr, id: \.photoID) { post in
                                PostView(post: post, colWidth: colWidth)
                            }
                        }
                        
                    }
                    
                }
                .navigationBarHidden(true)
            }
            .onAppear {
                self.networkManager.fetchData()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
