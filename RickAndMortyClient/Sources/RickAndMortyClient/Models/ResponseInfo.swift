//
//  ResponseInfo.swift
//
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public struct ResponseInfo: Decodable {
    public let count: Int
    public let pages: Int
    public var next: String?
    public var prev: String?
}

