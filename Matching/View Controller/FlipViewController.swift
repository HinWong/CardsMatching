//
//  FlipViewController.swift
//  Matching
//
//  Created by Hin Wong on 5/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class FlipViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Outlets
    
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var cardsCollectionView: UICollectionView!
    
    //MARK: - Properties
    var model = CardController()
    var cardArray = [Card]()
    var firstFlippedIndex: IndexPath?
    var flips = 24
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        cardArray = model.generateCards()
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        setUpMovesLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SoundManager.playSound(.shuffle)
    }
    
    //MARK: - Actions
    
    let customAlert = CustomAlert()
    
    @IBAction func pauseGameButtonTapped(_ sender: Any) {
        let customAlertVC = customAlert.customAlert()
        present(customAlertVC, animated: true)
    }
    
    @IBAction func theQuitButtonTapped(_ sender: Any) {
        restartingGame()
    }
    
    //MARK: - Moves Methods
    func setUpMovesLabel() {
        movesLabel.text = "Moves Remaining: \(flips)"
    }
    
    //MARK: - Collection view protocol methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardsCell", for: indexPath) as? CardsCollectionViewCell else { return UICollectionViewCell() }
        let cards = cardArray[indexPath.row]
        cell.setCard(cards)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if flips == 0 {
            return
        }
        let cardCell = collectionView.cellForItem(at: indexPath) as! CardsCollectionViewCell
        let aCard = cardArray[indexPath.row]
        
        if aCard.isFlipped == false && aCard.isMatched == false {
            cardCell.flip()
            SoundManager.playSound(.flip)
            aCard.isFlipped = true
            flips -= 1
            movesLabel.text = "Moves Remaining: \(flips)"
            
            //Determine if it's the 1st or 2nd card that's flipped over
            if firstFlippedIndex == nil {
                firstFlippedIndex = indexPath
            } else {
                //Second card being flipped
                checkCardMatches(indexPath)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cardCollectionWidth = cardsCollectionView.bounds.width
        let cardCollectionHeight = cardsCollectionView.bounds.height
        
        return CGSize(width: cardCollectionWidth * 0.3, height: cardCollectionHeight * 0.225)
    }
    
    //MARK: - Game logic
    
    func checkCardMatches(_ secondFlippedIndex: IndexPath) {
        let firstCardCell = cardsCollectionView.cellForItem(at: firstFlippedIndex!) as? CardsCollectionViewCell
        let secondCardCell = cardsCollectionView.cellForItem(at: secondFlippedIndex) as? CardsCollectionViewCell
        
        let firstCard = cardArray[firstFlippedIndex!.row]
        let secondCard = cardArray[secondFlippedIndex.row]
        
        //Compare the two cards
        if firstCard.cardImageName == secondCard.cardImageName {
            //It's a match
            
            //Set the status of the cards
            firstCard.isMatched = true
            secondCard.isMatched = true
            SoundManager.playSound(.match)
            
            firstCardCell?.remove()
            secondCardCell?.remove()
            
            checkGameCondition()
        } else {
            //Not a match
            
            //Set the statuses of the cards
            firstCard.isFlipped = false
            secondCard.isFlipped = false
            SoundManager.playSound(.noMatch)
            
            firstCardCell?.flipBack()
            secondCardCell?.flipBack()
        }
        //Tell the collection view to reload the cell of the first card if it's nil
        if firstCardCell == nil {
            cardsCollectionView.reloadItems(at: [firstFlippedIndex!])
        }
        //Reset the property that tracks the first card flipped
        firstFlippedIndex = nil
    }
    
    func checkGameCondition() {
        var gameWon = true
        for card in cardArray {
            if card.isMatched == false {
                gameWon = false
                break
            }
        }
        //Message variables
        var title = ""
        var message = ""
        
        //Player won
        if gameWon == true {
            if flips > 0 {
                movesLabel.textColor = UIColor.red
            }
            title = "Great Job"
            message = "You won"
            
        }
        else {
            //If unmatched cards remain, check if there are still flips left
            if flips > 0 {
                return
            }
            title = "No more moves"
            message = "You lost"
            movesLabel.textColor = UIColor.red
        }
        setUpAlerts(title, message)
    }
    
    func setUpAlerts(_ title: String, _ message: String) {
        let gameAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //Restart button functionality
        let gameRestarting = UIAlertAction(title: "Restart", style: .default) {action -> Void in self.restartingGame()}
        gameAlert.addAction(gameRestarting)
        present(gameAlert, animated: true, completion: nil)
    }
    
    func restartingGame() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    }
    
}//End of view controller class
