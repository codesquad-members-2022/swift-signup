//
//  RightToLeftTransition.swift
//  Signup
//
//  Created by seongha shin on 2022/03/29.
//

import Foundation
import UIKit

class RightToLeftTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration: Double
    
    init(duration: Double) {
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        let viewSize = toView.frame.size
        containerView.addSubview(toView)
        toView.frame =  CGRect(x: viewSize.width, y: 0, width: viewSize.width * 2, height: viewSize.height)
        
        UIView.animate(withDuration: duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
