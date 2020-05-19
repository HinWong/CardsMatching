//
//  AlertService.swift
//  Matching
//
//  Created by Hin Wong on 5/18/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

import UIKit

class AlertService {
    
    func alert() -> PauseMenuViewController {
        let storyboard = UIStoryboard(name: "PauseMenu", bundle: .main)
        guard let alertVC = storyboard.instantiateViewController(withIdentifier: "PauseVC") as? PauseMenuViewController else {return PauseMenuViewController() }
        return alertVC
    }
    
}
