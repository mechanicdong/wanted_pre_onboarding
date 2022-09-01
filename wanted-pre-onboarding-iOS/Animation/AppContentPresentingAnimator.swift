//
//  AppContentPresentingAnimator.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class AppContentPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var contentViewTopAnchor: NSLayoutConstraint!
    var contentViewWidthAnchor: NSLayoutConstraint!
    var contentViewHeightAnchor: NSLayoutConstraint!
    var contentViewCenterXAnchor: NSLayoutConstraint!
    
    var targetIndexPath: IndexPath?
//    var targetData: AppContentModel?
    
    init(indexPath: IndexPath) {
        super.init()
        targetIndexPath = indexPath
//        targetData = model[indexPath.row]
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.alpha = 1.0
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? MainViewController else { fatalError() }
        guard let contentVC = transitionContext.viewController(forKey: .to) as? DetailViewController else { fatalError() }
        guard let fromView = fromVC.view else { fatalError() }
        guard let toView = contentVC.view else { fatalError() }
        
        let targetCell = fromVC.weatherCollectionView.cellForItem(at: targetIndexPath!) as! WeatherCollectionViewCell
        let startFrame = fromVC.weatherCollectionView.convert(targetCell.frame, to: fromView)
//        let startFrame = fromVC.view.convert(targetCell.frame, to: fromView)

        let contentView = WeatherContentView(isContentView: true, isTransition: true)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 20
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        toView.alpha = 0.0
        contentView.alpha = 1.0
        targetCell.alpha = 0.0
        
        containerView.addSubview(toView)
        containerView.addSubview(contentView)
        
        targetCell.resetTransform()
        
        NSLayoutConstraint.activate(makeConstraints(containerView: containerView, contentView: contentView, Originframe: startFrame))
        containerView.layoutIfNeeded()
        
        contentViewTopAnchor.constant = 0
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.4,
                       options: .beginFromCurrentState,
                       animations: { contentView.layoutIfNeeded() }) { (comp) in
            toView.alpha = 1.0
            contentView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        contentViewWidthAnchor.constant = containerView.frame.width
        contentViewHeightAnchor.constant = containerView.frame.height
        
//        contentView.customView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        contentView.customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        contentView.customView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
//        contentView.customView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5).isActive = true
//        contentView.customView.layoutIfNeeded()
        
//        contentView.testTextLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
//        contentView.testTextLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//        contentView.testTextLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
//        contentView.testTextLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        
        UIView.animate(withDuration: 0.6 * 0.6) {
            containerView.layoutIfNeeded()

        }
        
    }
    func makeConstraints(containerView: UIView, contentView: WeatherContentView, Originframe: CGRect) -> [NSLayoutConstraint] {
        
        contentViewCenterXAnchor = contentView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        contentViewTopAnchor = contentView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Originframe.minY)
        contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: Originframe.height)
        contentViewWidthAnchor = contentView.widthAnchor.constraint(equalToConstant: Originframe.width)
        
        return [contentViewCenterXAnchor, contentViewTopAnchor, contentViewHeightAnchor, contentViewWidthAnchor]
        
    }
    
}
