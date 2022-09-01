//
//  DetailViewController.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    var statusBarShouldBeHidden: Bool = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return statusBarShouldBeHidden
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        setAttribute()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateStatusBar(hidden: true, completion: nil)
    }
    
    func updateStatusBar(hidden: Bool, completion: ((Bool) -> Void)?) {
        statusBarShouldBeHidden = hidden
        UIView.animate(withDuration: 0.5) {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    public var weatherCollectionView: UICollectionView = {
        let layout = CardCollectionViewFlowLayout()
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: UIScreen.main.bounds.size)
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 1), height: UIScreen.main.bounds.height)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.masksToBounds = true
        cv.backgroundColor = .white
        return cv
    }()
    
    fileprivate func setAttribute() {
        view.backgroundColor = .white
//        self.weatherCollectionView.delegate = self
        self.weatherCollectionView.dataSource = self
        self.weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didDismissDetailNotification(_:)),
            name: NSNotification.Name("close"),
            object: nil
        )
    }
    
    @objc func didDismissDetailNotification(_ notification: Notification) {
        self.dismiss(animated: true)
    }
    
    func setupLayout(){
        view.addSubview(weatherCollectionView)
        weatherCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        weatherCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        weatherCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! WeatherCollectionViewCell
        cell.customView.removeFromSuperview()
        cell.customView = WeatherContentView(isContentView: true, isTransition: true)
        cell.customView.translatesAutoresizingMaskIntoConstraints = false
        cell.configureCellLayout()
        return cell
    }
    
    
}
