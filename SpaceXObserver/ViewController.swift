//
//  ViewController.swift
//  SpaceXObserver
//
//  Created by Владимир on 29.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        APICaller.shared.getRockets { result in
            switch result {
            case .success(let rockets):
                print(rockets)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Do any additional setup after loading the view.
    }


}

