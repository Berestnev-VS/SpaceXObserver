//
//  UserDefaultsManager.swift
//  SpaceXObserver
//
//  Created by Владимир on 05.07.2023.
//

import Foundation

final class UserDefaultsManager {
    public func saveSelectedUnitIndex(for parameter: Parameter, index: Int) {
        UserDefaults.standard.set(index, forKey: parameter.title)
    }

    public func getSelectedUnitIndex(for parameter: Parameter) -> Int {
        return UserDefaults.standard.integer(forKey: parameter.title)
    }
}

