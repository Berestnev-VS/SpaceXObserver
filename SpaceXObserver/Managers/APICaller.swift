//
//  APICaller.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

// MARK: - Errors
enum APIError: Error {
    case failedToGetData
    case invalidURL
    case failedToSerializeJson
}

// MARK: - Manager
final class APICaller {
    // MARK: - Properties
    private let jsonDecoder: JSONDecoder
    private let session: URLSession
    private let baseURL = URL(string: "https://api.spacexdata.com/v4")!

    init(session: URLSession = URLSession.shared, jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.jsonDecoder = jsonDecoder
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Methods
    func performRequest<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) {
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

        let body = ["query": ["rocket": rocketID]]
        guard let jsonData = try? JSONEncoder().encode(body) else {
            completion(.failure(.failedToSerializeJson))
            return
        }
        request.httpBody = jsonData
        performRequest(with: request, completion: completion)
    }
}
