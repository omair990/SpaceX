//
//  BottomSheetTransitioning.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// A custom transitioning delegate that handles the presentation and dismissal of a bottom sheet.
class BottomSheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    /// Returns the presentation controller responsible for managing the presentation of the view controller as a bottom sheet.
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    /// Returns the animator object used when presenting the view controller.
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetAnimator(isPresentation: true)
    }
    
    /// Returns the animator object used when dismissing the view controller.
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetAnimator(isPresentation: false)
    }
}

/// A custom animator object responsible for animating the presentation and dismissal of a bottom sheet.
class BottomSheetAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let isPresentation: Bool
    
    /// Initializes the animator with a flag indicating whether it's for presentation or dismissal.
    init(isPresentation: Bool) {
        self.isPresentation = isPresentation
    }
    
    /// Returns the duration of the transition animation.
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3 // Duration of the transition animation
    }
    
    /// Performs the transition animation.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key) else { return }
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.height
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        
        UIView.animate(withDuration: animationDuration, animations: {
            controller.view.frame = finalFrame
        }) { finished in
            transitionContext.completeTransition(finished)
        }
    }
}
