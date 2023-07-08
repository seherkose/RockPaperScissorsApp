//
//  ViewController.swift
//  RockPaperScissorsApp
//
//  Created by Seher Köse on 6.07.2023.
//

import UIKit
enum RPS: String {
    case rock =   "✊"
    case paper =  "✋"
    case scissors = "✌️"
}



class ViewController: UIViewController {
    private var playerScore = 0
    private var computerScore = 0

    @IBOutlet weak var rockButton: UIButton!
    @IBOutlet weak var paperButton: UIButton!
    @IBOutlet weak var scissorsButton: UIButton!
    
    @IBOutlet weak var playerScoreLabel: UITextField!
    
    @IBOutlet weak var computerScoreLabel: UITextField!
    
    @IBOutlet weak var playerChoiceLabel: UITextField!
    
    @IBOutlet weak var computerChoiceLabel: UITextField!
    
    @IBOutlet weak var resultLabel: UITextField!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var view1: UIView!
    
    override func viewDidLoad() {
        
        view1.layer.cornerRadius = 35
        
        super.viewDidLoad()
        rockButton.clipsToBounds = true
        rockButton.contentMode = .scaleAspectFill

        // Use setBackgroundImage or setImage
        rockButton.setBackgroundImage(UIImage(named: "rock"), for: .normal)
        
    }
   
         func playGame(_ playerChoice: RPS) {
            let computerChoice = getComputerChoice()

            //playerChoiceLabel.text = "Player Choice: \(playerChoice.rawValue)"
            //computerChoiceLabel.text = "Computer Choice: \(computerChoice.rawValue)"

            let result = getResult(playerChoice, computerChoice)
            //resultLabel.text = "Result: \(result) "

            updateScores(result)

             //playerScoreLabel.text = "Your Score: \(playerScore)"
             //computerScoreLabel.text = "Computer Score: \(computerScore)"

            if playerScore >= 5 || computerScore >= 5 {
                gameOver()
            }else {
                navigateToGameResult(playerChoice: playerChoice, computerChoice: computerChoice, result: result)
            }
        }
    
        override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        playerScoreLabel.text = "Your Score: \(playerScore)"
        computerScoreLabel.text = "Computer Score: \(computerScore)"
        }
    
    
    
       func navigateToGameResult(playerChoice: RPS, computerChoice: RPS, result: String) {
        
                
        self.activityIndicator.stopAnimating()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let gameResultVC = storyboard.instantiateViewController(withIdentifier: "GameResultViewController") as? GameResultViewController else {
            return
        }
        gameResultVC.playerChoice = playerChoice
        gameResultVC.computerChoice = computerChoice
        gameResultVC.result = result
        //self.navigationController?.pushViewController(gameResultVC, animated: true)
        
        DispatchQueue.main.async {
               self.activityIndicator.startAnimating()
               DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                   self.activityIndicator.stopAnimating()
                   self.navigationController?.pushViewController(gameResultVC, animated: true)
               }
           }
   
    }
        func getComputerChoice() -> RPS {
            let choices: [RPS] = [.rock, .paper, .scissors]
            let randomIndex = Int.random(in: 0..<choices.count)
            return choices[randomIndex]
        }

         func getResult(_ playerChoice: RPS, _ computerChoice: RPS) -> String {
            if playerChoice == computerChoice {
                return "Scoreless!"
            } else if (playerChoice == .rock && computerChoice == .scissors) ||
                      (playerChoice == .paper && computerChoice == .rock) ||
                      (playerChoice == .scissors && computerChoice == .paper) {
                return "You won!"
            } else {
                return "Computer won!"
            }
        }

       func updateScores(_ result: String) {
            if result.contains("You won!") {
                playerScore += 1
            } else if result.contains("Computer won!") {
                computerScore += 1
            }
        }

         func gameOver() {
            let message: String
            if playerScore > computerScore {
                message = "You won!"
            } else {
                message = "Computer won!"
            }
            let alertController = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
                self?.resetGame()
            }
            alertController.addAction(restartAction)
            present(alertController, animated: true, completion: nil)
        }
    

         func resetGame() {
            playerScore = 0
            computerScore = 0
            //playerChoiceLabel.text = nil
            //computerChoiceLabel.text = nil
            //resultLabel.text = nil
            playerScoreLabel.text = "Your Score: 0"
            computerScoreLabel.text = "Computer Score: 0"
        }
        
        
    @IBAction func clearButton(_ sender: Any) {
        gameOver()
    }
    
    @IBAction func rockButtonTapped(_ sender: Any) {
        playGame(.rock)
    }
    
    @IBAction func paperButtonTapped(_ sender: Any) {
        playGame(.paper)
    }
    
    @IBAction func scissorsButtonTapped(_ sender: Any) {
        playGame(.scissors)
    }
    
    @IBAction func playButtonAct(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "You should pick one item to match!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Play", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
  
    }
    
}

