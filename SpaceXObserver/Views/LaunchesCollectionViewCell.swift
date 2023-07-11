//
//  LaunchesCollectionViewCell.swift
//  SpaceXObserver
//
//  Created by Владимир on 11.07.2023.
//

import UIKit

class LaunchesCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let statusLaunchImage = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
