//
//  RickAndMortyLocation.swift
//
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public struct RickAndMortyLocation: Decodable {
    public let id: Int
    public var name: String?
    public var type: String?
    public var dimension: String?
    public var residents: [String]
    public var url: String?
    public var created: String?
}
