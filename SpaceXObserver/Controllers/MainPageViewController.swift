//
//  ViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import UIKit

final class MainPageViewController: UIPageViewController {

    // MARK: - Properties
    private let apiCaller = APICaller()
    private let rocketId = "5e9d0d95eda69974db09d1ed"

    private let rocketsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 12)
        textView.textColor = .black
        textView.backgroundColor = .clear
        return textView
    }()

    lazy var viewControllersArray: [UIViewController] = {
        let vc1 = UIViewController()
        vc1.view.backgroundColor = .systemGreen

        let vc2 = UIViewController()
        vc2.view.backgroundColor = .systemBlue

        let vc3 = UIViewController()
        vc3.view.backgroundColor = .systemYellow

        let vc4 = UIViewController()
        vc4.view.backgroundColor = .systemMint

        return [vc1, vc2, vc3, vc4]
    }()

    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        getRockets()
        getLaunches()
        setupRocketTextView()
    }

    // MARK: - Methods
    private func setupRocketTextView() {
        if let firstViewController = viewControllersArray.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            rocketsTextView.frame = firstViewController.view.bounds
            firstViewController.view.addSubview(rocketsTextView)
        }
    }

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
        apiCaller.getLaunches(with: rocketId) { result in
            switch result {
            case .success(let launches):
                print(launches)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension MainPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersArray.firstIndex(of: viewController), index > 0
        else { return nil }
        let previousIndex = index - 1
        return viewControllersArray[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllersArray.firstIndex(of: viewController), index < (viewControllersArray.count - 1)
        else { return nil }
        let nextIndex = index + 1
        return viewControllersArray[nextIndex]
    }
}
