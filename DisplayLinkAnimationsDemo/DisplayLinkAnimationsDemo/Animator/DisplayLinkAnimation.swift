//
//  DisplayLinkAnimation.swift
//  DisplayLinkAnimationsDemo
//

import UIKit

final class DisplayLinkAnimation {
    let delay: TimeInterval
    let duration: TimeInterval
    let fromValue: CGFloat
    let toValue: CGFloat
    let animation: (CGFloat) -> Void
    let easingFunction: (CGFloat) -> CGFloat
    
    init(delay: TimeInterval = 0,
         duration: TimeInterval,
         fromValue: CGFloat,
         toValue: CGFloat,
         animation: @escaping (CGFloat) -> Void,
         easingFunction: @escaping (CGFloat) -> CGFloat = Easings.easeInOutCubic
    ) {
        self.delay = delay
        self.duration = duration
        self.fromValue = fromValue
        self.toValue = toValue
        self.animation = animation
        self.easingFunction = easingFunction
    }
}
