//
//  SliderControl.swift
//  BLE LED Demo
//
//  Created by Johnathan Grayson on 18/12/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

import UIKit

class SliderControl: UIControl {
   
    var x : CGFloat = 0.0
    var y : CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.opaque = true
        
        self.x = CGFloat(self.frame.size.width / 2)
        self.y = CGFloat(self.frame.size.height / 2)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect){
        super.drawRect(rect)
        
        let ctx = UIGraphicsGetCurrentContext()

        var mg = CGFloat(self.frame.size.width / 2.0)
        var w : Float = Float(self.frame.size.width) - Float(mg*2.0)
        var h : Float = Float(self.frame.size.height) - Float(mg*2.0)
        
        UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1).set()
        CGContextSetLineWidth(ctx, self.frame.size.width)
        CGContextSetLineCap(ctx, kCGLineCapRound)
        
        CGContextMoveToPoint(ctx, CGFloat(self.frame.size.width / 2), CGFloat(mg))
        CGContextAddLineToPoint(ctx, CGFloat(self.frame.size.width / 2), CGFloat(self.bounds.size.height - CGFloat(mg)))
        
        CGContextDrawPath(ctx, kCGPathStroke)
        
        drawTheHandle(ctx)
    
    }
    
    func drawTheHandle(ctx : CGContextRef) {
        CGContextSaveGState(ctx)
        
        UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1).set()
        
        var ar = CGFloat(self.frame.size.width / 4) - 5
        
        CGContextSetLineWidth(ctx, self.frame.size.width / 2)
        
        if(self.y < self.frame.width / 2) {
            self.y = self.frame.width / 2
        }
        
        if(self.y > self.frame.size.height - self.frame.size.width / 2) {
            self.y = self.frame.size.height - self.frame.size.width / 2
        }
        
        CGContextAddArc(ctx, self.x, self.y, ar, 0, 360, 0)
        
        CGContextDrawPath(ctx, kCGPathStroke)
        
        CGContextRestoreGState(ctx)
    }
    
    func moveHandle(lastPoint:CGPoint) {
        
        self.y = lastPoint.y
        
        //Redraw
        self.setNeedsDisplay()
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        return true
    }
    
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        let lastPoint = touch.locationInView(self)
        
        self.moveHandle(lastPoint)
        
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        
        return true
    }
    
    func move() {
        
    }
    
    override func endTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) {
        super.endTrackingWithTouch(touch, withEvent: event)
//        
//        var animation : CAKeyframeAnimation = CAKeyframeAnimation()
//        animation.removedOnCompletion = true;
//        
//        //animation.path = thePath;
//        
//        animation.speed = 0.011;
//        //animation.delegate = self;
//        animation.repeatCount = 1000000;
//        
//        let ctx = UIGraphicsGetCurrentContext()
//        
        let duration = 1.0
        let delay = 1.0
        let options = UIViewAnimationOptions.CurveEaseInOut
        let damping = 0.5 // set damping ration
        let velocity = 1.0 // set initial velocity
        
        UIView.animateWithDuration(1.0, animations: {
            //self.blurBg.alpha = 1
            self.y = self.frame.size.height / 2
        }, completion: {
            (value: Bool) in
            //self.blurBg.hidden = true
            self.y = self.frame.size.height / 2
            self.setNeedsDisplay()
        })
        
        // Add the animation to the layer
        //[b addAnimation:animation forKey:"move"];
    }
    
}
