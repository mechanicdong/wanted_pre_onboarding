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

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCellLayout()
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCellLayout()
    }
    
    func configureCellLayout() {
        self.backgroundColor = .white
        
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
    
    func fetchData(model: MainWeatherResponseModel, regionName: String, forURLString: String?) {
//        customView.fetchDataForCell(
//            regionName: regionName,
//            weatherImg: model.weather[0].icon,
//            currentTemp: model.main.temp,
//            currentHumidity: model.main.humidity
//        )
        
        customView.fetchDataForContentVC(regionName: regionName, targetData: model, isTransition: false, forURLString: forURLString)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.customView = WeatherContentView()
    }
}
