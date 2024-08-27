//
//  ComicModel.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 26/08/2024.
//

import Foundation

struct ComicModel: Decodable {
    let data: ComicsResults
}

struct ComicsResults: Decodable {
    let results: [Comic]
}

struct Comic: Decodable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let creators: [CreatorsList]
}

struct CreatorsList: Decodable {
    let items: [Creators]
}

struct Creators: Decodable {
    let name: String
}

struct Thumbnail: Decodable{
    let path: String
    let ext: CodingKeys
}

 enum CodingKeys : String, Decodable {
    case ext = "extension"
    }
