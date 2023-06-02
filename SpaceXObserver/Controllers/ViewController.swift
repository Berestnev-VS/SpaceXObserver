//
//  ViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - Properties
    private let apiCaller = APICaller()
    private let idRocketArray = ["5e9d0d95eda69973a809d1ec",
                                 "5e9d0d95eda69974db09d1ed"]

    private let rocketsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 12)
        textView.textColor = .black
        return textView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        rocketsTextView.frame = view.bounds
        view.addSubview(rocketsTextView)
        getRockets()
        getLaunches()
    }

    // MARK: - Methods
    private func getRockets() {
        apiCaller.getRockets { [weak self] result in
            switch result {
            case .success(let rockets):
                DispatchQueue.main.async {
                    self?.rocketsTextView.text = rockets.description
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func getLaunches() {
        apiCaller.getLaunches(forRocketID: "5e9d0d95eda69974db09d1ed") { result in
            switch result {
            case .success(let launches):
                print(launches)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
