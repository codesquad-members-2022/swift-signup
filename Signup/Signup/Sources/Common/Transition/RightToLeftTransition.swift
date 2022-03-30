//
//  RightToLeftTransition.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import UIKit

class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum PresentType {
        case present, dismiss
    }
    
    private let duration: Double = 0.3
    private let presentType: PresentType
    
    init(_ presentType: PresentType) {
        self.presentType = presentType
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let targetView = transitionContext.view(forKey: self.presentType == .present ? .to : .from) else {
            return
        }
        
        let size = targetView.frame.size
        let halfWidth = size.width / 2.0
        let halfHeight = size.height / 2.0
        
        containerView.addSubview(targetView)
        
        let fromCenter = self.presentType == .present ? CGPoint(x: size.width + halfWidth, y: halfHeight) : CGPoint(x: halfWidth, y: halfHeight)
        let toCenter = self.presentType == .present ? CGPoint(x: halfWidth, y: halfHeight) : CGPoint(x: size.width + halfWidth, y: halfHeight)
        
        targetView.center = fromCenter
        UIView.animate(withDuration: duration, animations: {
            targetView.center = toCenter
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
