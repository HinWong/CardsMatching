//
//  SoundManager.swift
//  Matching
//
//  Created by Hin Wong on 4/14/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    
    static var audioPlayer: AVAudioPlayer?
    
    enum soundEffect {
        case flip
        case shuffle
        case match
        case noMatch
    }
    
    static func playSound(_ effect: soundEffect) {
        var soundFileName = ""
        
        //Determine which sound effect to play
        switch effect {
        case .flip:
            soundFileName = "cardflip"
        case .shuffle:
            soundFileName = "shuffle"
        case .match:
            soundFileName = "dingcorrect"
        case .noMatch:
            soundFileName = "dingwrong"
        }
        
        // Get the path to the sound file
        let bundlePath = Bundle.main.path(forResource: soundFileName, ofType: "wav")
        guard bundlePath != nil else {
            print("Could not find the sound file \(soundFileName) in the bundle")
            return
        }
        
        //Create a URL object
        let soundURL = URL(fileURLWithPath: bundlePath!)
        do {
            // Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
            //
        } catch {
            print("Couldn't create audio player object")
        }
    
    }
}
