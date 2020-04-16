//
//  MainScreenViewController.swift
//  Matching
//
//  Created by Hin Wong on 4/16/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func playButton(_ sender: Any) {
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
}
