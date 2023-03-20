//
//  AudioBookModel.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 28/12/22.
//

import Foundation
import SwiftUI

enum NetworkError: Error {
    case invalidResponse
    case decodingError
}

@MainActor
class AudioBookViewModel: ObservableObject {
    @Published var audioBooks: [AudioBookModel] = []
    
    func getAudioBooks() async throws {
        let urlString = "https://itunes.apple.com/search?term=adele"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let (data, respose) = try await URLSession.shared.data(from: url)
        guard let httpResponse = respose as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        guard let returnedResult = try? JSONDecoder().decode(Results.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        self.audioBooks = returnedResult.results
    }
}

struct Results: Codable, Hashable {
    let results: [AudioBookModel]
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}

struct AudioBookModel: Codable, Hashable {
    let artistName: String?
    let collectionName: String?
    let artworkUrl100: URL?
    let description: String?
    
    private enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case collectionName = "collectionName"
        case artworkUrl100 = "artworkUrl100"
        case description = "description"
    }
}

