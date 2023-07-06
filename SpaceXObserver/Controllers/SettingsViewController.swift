//
//  SettingsViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 03.07.2023.
//

import UIKit

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let userDefaultsManager = UserDefaultsManager()
    private var selectedUnitIndices: [Int] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        view.addSubview(tableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupConstraints()
    }

    // MARK: - Methods
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.identifier)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Parameter.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier,
                                                       for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        let parameter = Parameter.allCases[indexPath.row]
        let selectedUnitIndex = userDefaultsManager.getSelectedUnitIndex(for: parameter)
        cell.configure(with: parameter, selectedUnitIndex: selectedUnitIndex)
        cell.delegate = self
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

// MARK: - SettingsTableViewCellDelegate
extension SettingsViewController: SettingsTableViewCellDelegate {
    func unitSelectionDidChange(parameter: Parameter, selectedIndex: Int) {
        userDefaultsManager.saveSelectedUnitIndex(for: parameter, index: selectedIndex)
    }
}
