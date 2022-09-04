//
//  MainViewController.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var currentWeatherList = [CurrentWeatherResponseModel]()
    
    let viewModel = MainViewModel.shared
    
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    var weatherTransition = AppContentTransitionController() // Transtion Animator 생성
    
    let regionNameArr = ["공주", "광주", "구미", "군산", "대구", "대전", "목포", "부산", "서산", "서울", "속초", "수원", "순천", "울산", "익산", "전주", "제주", "천안", "청주", "춘천"]

    var regionGeo = RegionGeo().regionGeoArray
        
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttribute()
        setupLayout()
    }
    
    public var weatherCollectionView: UICollectionView = {
        let layout = CardCollectionViewFlowLayout()
        let pointEstimator = RelativeLayoutUtilityClass(referenceFrameSize: UIScreen.main.bounds.size)
        layout.itemSize = CGSize(width: pointEstimator.relativeWidth(multiplier: 0.85), height: 500)
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.layer.masksToBounds = true
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    fileprivate func setAttribute() {
        view.backgroundColor = .white
        self.weatherCollectionView.delegate = self
        self.weatherCollectionView.dataSource = self
        self.weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        currentPage = 0
        
        ///Network
        weatherCollectionView.prefetchDataSource = self
        for i in 0..<4 {
            viewModel.getCurrentWeather(location: regionGeo[i]) { [weak self] crtWeather in
                print("가져온 모델: \(crtWeather)")
                self?.currentWeatherList.append(crtWeather)
                DispatchQueue.main.async {
                    self?.weatherCollectionView.reloadData()
                }
            }
        }
        
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
    
//    // MARK: UIScrollViewDelegate
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
//        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//        print("현재페이지: \(currentPage)")
//    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentWeatherList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }

        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 12
        
        let crtWeather = self.currentWeatherList[indexPath.row]
        print("지역 이름: \(self.regionNameArr[indexPath.row])")
        print("셀에 들어갈 정보 모델 indexPathrow \(indexPath.row) : \(crtWeather)")
        cell.fetchData(model: crtWeather, regionName: self.regionNameArr[indexPath.row])
                
        return cell
    }

    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        weatherTransition.indexPath = indexPath
        weatherTransition.superViewcontroller = detailVC
        
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = weatherTransition
        //상태바까지 가리게 설정할 수 있음
        detailVC.modalPresentationCapturesStatusBarAppearance = true
        //TODO: Data fetch
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    // MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        print("현재페이지: \(currentPage)")
    }
    
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("프리패치 실행")
        guard currentPage != 0 else { return }
        print("현재페이지 프리페치: \(currentPage)")
        indexPaths.forEach {
            self.viewModel.getCurrentWeather(location: regionGeo[$0.row]) { response in
                self.currentWeatherList.append(response)
                DispatchQueue.main.async {
                    self.weatherCollectionView.reloadData()
                }
            }
        }
    }
}
