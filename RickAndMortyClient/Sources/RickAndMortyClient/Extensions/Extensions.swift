//
//  Extensions.swift
//
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import Foundation

extension URLSession {
    enum HTTPMethod: String {
        case post = "POST"
        case get = "GET"
    }
    
    func makeApiRequest<T: Decodable>(
        from url: URL,
        type: T.Type,
        method: HTTPMethod, 
        requestData: Data? = nil,
        completion: @escaping ((Result<T, NetworkError>) -> Void)) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            if let data = requestData {
                urlRequest.httpBody = data
            }
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let httpResponse = response as? HTTPURLResponse {
                    print("The httpResponse: \(httpResponse.statusCode)")
                }
                guard let data = data,
                      error == nil else {
                    completion(.failure(.endpointError(message: error?.localizedDescription ?? NetworkError.defaultErrorMessage)))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                    
                } catch {
                    completion(.failure(.decodingError))
                }
            }.resume()
        }
}
