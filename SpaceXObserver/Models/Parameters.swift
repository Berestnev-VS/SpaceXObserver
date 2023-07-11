//
//  Parameters.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import Foundation

enum Parameter: CaseIterable {
    case height
    case diameter
    case mass
    case payload

    var title: String {
        switch self {
        case .height:
            return "Высота"
        case .diameter:
            return "Диаметр"
        case .mass:
            return "Масса"
        case .payload:
            return "Полезная нагрузка"
        }
    }

    var units: [String] {
        switch self {
        case .height, .diameter:
            return ["ft", "m"]
        case .mass, .payload:
            return ["lb", "kg"]
        }
    }
}
