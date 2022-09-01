//
//  WeatherContentView.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class WeatherContentView: UIView {
    
    init(isContentView: Bool, isTransition: Bool = false) {
        super.init(frame: .zero)
        // for reusable
        if isContentView {
            self.setLayoutForContentVC(isTransition: isTransition)
        } else {
            self.setLayoutForCollectionViewCell()
        }
        self.backgroundColor = .gray
        //MARK: 스크롤뷰 델리게이트 설정
//        scrollView.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayoutForCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setLayoutForCollectionViewCell()
    }
    
    public var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        ///true일 경우 스크롤 애니메이션이 우선, false일 경우 Cell의 touchBegan 메소드가 우선적으로 불려짐
        view.delaysContentTouches = false
        return view
    }()
    
//    public var customView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    public var regionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.semibold, size: 22)
        label.textColor = .black
        label.text = "서울특별시"
        return label
    }()
    
    public var closeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor.red, for: .normal)
        button.setTitle("닫기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public var presentTempLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.semibold, size: 36)
        label.text = "17℃"
        return label
    }()
    
    public var tempImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    public var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.semibold, size: 20)
        label.text = "습도"
        return label
    }()
    
    public var testTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: Font.semibold, size: 20)
        label.text = "이것은 테스트를 위한 라벨입니다,이것은 테스트를 위한 라벨입니다,이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다\n이것은 테스트를 위한 라벨입니다"
        return label
    }()
    
    func setLayoutForCollectionViewCell() {
        self.addSubview(regionLabel)
        regionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        regionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        let tempStackView = UIStackView(arrangedSubviews: [tempImageView, presentTempLabel])
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.axis = .horizontal
        tempStackView.distribution = .fillEqually
        tempStackView.alignment = .center
        tempStackView.spacing = 60
        
        self.addSubview(tempStackView)
        tempStackView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
        tempStackView.centerXAnchor.constraint(equalTo: regionLabel.centerXAnchor).isActive = true
        tempStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
        tempStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    @objc func close() {
        NotificationCenter.default.post(name: NSNotification.Name("close"), object: nil, userInfo: nil)
    }
    
    func setLayoutForContentVC(isTransition: Bool = false) {
        self.addSubview(scrollView)
        scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        
        let tempStackView = UIStackView(arrangedSubviews: [tempImageView, presentTempLabel])
        
        if !isTransition {
            print("*****isTransition: False*****")
            scrollView.addSubview(regionLabel)
            regionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            regionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
                        
            tempStackView.translatesAutoresizingMaskIntoConstraints = false
            tempStackView.axis = .horizontal
            
            tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            
            tempStackView.distribution = .fillProportionally
            tempStackView.alignment = .center
            tempStackView.spacing = 80

            scrollView.addSubview(tempStackView)
            tempStackView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
            tempStackView.centerXAnchor.constraint(equalTo: regionLabel.centerXAnchor).isActive = true
            tempStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50).isActive = true
            tempStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            print("*****isTransition: True*****")
            scrollView.addSubview(regionLabel)
            regionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            regionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
            
            tempStackView.translatesAutoresizingMaskIntoConstraints = false
            tempStackView.axis = .horizontal
            
            tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            presentTempLabel.leadingAnchor.constraint(equalTo: tempImageView.trailingAnchor, constant: 120).isActive = true
            
            tempStackView.distribution = .fillProportionally
            tempStackView.alignment = .center
            tempStackView.spacing = 60
            
            scrollView.addSubview(tempStackView)
            tempStackView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
            tempStackView.centerXAnchor.constraint(equalTo: regionLabel.centerXAnchor).isActive = true
            tempStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempStackView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -60).isActive = true
        }
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        scrollView.addSubview(closeButton)
        closeButton.centerYAnchor.constraint(equalTo: regionLabel.centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        scrollView.addSubview(testTextLabel)
        testTextLabel.topAnchor.constraint(equalTo: tempStackView.bottomAnchor, constant: 20).isActive = true
        testTextLabel.centerXAnchor.constraint(equalTo: tempStackView.centerXAnchor).isActive = true
        testTextLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8).isActive = true
        testTextLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        testTextLabel.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }
    
    func fetchDataForContentVC(isTransition: Bool = false) {
        let size = CGSize(width: 1000, height: 10000)
        let estimateSize = testTextLabel.sizeThatFits(size)
        
        if !isTransition {
            
        } else {
            
        }
    }
    
    func fetchDataForCell() {
        
    }
}
