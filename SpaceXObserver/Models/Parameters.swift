//
//  Parameters.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import Foundation

enum Parameter: Int, CaseIterable {
    case height
    case diameter
    case mass
    case payload

    var title: String {
        switch self {
        case .height: return "Высота"
        case .diameter: return "Диаметр"
        case .mass: return "Масса"
        case .payload: return "Полезная нагрузка"
        }
    }

    var units: [String] {
        switch self {
        case .height, .diameter: return ["m", "ft"]
        case .mass, .payload: return ["kg", "lb"]
        }
    }
}
