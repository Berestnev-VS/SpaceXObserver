//
//  SettingsTableViewCell.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {

    // MARK: - Properties
    static let identifier = String(describing: SettingsTableViewCell.self)
    private var parameter: Parameter?
    private let unitSegmentedControl = UISegmentedControl()

    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        unitSegmentedControl.addTarget(self, action: #selector(unitChanged), for: .valueChanged)
        unitSegmentedControl.frame = CGRect(x: 0, y: 0, width: 120, height: 40)
        accessoryView = unitSegmentedControl
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    @objc private func unitChanged() {
        guard let parameter = parameter else { return }
        UserDefaults.standard.set(unitSegmentedControl.selectedSegmentIndex, forKey: parameter.title)
    }

    public func configure(with parameter: Parameter, database: UserDefaults) {
        self.parameter = parameter
        textLabel?.text = parameter.title
        for (index, unit) in parameter.units.enumerated() {
            unitSegmentedControl.insertSegment(withTitle: unit, at: index, animated: false)
        }
        unitSegmentedControl.selectedSegmentIndex = database.integer(forKey: parameter.title)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        unitSegmentedControl.removeAllSegments()
    }
}
