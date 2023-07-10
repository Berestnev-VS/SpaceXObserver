//
//  SettingsTableViewCell.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import UIKit

final class SettingsTableViewCell: UITableViewCell {
    // MARK: - Properties
    private let unitSegmentedControl = UISegmentedControl()
    private var parameter: Parameter?
    private var onChangeUnit: ((Int) -> Void)?

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

    // MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        unitSegmentedControl.removeAllSegments()
    }

    // MARK: - Methods
    public func configure(with parameter: Parameter, selectedUnitIndex: Int, onChangeUnit: @escaping (Int) -> Void) {
        self.parameter = parameter
        self.onChangeUnit = onChangeUnit
        textLabel?.text = parameter.title
        for unit in parameter.units {
            unitSegmentedControl.insertSegment(withTitle: unit, at: 0, animated: false)
        }
        unitSegmentedControl.selectedSegmentIndex = selectedUnitIndex
    }

    @objc private func unitChanged() {
        onChangeUnit?(unitSegmentedControl.selectedSegmentIndex)
    }
}
