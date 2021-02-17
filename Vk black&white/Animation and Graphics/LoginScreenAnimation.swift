//
//  LoginScreenAnimation.swift
//  Vk black&white
//
//  Created by Macbook on 29.12.2020.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animateTime: TimeInterval = 1.0
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        animateTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        destination.view.transform = CGAffineTransform(translationX: 0, y: -source.view.bounds.height)
        
        UIView.animate(withDuration: animateTime) {
            destination.view.transform = .identity
        } completion: { complited in
            transitionContext.completeTransition(complited)
        }
    }
}

