//
//  Launches.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

struct LaunchQuery: Encodable {
    let query: RocketId
}

extension LaunchQuery  {
    struct RocketId: Encodable {
        let rocket: String
    }
}

struct LaunchResponse: Decodable {
    let docs: [Launch]
}

struct Launch: Decodable {
    let name: String
    let dateLocal: String?
    let success: Bool?
}
