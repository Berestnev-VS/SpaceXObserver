//
//  UserDefaultsManager.swift
//  SpaceXObserver
//
//  Created by Владимир on 05.07.2023.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private init() {}

    func saveSelectedUnitIndex(for parameter: Parameter, index: Int) {
        UserDefaults.standard.set(index, forKey: parameter.title)
    }

    func getSelectedUnitIndex(for parameter: Parameter) -> Int {
        return UserDefaults.standard.integer(forKey: parameter.title)
    }
}

