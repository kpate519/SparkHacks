//
//  FountainClient.swift
//  Everyday 2.0
//
//  Created by Nour Alsramah on 2/8/25.
//

import Foundation



struct FountainClient {
    static let shared = FountainClient()
    private init() {}
    private enum FountainClientError: Error {
        case invalidResponse
        case decodingError(Error)
    }
    
//    func fetchFountains(at url: URL) async throws -> [Fountain]{
//        let (data, response) = try await URLSession.shared.data(from: url)
//        guard let httpResponse = response as? HTTPURLResponse,
//                  httpResponse.statusCode == 200 else {
//            throw FountainClientError.invalidResponse
//        }
//        
//        do {
//            return try JSONDecoder().decode([Fountain].self, from: data)
//        } catch {
//            throw FountainClientError.decodingError(error)
//        }
//    }
    func loadJSON() -> [Fountain]? {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("Failed to locate file.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let fountains = try decoder.decode([Fountain].self, from: data)
            return fountains
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
    

