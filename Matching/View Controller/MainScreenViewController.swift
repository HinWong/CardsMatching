//
//  MainScreenViewController.swift
//  Matching
//
//  Created by Hin Wong on 4/16/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit
import GameKit

class MainScreenViewController: UIViewController, GKGameCenterControllerDelegate {
    
    //MARK: - Properties
    
    var score = 0
    
   //MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticatePlayer()
    }
    
    @IBAction func playButton(_ sender: Any) {
        performSegue(withIdentifier: "toGameVC", sender: self)
    }
    
    //MARK: - Actions
    
    @IBAction func gameCenterButtonTapped(_ sender: Any) {
        let VC = self.view.window?.rootViewController
        let gameCenterVC = GKGameCenterViewController()
        gameCenterVC.gameCenterDelegate = self
        VC?.present(gameCenterVC, animated: true, completion: nil)
    }
    
//MARK: - Game Center Methods
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
    
    func authenticatePlayer() {
        let localPlayer = GKLocalPlayer.local
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                self.present(view!, animated: true, completion: nil)
            } else {
                print(GKLocalPlayer.local.isAuthenticated)
            }
        }
    }
    
    func saveHighScore(number: Int) {
        if GKLocalPlayer.local.isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "Best_Times")
            scoreReporter.value = Int64(number)
            let scoreArray: [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
        }
    }
}
