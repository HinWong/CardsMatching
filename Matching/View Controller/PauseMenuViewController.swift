//
//  PauseMenuViewController.swift
//  Matching
//
//  Created by Hin Wong on 5/18/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit



class PauseMenuViewController: UIViewController {
    
    //MARK: - Outlet
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Action
    
    @IBAction func resumeButtonTapped(_ sender: Any) {
        dismiss(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "gameTimer"), object: nil)
    }
}
