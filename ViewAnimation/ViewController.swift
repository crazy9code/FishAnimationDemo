//
//  ViewController.swift
//  ViewAnimation
//
//  Created by Kuliza-336 on 01/03/17.
//  Copyright © 2017 Kuliza-336. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let container = UIView()
    let redView = UIView()
    let blueview = UIView()
    let bluefish = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sea")
        self.view.insertSubview(backgroundImage, at: 0)
        
        for _ in 0...5 {
            
            let bluefish = UIImageView()
            bluefish.image = UIImage(named: "fish")
            bluefish.frame = CGRect(x: 100, y: 300, width: 40, height: 40)
            self.view.addSubview(bluefish)
            
            let redfish = UIImageView() 
            redfish.image = UIImage(named: "redFish")
            redfish.frame = CGRect(x: 150, y: 600, width: 40, height: 40)
            self.view.addSubview(redfish)
            
            let randomYOffset = CGFloat( arc4random_uniform(150))
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 16,y: 339 + randomYOffset))
            path.addCurve(to: CGPoint(x: 301, y: 340 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 373 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 110 + randomYOffset))
        
            let anim = CAKeyframeAnimation(keyPath: "position")
            anim.path = path.cgPath
            anim.rotationMode = kCAAnimationRotateAuto
            anim.repeatCount = Float.infinity
            anim.duration = Double(arc4random_uniform(40)+30) / 10
            anim.timeOffset = Double(arc4random_uniform(290))
       
            bluefish.layer.add(anim, forKey: "animate position along path")
            

            let path1 = UIBezierPath()
            path1.move(to: CGPoint(x: 16,y: 639 + randomYOffset))
            path1.addCurve(to: CGPoint(x: 301, y: 439 + randomYOffset), controlPoint1: CGPoint(x: 136, y: 573 + randomYOffset), controlPoint2: CGPoint(x: 178, y: 310 + randomYOffset))
            
            let anim1 = CAKeyframeAnimation(keyPath: "position")
            
            // set the animations path to our bezier curve
            anim1.path = path.cgPath
            anim1.rotationMode = kCAAnimationRotateAuto
            anim1.repeatCount = Float.infinity
            anim1.duration = Double(arc4random_uniform(40)+30) / 10
            anim1.timeOffset = Double(arc4random_uniform(290))
            
           redfish.layer.add(anim1, forKey: "animate position along path")
       }
    }
    
    @IBAction func clickToAnimate(_ sender: Any) {
        
        
        bluefish.image = UIImage(named: "fish")
        bluefish.frame = CGRect(x: 150, y: 50, width: 70, height: 70)
        self.view.addSubview(bluefish)
        
        
        var views = (frontView: self.redView, backView: self.blueview)
        
        if((self.redView.superview) != nil){
            views = (frontView: self.redView, backView: self.blueview)
        }
        else {
            views = (frontView: self.blueview, backView: self.redView)
        }

        let transitionOptions = UIViewAnimationOptions.transitionFlipFromBottom
        
        UIView.transition(with: self.container, duration: 1.0, options: transitionOptions, animations: {
            views.frontView.removeFromSuperview()
            self.container.addSubview(views.backView)
        }, completion: {
            finished in
        })
        
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animate(withDuration: 1.0, animations: {
            self.bluefish.transform = CGAffineTransform(rotationAngle: fullRotation)
        })
        
        let duration = 2.0
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.calculationModePaced
        
        UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
                self.bluefish.transform = CGAffineTransform(rotationAngle: 1/3 * fullRotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
                self.bluefish.transform = CGAffineTransform(rotationAngle: 2/3 * fullRotation)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0, animations: {
                self.bluefish.transform = CGAffineTransform(rotationAngle: 3/3 * fullRotation)
            })
            
            }, completion: nil)
        }
    
}

