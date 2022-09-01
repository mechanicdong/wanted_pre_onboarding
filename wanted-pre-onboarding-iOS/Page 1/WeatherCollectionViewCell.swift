//
//  WeatherCollectionViewCell.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    func resetTransform() {
        transform = .identity
    }
    
    public lazy var customView: WeatherContentView = {
        var view = WeatherContentView(isContentView: false)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .center
        return view
    }()
    
//    public var regionLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: Font.semibold, size: 22)
//        label.textColor = .black
//        label.text = "서울특별시"
//        return label
//    }()
//
//    public var presentTempLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: Font.semibold, size: 36)
//        label.text = "17℃"
//        return label
//    }()
//
//    public var tempImageView: UIImageView = {
//        let view = UIImageView()
//        view.backgroundColor = .green
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 5
//        return view
//    }()
//
//    public var humidityLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: Font.semibold, size: 20)
//        label.text = "습도"
//        return label
//    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellLayout()
        contentView.backgroundColor = .gray
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCellLayout()
    }
    
    func configureCellLayout() {
        self.backgroundColor = .gray
        
        contentView.addSubview(customView)
        customView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        customView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        customView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1).isActive = true
        customView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        bounceAnimate(isTouched: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        bounceAnimate(isTouched: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        bounceAnimate(isTouched: false)
    }
    
    private func bounceAnimate(isTouched: Bool) {
        if isTouched {
            WeatherCollectionViewCell.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 1,
                           options: [.allowUserInteraction], animations: {
                            self.transform = .init(scaleX: 0.96, y: 0.96)
                            self.layoutIfNeeded()
                           }, completion: nil)
        } else {
            WeatherCollectionViewCell.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .allowUserInteraction, animations: {
                            self.transform = .identity
                           }, completion: nil)
        }
    }
}
