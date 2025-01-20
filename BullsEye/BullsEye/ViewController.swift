//
//  ViewController.swift
//  BullsEye
//
//  Created by Marco Gough on 1/19/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var slider: UISlider!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var roundLabel : UILabel!

    var currentValue: Int = 0
    var targetValue: Int = 0
    var score: Int = 0
    var round: Int = 1
    
    func updateLabels() {
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
    func startNewRound() {
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    func resetGame() {
        startNewRound()
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut
        )
        view.layer.add(transition, forKey: nil)
        
        score = 0
        round = 1
        updateLabels()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImage = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImage, for: .normal)
        
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(
            top: 0,
            left: 14,
            bottom: 0,
            right: 14
        )
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizeable = trackLeftImage.resizableImage(withCapInsets: insets)
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizeable, for: .normal)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
        startNewRound()
        updateLabels()
    }

    @IBAction func showAlert() {
        let title: String
        let difference: Int = abs(targetValue - currentValue)
        var points: Int = 100 - difference
        
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "Almost!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Good!"
        } else {
            title = "Not even close..."
        }
        
        score += points
        round += 1

        let alert = UIAlertController(
            title: title,
            message: "You scored \(points) points",
            preferredStyle: .alert)
        
        let action = UIAlertAction(
            title: "OK",
            style: .default,
            handler: {_ in
                self.startNewRound()
                self.updateLabels()
            })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = lroundf(slider.value)
    }
    
    @IBAction func resetButtonPressed(_ button: UIButton) {
        resetGame()
    }
}

