//
//  OtherPauseMenuViewController.swift
//  Matching
//
//  Created by Hin Wong on 5/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class OtherPauseMenuViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var gamePausedOutlet: UILabel!
    @IBOutlet weak var resumeGameLabel: UILabel!
    @IBOutlet weak var theResumeButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Action
    
    @IBAction func theResumeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
