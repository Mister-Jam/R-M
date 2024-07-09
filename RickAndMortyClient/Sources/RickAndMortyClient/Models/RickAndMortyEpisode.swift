//
//  RickAndMortyEpisode.swift
//  
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public struct RickAndMortyEpisode: Decodable {
    public let id: Int
    public var name: String?
    public var airDate: String?
    public var episode: String?
    public var characters: [String]
    public var url: String?
    public var created: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
        case url
        case created
    }
}
