//
//  ViewController.swift
//  prim10
//
//  Created by HOME on 6/15/18.
//  Copyright © 2018 HOME. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var switchMode: UISegmentedControl!
    
    private var octagram: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawOctagram();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func rundomPoint() -> CGPoint {
        let randomX = Int(70 + arc4random_uniform(UInt32(UIScreen.main.bounds.width - 70)))
        let randomY = Int(70 + arc4random_uniform(UInt32(UIScreen.main.bounds.height - 70)))
        return CGPoint(x: randomX, y: randomY)
    }
    
    private func move() {
        
        let moveAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.path))
        moveAnimation.fromValue = octagram.path
        octagram.path = octagramPath(center: rundomPoint(),
                                 radius: 50).cgPath
        moveAnimation.toValue = octagram.path
        moveAnimation.duration = 4
        
        octagram.add(moveAnimation, forKey: nil)
    }
    
    private func scale() {
        
        let scaleAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.transform))
        scaleAnimation.valueFunction = CAValueFunction(name: kCAValueFunctionScale)
        scaleAnimation.fromValue = [1,1,0]
        scaleAnimation.toValue = [2,2,0]
        scaleAnimation.duration = 4
        
        octagram.add(scaleAnimation, forKey: nil)
    }
    
    @IBAction func onValueChanged(_ sender: Any) {
        octagram.removeAllAnimations()
        octagram.path = octagramPath(center: CGPoint(x: 100, y: 200),
                                     radius: 50).cgPath
        switch switchMode.selectedSegmentIndex {
        case 1:
            move();
            break;
        case 2:
            scale();
            break;
        default:
            break;
        }
    }
    private func octagramPath(center: CGPoint,
                              radius: CGFloat) -> UIBezierPath {
        let brush = UIBezierPath()
        var points: [CGPoint] = []
        let angle = CGFloat(Double.pi / 2)
        
        for i in 0...3 {
            points.append(CGPoint(x : center.x + radius*cos(angle*CGFloat(i)),
                                  y : center.y + radius*sin(angle*CGFloat(i))))
        }
        
        
        brush.move(to: points[0]);
        
        brush.addLine(to: points[1])
        brush.addLine(to: points[2])
        brush.addLine(to: points[3])
        brush.close()
        return brush
    }
    
    private func drawOctagram() {
        octagram = CAShapeLayer()
        let path = octagramPath(center: CGPoint(x: 100, y: 200),
                                radius: 50)
        octagram.path = path.cgPath
        octagram.frame = path.bounds
        
        view.layer.addSublayer(octagram)
        
        let gradient = CAGradientLayer()
        gradient.frame = self.view.bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        gradient.mask = octagram
        view.layer.addSublayer(gradient)
    }

}

