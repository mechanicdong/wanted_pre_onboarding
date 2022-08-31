//
//  MainViewController.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    fileprivate var colors: [UIColor] = [UIColor.black, UIColor.red, UIColor.green, UIColor.yellow, UIColor.systemBlue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAttribute()
        setupLayout()
    }
    
    private var weatherCollectionView: UICollectionView = {
        let layout = CardCollectionViewFlowLayout()
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: UIScreen.main.bounds.size)
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.85), height: 500)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        return cv
    }()
    
    fileprivate func setAttribute() {
        view.backgroundColor = .white
        self.weatherCollectionView.delegate = self
        self.weatherCollectionView.dataSource = self
        self.weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        currentPage = 0
    }
    
    func setupLayout(){
        view.addSubview(weatherCollectionView)
        weatherCollectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        weatherCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        weatherCollectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        let spacingLayout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        //양 옆 셀 보이는 부분
        spacingLayout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 20)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! WeatherCollectionViewCell
        
        cell.customView.backgroundColor = colors[indexPath.row]
        return cell
    }
    
}
