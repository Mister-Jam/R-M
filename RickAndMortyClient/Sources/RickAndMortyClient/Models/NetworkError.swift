//
//  NetworkError.swift
//
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

public enum NetworkError: Error {
    case endpointError(message: String)
    case decodingError
    case noInternet
    case urlError
}

extension NetworkError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noInternet:
            return "No internet connection. Please check your network settings."
        case .endpointError(let message):
            return message
        case .decodingError:
            return "Something went wrong, and we are unable to show you this resource right now.\nPlease try again later"
        case .urlError:
            return "The requested resource is currently unreachable. Please try again later"
        }
    }
    
    static let defaultErrorMessage = "Sorry we can't make this happen right now."
}
