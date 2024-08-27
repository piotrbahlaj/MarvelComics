//
//  MarvelService.swift
//  MarvelComics
//
//  Created by Piotr Bahlaj on 26/08/2024.
//

import Foundation
import CryptoKit

class MarvelService {
    private let publicKey = PUBLIC_KEY
    private let privateKey = PRIVATE_KEY
    private let baseURL = BASE_URL
    
    private func generateHash(ts: String) -> String{
        let combinedString = ts + privateKey + publicKey
        let data = Data(combinedString.utf8)
        let hash = Insecure.MD5.hash(data: data)
        return hash.map{String(format: "%02hhx", $0)}.joined()
    }
    
    private func buildURL(endpoint: String) -> URL? {
        let ts = String(Date().timeIntervalSince1970)
        let hash = generateHash(ts: ts)
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path += endpoint
        urlComponents?.queryItems = [
            URLQueryItem(name: "ts", value: ts),
            URLQueryItem(name: "apikey", value: publicKey),
            URLQueryItem(name: "hash", value: hash)
        ]
        
        return urlComponents?.url
    }
    
    func fetchComics() async throws -> [Comic]{
        guard let url = buildURL(endpoint: "/comics") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decoded = try JSONDecoder().decode(ComicModel.self, from: data)
            return decoded.data.results
        } catch {
            throw URLError(.cannotDecodeContentData)
        }
        
    }
}
