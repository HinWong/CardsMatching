//
//  CardsCollectionViewCell.swift
//  Matching
//
//  Created by Hin Wong on 4/15/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class CardsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var backSideImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    //MARK: - Properties
    
    var card:Card?
    
    //MARK: - Card flipping functions
    
    func setCard(_ card: Card) {
        self.card = card
        
        if card.isMatched == true {
            backSideImageView.alpha = 0
            frontImageView.alpha = 0
            return
        } else {
            backSideImageView.alpha = 1
            frontImageView.alpha = 1
        }
        frontImageView.image = UIImage(named: card.cardImageName)
        
        //Determine if the card is flipped or not
        if card.isFlipped == true {
            UIView.transition(from: backSideImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: frontImageView, to: backSideImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip() {
        UIView.transition(from: backSideImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backSideImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
    }
    
    func remove() {
        backSideImageView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: { self.frontImageView.alpha = 0}, completion: nil)
    }
    
}
