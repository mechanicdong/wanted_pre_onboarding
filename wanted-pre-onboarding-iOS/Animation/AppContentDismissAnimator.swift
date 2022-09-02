//
//  AppContentDismissAnimator.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/01.
//

import Foundation
import UIKit

class AppContentDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 사라지는 뷰
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        UIView.animate(withDuration: 0.5) {
            fromView.alpha = 0.0
        } completion: { completed in
            print("애니메이션 정상 종료됨: \(completed)")
            transitionContext.completeTransition(completed)
        }

    }
    
    
}
