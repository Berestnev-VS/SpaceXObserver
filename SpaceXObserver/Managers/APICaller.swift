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
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    private let session: URLSession
    private let baseURL = URL(string: "https://api.spacexdata.com/v4")!

    init(jsonEncoder: JSONEncoder = JSONEncoder(),
         jsonDecoder: JSONDecoder = JSONDecoder(),
         session: URLSession = URLSession.shared) {
        self.jsonDecoder = jsonDecoder
        self.jsonEncoder = jsonEncoder
        self.session = session
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    private func setupDecodingStrategy(for jsonDecoder: JSONDecoder, with dateFormat: String) {
        jsonDecoder.dateDecodingStrategy = .custom({ decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date: " + dateString)
        })
    }

    // MARK: - Request Methods
    private func performRequest<T: Decodable>(with request: URLRequest, dateFormat: String, completion: @escaping (Result<T, APIError>) -> Void) {
        setupDecodingStrategy(for: jsonDecoder, with: dateFormat)
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
        performRequest(with: URLRequest(url: rocketsURL), dateFormat: "yyyy-MM-dd", completion: completion)
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
            performRequest(with: request, dateFormat: "yyyy-MM-dd'T'HH:mm:ssZZZZZ", completion: completion)
        } catch {
            completion(.failure(.encodingFailed))
        }
    }

}
