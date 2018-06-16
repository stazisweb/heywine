//
//  Pentagon.swift
//  9
//
//  Created by Кривогузов Владислав on 15.06.18.
//  Copyright © 2018 Кривогузов Владислав. All rights reserved.
//

import UIKit

class Pentagon: UIView {
    @IBInspectable var fillColor: UIColor = UIColor.black
    var color: UIColor = UIColor(patternImage: #imageLiteral(resourceName: "texture"))
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: rect.width/2,y: rect.height/2)
        let radius = rect.height<rect.width ? CGFloat(rect.height/2) : CGFloat(rect.width/2)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: center.x,y: center.y+radius))
        path.addLine(to: CGPoint(x: center.x+radius*cos(.pi/10),y: center.y+radius*sin(.pi/10)))
        path.addLine(to: CGPoint(x: center.x+radius*sin(.pi*1/5),y: center.y-radius*cos(.pi*1/5)))
        path.addLine(to: CGPoint(x: center.x-radius*sin(.pi*1/5),y: center.y-radius*cos(.pi*1/5)))
        path.addLine(to: CGPoint(x: center.x-radius*cos(.pi/10),y: center.y+radius*sin(.pi/10)))
        path.addLine(to: CGPoint(x: center.x,y: center.y+radius))
        
        path.fill()
        path.addClip()
        //context.draw(image, in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        color.setFill()
        context.fill(rect)
        
    }
    func switchBG(){
        if color == fillColor{
            color = UIColor(patternImage: #imageLiteral(resourceName: "texture"))
        }else{
            color = fillColor
        }
        setNeedsDisplay()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
