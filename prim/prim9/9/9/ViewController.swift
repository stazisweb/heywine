//
//  ViewController.swift
//  9
//
//  Created by Кривогузов Владислав on 15.06.18.
//  Copyright © 2018 Кривогузов Владислав. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pentagon: Pentagon!
    @IBAction func switchBG(_ sender: Any) {
        pentagon.switchBG()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBOutlet weak var animationControl: UISegmentedControl!
    @IBAction func animationSwitch(_ sender: Any) {
        //pentagon.layer.removeAllAnimations() !!!!!! останавливает анимации но вращение и прозрачность перестают работать
        switch animationControl.selectedSegmentIndex{
            case 1:
        UIView.animate(withDuration: 3, delay: 0.0, options: [.repeat, .curveLinear,.autoreverse], animations: {
            self.pentagon.center.y+=100
        })
        case 2:
        UIView.animate(withDuration: 3, delay: 0.0, options: [.repeat, .curveLinear, .autoreverse], animations: {
            self.pentagon.transform = CGAffineTransform(rotationAngle: .pi)
        })
        case 3:
        UIView.animate(withDuration: 3,  delay: 0.0, options: [.repeat, .curveLinear, .autoreverse], animations: {
            
            self.pentagon.alpha = 0.5
        })
        default: break
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

