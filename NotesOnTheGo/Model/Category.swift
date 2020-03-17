//
//  Category.swift
//  NotesOnTheGo
//
//  Created by Cristian Sedano Arenas on 17/03/2020.
//  Copyright © 2020 Cristian Sedano Arenas. All rights reserved.
//

import Foundation
import UIKit

extension Category {
    
    var color : UIColor? {
        
        get {
            
            guard let hex = colorHex else { return nil }
            return UIColor(hex: hex)
        }
        
        set(newColor) {
            
            if let newColor = newColor {
                colorHex = newColor.toHex
            }
        }
    }
}
