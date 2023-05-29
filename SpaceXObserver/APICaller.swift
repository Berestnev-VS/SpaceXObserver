//
//  APICaller.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

enum APIError: Error {
    case failedToGetData
}
 
class APICaller {
    
    static let shared = APICaller()
    
    func getRockets(completion: @escaping (Result<[Rocket], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { 
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let rockets = try JSONDecoder().decode([Rocket].self, from: data)
                completion(.success(rockets))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getLaunches(completion: @escaping (Result<[Launch], Error>) -> Void) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { 
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                let launches = try JSONDecoder().decode([Launch].self, from: data)
                completion(.success(launches))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
}

