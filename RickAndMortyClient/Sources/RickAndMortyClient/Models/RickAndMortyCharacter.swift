//
//  RickAndMortyCharacter.swift
//  
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public struct RickAndMortyCharacter: Decodable {
    public let id: Int
    public var name: String?
    public var status: String?
    public var species: String?
    public var type: String?
    public var gender: String?
    public var origin: CharacterOrigin
    public var location: CharacterLocation
    public var image: String?
    public var episode: [String]
    public var url: String?
    public var created: String?
}

public struct CharacterLocation: Decodable {
    public var name: String?
    public var url: String?
}

public struct CharacterOrigin: Decodable {
    public var name: String?
    public var url: String?
}
