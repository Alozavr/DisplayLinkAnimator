//
//  DisplayLinkAnimator.swift
//  DisplayLinkAnimationsDemo
//

import UIKit

final class DisplayLinkAnimator {
    
    private var isAnimating: Bool = false
    private var previousTimestamp: TimeInterval = 0
    private var elapsedTime = 0.0
    
    private var completion: ((DisplayLinkAnimator) -> Void)?
    private lazy var displayLink: CADisplayLink = {
        CADisplayLink(target: self, selector: #selector(displayRefreshed))
    }()
    
    private var animations: [DisplayLinkAnimation]
    
    init(
        animations: [DisplayLinkAnimation],
        _ completion: ((DisplayLinkAnimator) -> Void)? = nil
    ) {
        
        self.animations = animations
        self.completion = completion
        
        self.displayLink.isPaused = true
        self.displayLink.add(to: RunLoop.main, forMode: .default)
    }
    
    deinit {
        self.completion = nil
        self.displayLink.invalidate()
    }
    
    func startAnimations() {
        isAnimating = true
        previousTimestamp = 0
        elapsedTime = 0
        displayLink.isPaused = false
    }
        
    @objc private func displayRefreshed() {
        
        guard isAnimating else {
            return
        }
        
        if previousTimestamp == 0 {
            previousTimestamp = displayLink.timestamp
            return
        }
        
        let dt = displayLink.timestamp - previousTimestamp
        elapsedTime += dt
        previousTimestamp = displayLink.timestamp
        
        self.animations = self.animations.filter({
            if elapsedTime >= $0.delay + $0.duration {
                $0.animation(Double($0.toValue))
                return false
            }
            return true
        })
        
        guard !self.animations.isEmpty else {
            self.stopAnimation()
            return
        }
        
        self.animations
            .filter({ elapsedTime >= $0.delay })
            .forEach({ description in
            
                let animationProgress = (elapsedTime - description.delay) / description.duration
                let diff = description.toValue - description.fromValue
                let currentValue = description.fromValue + diff * description.easingFunction(animationProgress)
                
                description.animation(currentValue)
        })
    }
    
    private func stopAnimation() {
                
        self.displayLink.isPaused = true
        self.isAnimating = false
        self.previousTimestamp = 0
        self.elapsedTime = 0
        
        self.completion?(self)
        self.completion = nil
    }
}
