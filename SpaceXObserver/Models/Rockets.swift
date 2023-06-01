//
//  Rockets.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import Foundation

struct Rocket: Decodable {
    let id: String
    let name: String
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: Stage
    let secondStage: Stage
    let firstFlight: String
    let country: String
    let payloadWeights: [PayloadWeight]
    let active: Bool
    let costPerLaunch: Int
}

extension Rocket {
    struct Stage: Decodable {
        let engines: Int
        let fuelAmountTons: Double
        let burnTimeSec: Int?
    }

    struct Mass: Decodable {
        let kg, lb: Int
    }

    struct Diameter: Decodable {
        let meters, feet: Double?
    }

    struct PayloadWeight: Decodable {
        let kg, lb: Int
    }
}
