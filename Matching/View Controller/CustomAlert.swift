//
//  CustomAlert.swift
//  Matching
//
//  Created by Hin Wong on 5/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class CustomAlert {
    
    func customAlert() -> OtherPauseMenuViewController {
        let storyboard = UIStoryboard(name: "AnotherPause", bundle: .main)
        guard let alertViewController = storyboard.instantiateViewController(withIdentifier: "anotherPauseVC") as? OtherPauseMenuViewController else {return OtherPauseMenuViewController() }
        return alertViewController
    }
    
}
