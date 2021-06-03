//
//  ContentView.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    //to listen changes in NetworkManager
    @ObservedObject var networkManager = NetworkManager()
    private let objectWillChange = ObservableObjectPublisher()

    func updateView(){
        objectWillChange.send()
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            let colWidth = geometry.size.width
            NavigationView {
                VStack {
                    NavBar(colWidth: colWidth)
                    ScrollView {
                       VStack(alignment: .leading) {
                           ForEach(networkManager.postArr, id: \.photoID) { post in
                               PostView(post: post, colWidth: colWidth)
                           }
                       }
                        VStack { }
                            .frame(width: colWidth, height: 100)
                            .onAppear {
                                self.networkManager.fetchData()
                            }
                   }
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
