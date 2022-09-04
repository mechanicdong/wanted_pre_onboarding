//
//  AppContentTransitionController.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class AppContentTransitionController: NSObject, UIViewControllerTransitioningDelegate {
    ///프로퍼티 superViewController와 indexPath는 transition 과정에서의 view의 애니메이션과 데이터를 위한 indexPath
    var superViewcontroller: UIViewController?
    var indexPath: IndexPath?
    var model: MainWeatherResponseModel?
    var regionName: String?
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return AppcontentPresentaion(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AppContentPresentingAnimator(indexPath: indexPath!, model: model, region: regionName)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AppContentDismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
