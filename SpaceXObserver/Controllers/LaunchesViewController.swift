//
//  LaunchesViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 11.07.2023.
//

import UIKit

final class LaunchesViewController: UIViewController {

    //MARK: - Properties
    private let layout = UICollectionViewFlowLayout()
    private var collectionView: UICollectionView?
    private let apiCaller = APICaller()
    private var launches = [Launch]()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        fetchLaunches()
    }

    //MARK: - Methods
    private func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.itemSize = CGSize(width: view.frame.width - 60, height: 100)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(LaunchesCollectionViewCell.self, forCellWithReuseIdentifier: LaunchesCollectionViewCell.identifier)
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.frame = view.bounds
        view.addSubview(collectionView)
    }

    private func fetchLaunches() {
        apiCaller.getLaunches(with: "5e9d0d95eda69974db09d1ed") { result in
            switch result {
            case .success(let launches):
                self.launches = launches.docs
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension LaunchesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        launches.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LaunchesCollectionViewCell.identifier,
                                                            for: indexPath) as? LaunchesCollectionViewCell else { return UICollectionViewCell()}
        let launch = launches[indexPath.row]
        cell.configure(with: launch)
        return cell
    }
}

