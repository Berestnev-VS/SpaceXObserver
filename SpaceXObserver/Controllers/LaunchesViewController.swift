//
//  LaunchesViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 11.07.2023.
//

import UIKit

final class LaunchesViewController: UIViewController {

    //MARK: - Properties
    private let apiCaller: APICaller
    private let dateFormatter = DateFormatter()
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var launches = [Launch]()
    private let rocketId: String

    //MARK: - init
    init(rocketId: String, apiCaller: APICaller = .init()) {
        self.rocketId = rocketId
        self.apiCaller = apiCaller
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupConstraints()
        fetchLaunches()
    }

    //MARK: - Methods
    private func setupCollectionView() {
        collectionView.register(LaunchesCollectionViewCell.self, forCellWithReuseIdentifier: LaunchesCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }

    private func fetchLaunches() {
        apiCaller.getLaunches(with: rocketId) { result in
            switch result {
            case .success(let launches):
                self.launches = launches.docs
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UICollectionViewDataSource
extension LaunchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCollectionViewCell.identifier,
                                                            for: indexPath) as? LaunchesCollectionViewCell else { return UICollectionViewCell() }
        let launch = launches[indexPath.row]
        let dateString = dateFormatter.string(from: launch.dateLocal)
        let image: UIImage
        if let status = launch.isSuccess {
            image = (status ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "xmark.circle")) ?? UIImage()
        } else {
            image = UIImage(systemName: "questionmark") ?? UIImage()
        }
        cell.configure(with: launch, dateString: dateString, image: image)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension LaunchesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width - 60, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        15
    }
}

