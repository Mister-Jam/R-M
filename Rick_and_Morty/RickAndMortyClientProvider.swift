//
//  RickAndMortyClientProvider.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 09/07/2024.
//

import Foundation
//import RickAndMortyClient
typealias RickAndMortyCharactersResponse = Result<[ListItemCellModel], Error>

protocol RickAndMortyClientProvider: AnyObject {
    func fetchCharacters(page: Int?, apiInProgress: @escaping (Bool) -> Void, completion: @escaping (RickAndMortyCharactersResponse) -> Void )
    func fetchCharacter(id: Int) throws
}

final class RickAndMortyClientService: RickAndMortyClientProvider {
    
    static let shared = RickAndMortyClientService()
//    private let rickAndMortyClient = RickAndMortyService.shared
    func fetchCharacter(id: Int) throws {
        
    }
    
    func fetchCharacters(page: Int?, apiInProgress: @escaping (Bool) -> Void, completion: @escaping (RickAndMortyCharactersResponse) -> Void) {
//        rickAndMortyClient.retrieveCharacters(
//            page: page,
//            requestInProgress: apiInProgress) { response in
//                switch response {
//                case .success(let result):
//                    let data = result.results.map {
//                        let characterDetails = CharacterDetailsModel(
//                            characterName: $0.name ?? .emptyString, 
//                            characterImageString: $0.image ?? .emptyString,
//                            episodes: $0.episode,
//                            created: $0.created ?? .emptyString,
//                            status: $0.status ?? .emptyString,
//                            species: $0.species ?? .emptyString,
//                            gender: $0.gender ?? .emptyString,
//                            origin: $0.origin.name ?? .emptyString,
//                            location: $0.location.name ?? .emptyString)
//                        return ListItemCellModel(
//                            id: $0.id,
//                            characterTitle: $0.name ?? .emptyString,
//                            characterImage: $0.image ?? .emptyString,
//                            nextPageUrl: result.info.next, 
//                            characterDetails: characterDetails)
//                    }
//                    completion(.success(data))
//                case .failure(let error):
//                    completion(.failure(error))
//                }
//            }
    }
}
