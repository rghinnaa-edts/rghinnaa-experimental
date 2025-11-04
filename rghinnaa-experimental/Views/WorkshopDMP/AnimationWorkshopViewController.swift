//
//  AnimationWorkshopViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 29/10/25.
//

import UIKit

class AnimationWorkshopViewController: UIViewController {
    
    @IBOutlet var buttonBasic: UIButton!
    @IBOutlet var btnSpring: UIButton!
    @IBOutlet var btnKeyframe: UIButton!
    @IBOutlet var btnCA: UIButton!
    
    
    private var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func animateBasicFrame() {
        buttonBasic.translatesAutoresizingMaskIntoConstraints = true
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            
            var frame = self.buttonBasic.frame
            frame.size.width += 30
            frame.size.height += 30
            self.buttonBasic.frame = frame
            
        }) { _ in
            
            UIView.animate(withDuration: 1.0, animations: {
                var frame = self.buttonBasic.frame
                frame.size.width -= 30
                frame.size.height -= 30
                self.buttonBasic.frame = frame
            })
            
        }
    }
    
    private func animateBasicBounds() {
        buttonBasic.translatesAutoresizingMaskIntoConstraints = false
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            
            var bounds = self.buttonBasic.bounds
            bounds.origin.x += 30
            bounds.origin.y += 30
            self.buttonBasic.bounds = bounds
            
        }) { _ in
            
            UIView.animate(withDuration: 1.0, animations: {
                var bounds = self.buttonBasic.bounds
                bounds.origin.x -= 30
                bounds.origin.y -= 30
                self.buttonBasic.bounds = bounds
            })
            
        }
    }
    
    private func animateBasicCenter() {
        UIView.animate(withDuration: 1.0, animations: {
            self.buttonBasic.center = CGPoint(
                x: self.buttonBasic.center.x + 10,
                y: self.buttonBasic.center.y + 10
            )
        }) { _ in
            UIView.animate(withDuration: 1.0) {
                self.buttonBasic.center = CGPoint(
                    x: self.buttonBasic.center.x - 10,
                    y: self.buttonBasic.center.y - 10
                )
            }
        }
    }
    
    private func animateBasicAlpha() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            
            self.buttonBasic.alpha = 0.3
            
        }) { _ in
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                
                self.buttonBasic.alpha = 1.0
                
            })
            
        }
    }
    
    private func animateBasicTransform() {
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            
            self.buttonBasic.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            
        }) { _ in
            
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
                
                self.buttonBasic.transform = .identity
                
            })
            
        }
    }
    
    private func animateBasicColor() {
        UIView.transition(with: buttonBasic, duration: 1.0, options: .transitionCurlUp, animations: {
            
            self.buttonBasic.tintColor = .systemRed
            
        }) { _ in
            
            UIView.transition(with: self.buttonBasic, duration: 1.0, options: .transitionCrossDissolve, animations: {
                
                self.buttonBasic.tintColor = .systemBlue
                
            })
            
        }
    }
    
    private func animateSpring() {
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseInOut, .repeat, .autoreverse],
                       animations: {
            
            self.btnSpring.transform = CGAffineTransform(translationX: 20, y: 0)
            
        })
    }
    
    private func animateKeyframe() {
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.btnKeyframe.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                
                UIView.transition(with: self.btnKeyframe, duration: 0.5, options: [.repeat, .autoreverse, .transitionCurlUp], animations: {
                    
                    self.btnKeyframe.tintColor = .systemRed
                    
                })
                
            })
            
        })
    }
    
    private func animationCA() {
        let animation = CABasicAnimation(keyPath: "opacity")

        animation.fromValue = 1.0
        animation.toValue = 0.0

        animation.duration = 2.0

        animation.repeatCount = 3
        animation.autoreverses = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false

        btnCA.layer.add(animation, forKey: "fadeOut")
    }
    
    private func animateProperty() {
        animator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.5) {
            self.btnCA.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.btnCA.alpha = 0.5
        }
        
        animator?.startAnimation()
    }
    
    private func stopAnimation() {
        animator?.stopAnimation(true)
        
        UIView.animate(withDuration: 0.3) {
            self.btnCA.transform = .identity
            self.btnCA.alpha = 1.0
        }
    }
    
    @IBAction func actionBasic(_ sender: Any) {
        animateBasicColor()
        stopAnimation()
    }
    
    @IBAction func actionSpring(_ sender: Any) {
        animateSpring()
    }
    
    @IBAction func actionKeyframe(_ sender: Any) {
        animateKeyframe()
    }
    
    @IBAction func actionCA(_ sender: Any) {
        animateProperty()
    }
}
