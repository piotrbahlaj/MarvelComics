//
//  SplashScreenView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 29/08/2024.
//

import Foundation
import SwiftUI

struct LaunchScreenView: View {
    var body: some View{
        GeometryReader{geometry in
            Image("splash_screen")
                .resizable()
                .scaledToFill()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .clipped()
                .edgesIgnoringSafeArea(.all)
        }
    }
}

//struct LaunchScreenView: View {
//    var body: some View{
//        Image("splash_screen-2")
//            .resizable()
//            .scaledToFill()
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//            .clipped()
//            .edgesIgnoringSafeArea(.all)
//    }
//}
