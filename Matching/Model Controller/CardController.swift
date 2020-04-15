//
//  CardController.swift
//  Matching
//
//  Created by Hin Wong on 4/14/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation

class CardController {
    
    func generateCards() -> [Card] {
        var randomNumbersArray = [Int]()
        var randomCardsArray = [Card]()
        
        //Generate unique pairs of cards
        while randomCardsArray.count < 8 {
            let randomNumber = arc4random_uniform(13) + 1
            if randomNumbersArray.contains(Int(randomNumber)) == false {
                print(randomNumber)
                randomNumbersArray.append(Int(randomNumber))
                
                let cardOne = Card()
                cardOne.cardImageName = "card\(randomNumber)"
                randomCardsArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.cardImageName = "card\(randomNumber)"
                randomCardsArray.append(cardTwo)
                
            }
        }
        
        //Randomize the array
        for i in 0 ... randomCardsArray.count - 1 {
            let randomNumber = Int(arc4random_uniform(UInt32(randomCardsArray.count)))
            
            let temporaryStorage = randomCardsArray[i]
            randomCardsArray[i] = randomCardsArray[randomNumber]
            randomCardsArray[randomNumber] = temporaryStorage
        }
        
        return (randomCardsArray)
    }
    
} //End of class
