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
        [titleLabel, dateLabel, statusLaunchImage].forEach(contentView.addSubview)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    func configure(with launch: Launch, dateString: String, image: UIImage?) {
        let rocketDateFormatter = DateFormatter()
        rocketDateFormatter.dateFormat = "dd MMMM, yyyy"
        dateLabel.text = dateString
        titleLabel.text = launch.name
        statusLaunchImage.image = image
    }

    private func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 20
        layer.cornerCurve = .continuous
        contentView.backgroundColor = .systemGray.withAlphaComponent(0.2)
        titleLabel.font = .systemFont(ofSize: 21)
        titleLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .systemGray2
    }

    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLaunchImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: statusLaunchImage.leadingAnchor, constant: -5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -5),

            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5),

            statusLaunchImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            statusLaunchImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statusLaunchImage.widthAnchor.constraint(equalToConstant: 50),
            statusLaunchImage.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
