//
//  APICaller.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

enum APIError: Error {
    case failedToGetData
    case invalidURL
    case failedToSerializeJson
    case encodingFailed
}

final class APICaller {

    // MARK: - Properties
    private let jsonEncoder = JSONEncoder()
    private let jsonDecoder = JSONDecoder()
    private let dateFormatter = DateFormatter()
    private let session = URLSession.shared
    private let baseURL = URL(string: "https://api.spacexdata.com/v4")!

    init() {
        self.dateFormatter.dateFormat = "yyyy-MM-dd"
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        self.jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
    }

    // MARK: - Request Methods
    private func performRequest<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let result = try self.jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.failedToSerializeJson))
            }

        }
        task.resume()
    }

    func getRockets(completion: @escaping (Result<[Rocket], APIError>) -> Void) {
        let rocketsURL = baseURL.appendingPathComponent("rockets")
        performRequest(with: URLRequest(url: rocketsURL), completion: completion)
    }

    func getLaunches(forRocketID rocketID: String, completion: @escaping (Result<LaunchResponse, APIError>) -> Void) {
        let launchesURL = baseURL.appendingPathComponent("launches/query")
        var request = URLRequest(url: launchesURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LaunchQuery(query: .init(rocket: rocketID))
        do {
            let jsonData = try jsonEncoder.encode(body)
            request.httpBody = jsonData
            performRequest(with: request, completion: completion)
        } catch {
            completion(.failure(.encodingFailed))
        }
    }
}
