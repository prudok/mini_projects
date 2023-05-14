import UIKit

class ViewController: UIViewController {
    var touches = 0 {
        didSet {
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    let emojiCollection = ["🐭", "🐵", "🐭", "🐵"]
    
    func flipButton(emoji: String, button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.blue
        } else {
            button.titleLabel?.font = .systemFont(ofSize: 120.0)
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = UIColor.white
        }
    }

    @IBOutlet var buttonCollection: [UIButton]!

    @IBOutlet weak var touchLabel: UILabel!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            flipButton(emoji: emojiCollection[buttonIndex], button: sender)
        }
    }
}

