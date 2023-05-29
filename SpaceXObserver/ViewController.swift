//
//  ViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let rocketsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .boldSystemFont(ofSize: 12)
        textView.textColor = .black
        return textView
    }()
    
    override func viewDidLoad() {
        rocketsTextView.frame = CGRect(x: .zero, y: .zero, width: view.bounds.width, height: view.bounds.height / 2)
        view.addSubview(rocketsTextView)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRockets()
        getLaunches()
    }
    
    
    func getRockets(){
        APICaller.shared.getRockets() { [weak self] result in
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
    
    func getLaunches(){
        APICaller.shared.getLaunches() { result in
            switch result {
            case .success(let launches):
                print(launches)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
