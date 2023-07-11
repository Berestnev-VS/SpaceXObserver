//
//  LaunchesCollectionViewCell.swift
//  SpaceXObserver
//
//  Created by Владимир on 11.07.2023.
//

import UIKit

final class LaunchesCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusLaunchImage = UIImageView()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray.withAlphaComponent(0.2)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(statusLaunchImage)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        titleLabel.font = .systemFont(ofSize: 22)
        titleLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .systemGray2
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let dateLabelConstraints: [NSLayoutConstraint] = [
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ]
        NSLayoutConstraint.activate(dateLabelConstraints)

        statusLaunchImage.translatesAutoresizingMaskIntoConstraints = false
        let statusLaunchImageConstraints: [NSLayoutConstraint] = [
            statusLaunchImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusLaunchImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statusLaunchImage.widthAnchor.constraint(equalToConstant: 50),
            statusLaunchImage.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(statusLaunchImageConstraints)
    }

    func configure(with launch: Launch) {
        let rocketDateFormatter = DateFormatter()
        rocketDateFormatter.dateFormat = "dd MMMM, yyyy"
        dateLabel.text = rocketDateFormatter.string(from: launch.dateLocal)
        titleLabel.text = launch.name
        if let status = launch.success {
            statusLaunchImage.image = status ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")
        } else {
            statusLaunchImage.image = UIImage(systemName: "questionmark")
        }
    }
}
