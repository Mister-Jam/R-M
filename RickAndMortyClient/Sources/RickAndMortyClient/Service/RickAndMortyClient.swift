// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public final class RickAndMortyService {
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 120
        return URLSession(configuration: configuration)
    }()
    
    public static let shared = RickAndMortyService()
    
    public func retrieveCharacters(
        page: Int? = nil,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (CharactersResponse) -> Void
    ) {
            requestInProgress(true)
            guard let characterUrl = getUrl(for: .characters(), page: page) else {
                completion(.failure(.urlError))
                return
            }
            makeAPIRequest(
                url: characterUrl,
                type: RickAndMortyCharacterApiResponse.self,
                requestInProgress: requestInProgress,
                completion: completion)
        }
    
    public func retrieveSelectedCharacter(
        id: Int,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (CharacterResponse) -> Void
    ) {
        guard let characterUrl = getUrl(for: .characters(id)) else {
            completion(.failure(.urlError))
            return
        }
        makeAPIRequest(
            url: characterUrl,
            type: RickAndMortyCharacter.self,
            requestInProgress: requestInProgress,
            completion: completion)
    }
    
    public func retrieveEpisodes(
        page: Int? = nil,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (EpisodesResponse) -> Void
    ) {
        guard let episodesUrl = getUrl(for: .episodes(), page: page) else {
            completion(.failure(.urlError))
            return
        }
        makeAPIRequest(
            url: episodesUrl,
            type: RickAndMortyEpisodeApiResponse.self,
            requestInProgress: requestInProgress,
            completion: completion)
    }
    
    public func retrieveSelectedEpisode(
        id: Int,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (EpisodeResponse) -> Void
    ) {
        guard let episodeUrl = getUrl(for: .episodes(id)) else {
            completion(.failure(.urlError))
            return
        }
        makeAPIRequest(
            url: episodeUrl,
            type: RickAndMortyEpisode.self,
            requestInProgress: requestInProgress,
            completion: completion)
    }
    
    public func retrieveLocations(
        page: Int? = nil,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (LocationsResponse) -> Void
    ) {
        guard let locationsUrl = getUrl(for: .location(), page: page) else {
            completion(.failure(.urlError))
            return
        }
        makeAPIRequest(
            url: locationsUrl,
            type: RickAndMortyLocationApiResponse.self,
            requestInProgress: requestInProgress,
            completion: completion)
    }
    
    public func retrieveSelectedLocation(
        id: Int,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping (LocationResponse) -> Void
    ) {
        guard let locationUrl = getUrl(for: .location(id)) else {
            completion(.failure(.urlError))
            return
        }
        makeAPIRequest(
            url: locationUrl,
            type: RickAndMortyLocation.self,
            requestInProgress: requestInProgress,
            completion: completion)
    }
    
    private func getUrl(
        for type: RickAndMortyPaths,
        page: Int? = nil
    ) -> URL? {
        let queryItems = [URLQueryItem]()
            .addParameter(type: .page, value: page == nil ? nil : "\(page!)")
        return type.buildUrl(with: queryItems)
    }
    
    private func makeAPIRequest<T: Decodable>(
        url: URL,
        type: T.Type,
        requestInProgress: @escaping RequestStatus,
        completion: @escaping ((Result<T, NetworkError>) -> Void)
    ) {
        requestInProgress(true)
        session.makeApiRequest(
            from: url,
            type: type,
            method: .get) { response in
                requestInProgress(false)
                switch response {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
                
            }
    }
}
