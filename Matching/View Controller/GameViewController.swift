//
//  GameViewController.swift
//  Matching
//
//  Created by Hin Wong on 4/15/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit
import GameKit

class GameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Outlets
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var cardCollectionView: UICollectionView!
    
    //MARK: - Properties
    var model = CardController()
    var cardArray = [Card]()
    var firstFlippedCardIndex: IndexPath?
    var timer: Timer?
    var milliseconds: Float = 60 * 1000 // 60 seconds on timer
    private let spacing:CGFloat = 16.0
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cardArray = model.generateCards()
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SoundManager.playSound(.shuffle)
    }
    
    //MARK: - Timer Methods
    @objc func timerElapsed() {
        milliseconds -= 1
        let seconds = String(format: "%.2f", milliseconds/1000)
        timerLabel.text = "Time Remaning: \(seconds)"
        
        if milliseconds <= 0 {
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
    }
    
    //MARK: - Collection View Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardsCollectionViewCell else { return UICollectionViewCell()}
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if milliseconds <= 0 {
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! CardsCollectionViewCell
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            cell.flip()
            SoundManager.playSound(.flip)
            card.isFlipped = true
            
            //Determine if it's the 1st or 2nd card that's flipped over
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            } else {
                //Second card being flipped
                checkForMatches(indexPath)
            }
        }
    }//End of didSelectItemAt
    
    //Sizing the collection view cell based on screen size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionWidth = cardCollectionView.bounds.width
        return CGSize(width: collectionWidth * 0.3, height: collectionWidth * 0.45)
    }
  
    //MARK: - Game logic
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        let cardOneCell = cardCollectionView.cellForItem(at: firstFlippedCardIndex!) as? CardsCollectionViewCell
        let cardTwoCell = cardCollectionView.cellForItem(at: secondFlippedCardIndex) as? CardsCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Compare the 2 cards
        if cardOne.cardImageName == cardTwo.cardImageName {
            //It's a match
            
            //Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            SoundManager.playSound(.match)
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
        } else {
            //Not a match
            
            //Set statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            SoundManager.playSound(.noMatch)
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        //Tell the collection view to reload the cell of the first card if it's nil
        if cardOneCell == nil {
            cardCollectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        //Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded() {
        var isWon = true
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        //Message variables
        var title = ""
        var message = ""
        
        //Stop the timer, player won
        if isWon == true {
            if milliseconds > 0 {
                timer?.invalidate()
            }
            title = "Great Job"
            message = "You won"
        } else {
            // If unmatched cards remain, check if there are still time left
            if milliseconds > 0 {
                return
            }
            title = "Time's up"
            message = "You lost"
        }
        showAlert(title, message)
    }
    
    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //Restart button
        let restartingGame = UIAlertAction(title: "Restart", style: .default) {action -> Void in self.restartGame()}
        alert.addAction(restartingGame)
        present(alert, animated: true, completion: nil)
    }
    
    func restartGame() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
}//End of View Controller class
