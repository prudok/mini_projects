import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
    
    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    var emojiCollection = ["🐭", "🐵", "🐹", "🦊", "🐨", "🐻", "🦄", "🐸", "🐤", "🐻‍❄️"]
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func isGameOver() -> Bool {
        for card in game.cards {
            if card.isMatched == false {
                return false;
            }
        }
        return true;
    }
    
    func gameOver() {
        touchLabel.text = "You Won! Total: \(touches)"
    }
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.titleLabel?.font = .systemFont(ofSize: 120.0)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.green : UIColor.blue
            }
        }
        
    }
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var touchLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
        if isGameOver() {
            gameOver()
            showRestartButton(button: restartButton)
        }
    }
    
    func showRestartButton(button sender: UIButton) {
        sender.isEnabled = true
        sender.isHidden = false
    }
    
    func hideRestartButton(button sender: UIButton) {
        sender.isEnabled = false
        sender.isHidden = true
    }
    
    @IBOutlet weak var restartButton: UIButton!
    
    @IBAction func restartButton(_ sender: UIButton) {
        sender.isEnabled = false
        sender.isHidden = true
        game = ConcentrationGame(numberOfPairsOfCards: (buttonCollection.count + 1) / 2)
        emojiCollection = ["🐭", "🐵", "🐹", "🦊", "🐨", "🐻", "🦄", "🐸", "🐤", "🐻‍❄️"]
        touches = 0
    }
    
}

