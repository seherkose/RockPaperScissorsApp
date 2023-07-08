//
//  GameResultViewController.swift
//  RockPaperScissorsApp
//
//  Created by Seher Köse on 6.07.2023.
//

import UIKit

class GameResultViewController: UIViewController {
    var playerChoice: RPS!
    var computerChoice: RPS!
    var result: String?
    
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var playerChoice1: UITextField!
    
    @IBOutlet weak var computerChoice1: UITextField!
    
    @IBOutlet weak var result1: UITextField!
    override func viewDidLoad() {
        view2.layer.cornerRadius = 35
        
        playerChoice1.text = "Player Choice:               \(playerChoice.rawValue)"
        computerChoice1.text = "Computer Choice:           \(computerChoice.rawValue)"
        result1.text = "\(result ?? "0")"
        
        
        result1.borderStyle = .none
  
    }

}
