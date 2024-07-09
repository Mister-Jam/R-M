//
//  RickAndMortyPaths.swift
//
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

enum RickAndMortyPaths {
    case characters(Int? = nil)
    case location(Int? = nil)
    case episodes(Int? = nil)
    
    var path: String {
        switch self {
        case .characters(let characterId):
            let characterPath = characterId == nil ? "" : "/\(characterId ?? .zero)"
            return "/api/character" + characterPath
        case .location(let locationId):
            let locationPath = locationId == nil ? "" : "/\(locationId ?? .zero)"
            return "/api/location" + locationPath
        case .episodes(let episodeId):
            let episodePath = episodeId == nil ? "" : "/\(episodeId ?? .zero)"
            return "/api/episode" + episodePath
        }
    }
    
    func buildUrl(with queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "rickandmortyapi.com"
        urlComponents.path = self.path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

public enum FilterItems: String {
    case name
    case type
    case dimension
    case episode
    case status
    case species
    case gender
    case page
}

extension [URLQueryItem] {
    func addParameter(
        type: FilterItems,
        value: String?) -> [URLQueryItem] {
            var queryArray = self
            guard let value else { return queryArray }
            queryArray.append(.init(name: type.rawValue, value: value))
            return queryArray
        }
}
