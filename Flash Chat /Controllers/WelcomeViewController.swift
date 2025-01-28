//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Rohit Kumar on 12/01/2024
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.text = K.AppName
        
//        titleLabel.text = ""
//        var charIndex = 0
//        let titleText = "⚡️FlashChat"
//        for letters in titleText{
//            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex) , repeats: false) { timer in
//                self.titleLabel.text?.append(letters)
//            }
//                charIndex += 1
//        }
//       
     }
    

}
