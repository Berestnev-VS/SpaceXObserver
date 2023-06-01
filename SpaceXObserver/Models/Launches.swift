//
//  Launches.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

struct LaunchResponse: Decodable {
    let docs: [Launch]
}

struct Launch: Decodable {
    let staticFireDateUtc: String?
    let dateUtc: String?
    let staticFireDateUnix: Int?
    let success: Bool?
    let id: String
    let name: String
    let flightNumber: Int
}
