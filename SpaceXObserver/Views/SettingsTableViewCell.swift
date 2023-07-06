//
//  SettingsTableViewCell.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    static let identifier = "SettingsTableViewCell"

    var parameter: Parameter? {
        didSet {
            guard let parameter = parameter else { return }
            textLabel?.text = parameter.title
            unitSegmentedControl.removeAllSegments()
            for (index, unit) in parameter.units.enumerated() {
                unitSegmentedControl.insertSegment(withTitle: unit, at: index, animated: false)
            }
            unitSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: parameter.title)
        }
    }

    let unitSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        unitSegmentedControl.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
        unitSegmentedControl.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        accessoryView = unitSegmentedControl
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func unitChanged() {
        guard let parameter = parameter else { return }
        UserDefaults.standard.set(unitSegmentedControl.selectedSegmentIndex, forKey: parameter.title)
    }
}
