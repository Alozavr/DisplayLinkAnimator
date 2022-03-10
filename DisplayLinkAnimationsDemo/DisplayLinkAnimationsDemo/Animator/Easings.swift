//
//  Easings.swift
//  DisplayLinkAnimationsDemo
//

import UIKit

struct Easings {
    
    static let easeInQuad = { (t: CGFloat) -> CGFloat in return t*t; }
    static let easeOutQuad = { (t: CGFloat) -> CGFloat in return 1 - Easings.easeInQuad(1-t); }
    static let easeOutElastic = { (t: CGFloat) -> CGFloat in
        
        guard t != 0, t != 1 else {
            return t
        }
        
        let c4 = (2 * Double.pi) / 3
        
        return pow(2, -10 * t) * sin((t * 10 - 0.75) * c4) + 1
    }
    static let easeInOutCubic = { (t: CGFloat) -> CGFloat in
        return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2
    }
    
    // TODO: Add more predefined functions
}
