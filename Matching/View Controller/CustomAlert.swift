//
//  CustomAlert.swift
//  Matching
//
//  Created by Hin Wong on 5/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class CustomAlert {
    
    func alert() -> OtherPauseMenuViewController {
        let storyboard = UIStoryboard(name: "AnotherPause", bundle: .main)
        guard let alertViewController = storyboard.instantiateViewController(withIdentifier: "PauseVC") as? OtherPauseMenuViewController else {return OtherPauseMenuViewController() }
        return alertViewController
    }
    
}
