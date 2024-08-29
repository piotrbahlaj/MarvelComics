//
//  DetailsView.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 28/08/2024.
//

import Foundation
import SwiftUI

struct DetailsView: View{
    var comic: Comic
    @State private var showWebView: Bool = false
    private var webViewURL: URL? {
        URL(string: comic.urls.first?.url ?? "")
    }
    var body: some View{
        ScrollView{
            VStack(alignment: .leading, spacing: 10) {
                let imageURL = comic.thumbnail.fullImageURL
                AsyncImage(url: imageURL){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width)
                .clipped()
                                
                Text(comic.title)
                    .font(.title)
                    .frame(alignment: .center)
                    .padding([.horizontal, .bottom], 10)
                
                if let creators = comic.creators.items.first?.name{
                    Text("Written by: \(creators)")
                        .font(.body)
                        .padding(.horizontal)
                        .frame(alignment: .leading)
                        .foregroundStyle(.gray)
                } else {
                    Text("Unknown creator")
                        .font(.body)
                        .padding(.horizontal)
                        .frame(alignment: .leading)
                        .foregroundStyle(.gray)
                }
                
                if let description = comic.textObjects?.first?.text {
                    Text(description)
                        .font(.body)
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width, alignment: .center)
                } else {
                    Text("No description available")
                        .font(.body)
                        .padding(.horizontal)
                        .frame(alignment: .leading)
                }
                Button(action: {
                    showWebView = true
                }) {
                    Text("Find out more")
                        .frame(width: UIScreen.main.bounds.width / 1.1, height: 50, alignment: .center)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, 95)

        }
        .edgesIgnoringSafeArea(.top)
        .sheet(isPresented: $showWebView) {
            if let url = webViewURL {
                WebView(url: url)
            } else {
                Text("No URL available")
            }
        }
    }
}
