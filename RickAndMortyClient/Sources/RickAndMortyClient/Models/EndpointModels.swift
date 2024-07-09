//
//  File.swift
//  
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public typealias CharactersResponse = Result<RickAndMortyCharacterApiResponse, NetworkError>
public typealias CharacterResponse = Result<RickAndMortyCharacter, NetworkError>

public typealias EpisodesResponse = Result<RickAndMortyEpisodeApiResponse, NetworkError>
public typealias EpisodeResponse = Result<RickAndMortyEpisode, NetworkError>

public typealias LocationsResponse = Result<RickAndMortyLocationApiResponse, NetworkError>
public typealias LocationResponse = Result<RickAndMortyLocation, NetworkError>

public typealias RequestStatus = (Bool) -> Void
public struct RickAndMortyCharacterApiResponse: Decodable {
    public var info: ResponseInfo
    public var results: [RickAndMortyCharacter]
}

public struct RickAndMortyEpisodeApiResponse: Decodable {
    var info: ResponseInfo
    var results: [RickAndMortyEpisode]
}

public struct RickAndMortyLocationApiResponse: Decodable {
    var info: ResponseInfo
    var results: [RickAndMortyLocation]
}

