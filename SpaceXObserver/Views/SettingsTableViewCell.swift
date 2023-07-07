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
    static let identifier = String(describing: SettingsTableViewCell.self)
    weak var delegate: SettingsTableViewCellDelegate?

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
    public func configure(with parameter: Parameter, selectedUnitIndex: Int) {
        self.parameter = parameter
        textLabel?.text = parameter.title
        for (index, unit) in parameter.units.enumerated() {
            unitSegmentedControl.insertSegment(withTitle: unit, at: index, animated: false)
        }
        unitSegmentedControl.selectedSegmentIndex = selectedUnitIndex
    }

    @objc private func unitChanged() {
        guard let parameter = parameter else { return }
        delegate?.unitSelectionDidChange(parameter: parameter, selectedIndex: unitSegmentedControl.selectedSegmentIndex)
    }
}

// MARK: - SettingsTableViewCellDelegate
protocol SettingsTableViewCellDelegate: AnyObject {
    func unitSelectionDidChange(parameter: Parameter, selectedIndex: Int)
}
