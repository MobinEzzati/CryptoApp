//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Mobin  Ezzati  on 8/15/24.
//

import Foundation
import UIKit



class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    func triggerImpactFeedback(style: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
      
        generator.notificationOccurred(style)
    }
}
