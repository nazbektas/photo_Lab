//
//  NavBar.swift
//  Photo_Lab
//
//  Created by Naz Bektas on 27.05.2021.
//

import SwiftUI

struct NavBar: View {
    var colWidth: CGFloat
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.fixed(colWidth)),
            GridItem(.fixed(colWidth/3)),
            GridItem(.fixed(colWidth)),
        ]) {
            Spacer()
            
            Image("photoLAB")
                .resizable()
                .scaledToFit()
        }
    }
}
