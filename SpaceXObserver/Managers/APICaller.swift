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
    private let rocketJsonDecoder: JSONDecoder
    private let launchJsonDecoder: JSONDecoder
    private let session: URLSession
    private let baseURL = URL(string: "https://api.spacexdata.com/v4")!

    init(jsonEncoder: JSONEncoder = JSONEncoder(),
         rocketJsonDecoder: JSONDecoder = JSONDecoder(),
         launchJsonDecoder: JSONDecoder = JSONDecoder(),
         session: URLSession = URLSession.shared) {

        self.rocketJsonDecoder = rocketJsonDecoder
        self.launchJsonDecoder = launchJsonDecoder
        self.jsonEncoder = jsonEncoder
        self.session = session

        let rocketDateFormatter = DateFormatter()
        rocketDateFormatter.dateFormat = "yyyy-MM-dd"
        rocketJsonDecoder.dateDecodingStrategy = .formatted(rocketDateFormatter)
        rocketJsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        launchJsonDecoder.dateDecodingStrategy = .iso8601
        launchJsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - Request Methods
    private func performRequest<T: Decodable>(with request: URLRequest, _ jsonDecoder: JSONDecoder, completion: @escaping (Result<T, APIError>) -> Void) {
        let task = session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.failedToGetData))
                return
            }
            do {
                let result = try jsonDecoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.failedToSerializeJson))
            }
        }
        task.resume()
    }

    func getRockets(completion: @escaping (Result<[Rocket], APIError>) -> Void) {
        let rocketsURL = baseURL.appendingPathComponent("rockets")
        performRequest(with: URLRequest(url: rocketsURL), rocketJsonDecoder, completion: completion)
    }

    func getLaunches(with rocketID: String, completion: @escaping (Result<LaunchResponse, APIError>) -> Void) {
        let launchesURL = baseURL.appendingPathComponent("launches/query")
        var request = URLRequest(url: launchesURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = LaunchQuery(query: .init(rocket: rocketID))
        do {
            let jsonData = try jsonEncoder.encode(body)
            request.httpBody = jsonData
            performRequest(with: request, launchJsonDecoder, completion: completion)
        } catch {
            completion(.failure(.encodingFailed))
        }
    }

}
