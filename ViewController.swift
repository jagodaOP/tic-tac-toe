//
//  ViewController.swift
//  TicTacToe_iOS
//
//  Created by Amar Sahbazovic on 8/30/23.
//

import UIKit

class ViewController: UIViewController {
    
    enum playerMove{
        case nought
        case cross
    }
    
    @IBOutlet weak var turnLabel: UILabel!
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    var firstMove = playerMove.cross
    var currentMove = playerMove.cross
    
    var NOUGHT = "O"
    var CROSS = "X"
    var board = [UIButton]()
    
    var noughtScore = 0
    var crossScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBoard()
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)

    }
    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        if victoryCheck(CROSS){
            crossScore += 1
            endResultAlert(title: "Crosses take this one!")
        }
        
        if victoryCheck(NOUGHT){
            noughtScore += 1
            endResultAlert(title: "Noughts bring home the W!")
        }
        
        if (fullBoard()){
            
            endResultAlert(title: "Draw")
        }
    }
    
    func victoryCheck(_ s :String) -> Bool {
        // Possible Horizontal Wins
        if thisSymbol(a1, s) && thisSymbol(a2, s) && thisSymbol(a3, s) {
            return true
        }
        if thisSymbol(b1, s) && thisSymbol(b2, s) && thisSymbol(b3, s) {
            return true
        }
        if thisSymbol(c1, s) && thisSymbol(c2, s) && thisSymbol(c3, s) {
            return true
        }
        // Possible Diagonal Wins
        if thisSymbol(a1, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c1, s) {
            return true
        }
        // Possible Vertical Wins
        if thisSymbol(a1, s) && thisSymbol(b1, s) && thisSymbol(c1, s) {
            return true
        }
        if thisSymbol(a2, s) && thisSymbol(b2, s) && thisSymbol(c2, s) {
            return true
        }
        if thisSymbol(a3, s) && thisSymbol(b2, s) && thisSymbol(c3, s) {
            return true
        }
        return false
    }
    
    func thisSymbol(_ button: UIButton, _ symbol: String) -> Bool {
        return button.title(for: .normal) == symbol
    }
    
    func endResultAlert(title: String) {
        let scoreMessage = "\nNoughts " + String(noughtScore) + "\n\nCrosses " + String(crossScore)
        let ac = UIAlertController(title: title, message: scoreMessage, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Reset", style: .default, handler: { (_) in
            self.resetBoard()
        }))
        self.present(ac, animated: true)
    }
    
    func resetBoard() {
        for button in board {
            button.setTitle(nil, for: .normal)
            button.isEnabled = true
        }
        if (firstMove == playerMove.nought){
            firstMove = playerMove.cross
            turnLabel.text = CROSS
        }
        else if (firstMove == playerMove.cross){
            firstMove = playerMove.nought
            turnLabel.text = NOUGHT
        }
        currentMove = firstMove
    }
    
    func fullBoard() -> Bool {
        for button in board{
            if button.title(for: .normal) == nil{
                return false
            }
        }
        return true
    }
    
    func addToBoard (_ sender: UIButton){
        if (sender.title(for: .normal) == nil){
            if (currentMove == playerMove.nought){
                sender.setTitle(NOUGHT, for: .normal)
                currentMove = playerMove.cross
                turnLabel.text = CROSS
            }
            else if (currentMove == playerMove.cross){
                sender.setTitle(CROSS, for: .normal)
                currentMove = playerMove.nought
                turnLabel.text = NOUGHT
            }
            sender.isEnabled = false
        }
    }
}
