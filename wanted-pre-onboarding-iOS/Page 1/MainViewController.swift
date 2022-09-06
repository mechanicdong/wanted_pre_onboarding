//
//  MainViewController.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var currentWeatherList = [MainWeatherResponseModel]()
    var subWeatherList = [SubWeatherResponseModel]()
    
    let viewModel = MainViewModel.shared
    
    fileprivate var currentPage: Int = 0
    fileprivate var pageSize: CGSize {
        let layout = self.weatherCollectionView.collectionViewLayout as! CardCollectionViewFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    var weatherTransition = AppContentTransitionController() // Transtion Animator 생성
    
    let region = RegionName().regionGeoArray

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
        
        for i in 0..<region.count {
            for (key, _) in region[i] {
                if key == "Jeju City" {
                    viewModel.getCurrentWeather(location: "Jeju") { response in
                        self.currentWeatherList.append(response)
                        DispatchQueue.main.async {
                            self.weatherCollectionView.reloadData()
                        }
                    }
                } else {
                    viewModel.getCurrentWeather(location: key) { response in
                        self.currentWeatherList.append(response)
                        DispatchQueue.main.async {
                            self.weatherCollectionView.reloadData()
                        }
                    }
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
        
        for (key, value) in region[indexPath.row] {
            if key == crtWeather.name {
                if key == "Jeju City" {
                    cell.fetchData(model: crtWeather, regionName: value, forURLString: "Jeju")
                } else {
                    cell.fetchData(model: crtWeather, regionName: value, forURLString: key)
                }
            }
            break
        }
        return cell
    }

}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        weatherTransition.indexPath = indexPath
        weatherTransition.superViewcontroller = detailVC
        weatherTransition.model = self.currentWeatherList[indexPath.row]
        let crtWeather = self.currentWeatherList[indexPath.row]
        for i in 0..<region.count {
            for (key, value) in region[i] {
                if crtWeather.name == key {
                    weatherTransition.regionName = value
                    //TODO: Data fetch
                    detailVC.fetchData(model: self.currentWeatherList[indexPath.row], regionName: value)
                }
            }
        }
        
        detailVC.modalPresentationStyle = .custom
        detailVC.transitioningDelegate = weatherTransition
        //상태바까지 가리게 설정할 수 있음
        detailVC.modalPresentationCapturesStatusBarAppearance = true
     
        
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
        print("*********** 프리패치 실행 ***********")
        print("프리패치 인덱스 패스: \(indexPaths)") //currentPage = 0 -> 2(1,2) , currentPage = 1 -> 3(1,2,3), 2 -> 4(2,3,4)
        
        indexPaths.forEach {
            print("인덱스 패스 로우값: \($0.row)")
            if ($0.row == self.currentPage + 1) && (self.currentPage < 20) {
                for (key, _) in region[self.currentPage+2] {
                    if key == "Jeju City" {
                        let queryItem = "Jeju"
                        viewModel.getCurrentWeather(location: queryItem) { response in
                            self.currentWeatherList.append(response)
                            DispatchQueue.main.async {
                                self.weatherCollectionView.reloadData()
                            }
                        }
                    } else {
                        viewModel.getCurrentWeather(location: key) { response in
                            self.currentWeatherList.append(response)
                            DispatchQueue.main.async {
                                self.weatherCollectionView.reloadData()
                            }
                        }
                    }

                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.collectionView(weatherCollectionView, prefetchItemsAt: [indexPath])
    }
}
