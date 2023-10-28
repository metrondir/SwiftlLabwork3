import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewTopCards: [UIView]!
    @IBOutlet var viewBottomCards: [UIView]!
    @IBOutlet var buttons: [UIButton]!
    
    var initialColor: UIColor = UIColor.gray
    var selectedIndex: Int?
    var count: Int = 0
    var winCards: [Bool] = [false,false,false,false,false,false]
    
    var isFlipping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func buttonFlipCards(_ sender: Any) {
        guard let button = sender as? UIButton,
              let index = buttons.firstIndex(of: button) else {
            return
        }
        
        let topCards = viewTopCards[index]
        let bottomCards = viewBottomCards[index]
        
        if isFlipping || winCards[index] || topCards.isHidden {
            return
        }
        if !topCards.isHidden {
            UIView.transition(from: bottomCards, to: topCards, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        } else {
            UIView.transition(from: topCards, to: bottomCards, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        
        topCards.isHidden.toggle()
        bottomCards.isHidden.toggle()
        
      
        if count == 0 {
            initialColor = bottomCards.backgroundColor!
            count += 1
            selectedIndex = index
        } else {
            if selectedIndex == index {
                count = 0
                return
            } else {
                if initialColor == bottomCards.backgroundColor {
                    winCards[selectedIndex!] = true
                    winCards[index] = true
                    count = 0
                } else {
                    isFlipping = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        UIView.transition(from: bottomCards, to: topCards, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: { _ in
                            self.isFlipping = false
                        })
                        let c = self.viewTopCards[self.selectedIndex!]
                        let d = self.viewBottomCards[self.selectedIndex!]
                        UIView.transition(from: d, to: c, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: { _ in
                            self.isFlipping = false
                        })
                        self.count = 0
                    }
                }
            }
        }
    }
}

