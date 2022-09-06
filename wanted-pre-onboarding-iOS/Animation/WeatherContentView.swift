//
//  WeatherContentView.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class WeatherContentView: UIView {
    
    let NUMBER_OF_CELL = 20
    
    let viewModel = MainViewModel()
    var subData: SubWeatherResponseModel?
    
    
    init(isContentView: Bool, isTransition: Bool = false) {
        super.init(frame: .zero)
        // for reusable
        if isContentView {
            self.setLayoutForContentVC(isTransition: isTransition)
        } else {
            self.setLayoutForCollectionViewCell()
        }
        self.backgroundColor = .gray.withAlphaComponent(0.2)
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
        label.font = UIFont(name: Font.semibold, size: 34)
        label.text = "℃"
        return label
    }()
    
    public var tempImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
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

    public lazy var subCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        let cv = UICollectionView(frame: .init(x: 0, y: 0, width: 100, height: 100), collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(WeatherCollectionViewSubCell.self, forCellWithReuseIdentifier: "WeatherCollectionViewSubCell")
        return cv
    }()
    
    func setLayoutForCollectionViewCell() {
        self.addSubview(regionLabel)
        regionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        regionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
        self.addSubview(tempImageView)
        tempImageView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
        tempImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -25).isActive = true
        tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        let tempHumidityStackView = UIStackView(arrangedSubviews: [presentTempLabel, humidityLabel])
        tempHumidityStackView.translatesAutoresizingMaskIntoConstraints = false
        tempHumidityStackView.axis = .vertical
        tempHumidityStackView.alignment = .center
        tempHumidityStackView.spacing = 10
        
        self.addSubview(tempHumidityStackView)
        tempHumidityStackView.topAnchor.constraint(equalTo: tempImageView.topAnchor).isActive = true
        tempHumidityStackView.leadingAnchor.constraint(equalTo: tempImageView.trailingAnchor, constant: 50).isActive = true
        tempHumidityStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        tempHumidityStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.addSubview(subCollectionView)
        let subCollectionViewConstraints = [
            subCollectionView.topAnchor.constraint(equalTo: tempHumidityStackView.bottomAnchor, constant: 50),
            subCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            subCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            subCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ]
        
        NSLayoutConstraint.activate(subCollectionViewConstraints)
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
        
        let tempHumidityStackView = UIStackView(arrangedSubviews: [presentTempLabel, humidityLabel])
        tempHumidityStackView.translatesAutoresizingMaskIntoConstraints = false
        tempHumidityStackView.axis = .vertical
        tempHumidityStackView.alignment = .center
        tempHumidityStackView.spacing = 10
        
        if !isTransition {
            print("*****isTransition: False*****")
            scrollView.addSubview(regionLabel)
            regionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            regionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            
            scrollView.addSubview(tempImageView)
            tempImageView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
            tempImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -25).isActive = true
            tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            scrollView.addSubview(tempHumidityStackView)
            tempHumidityStackView.topAnchor.constraint(equalTo: tempImageView.topAnchor).isActive = true
            tempHumidityStackView.leadingAnchor.constraint(equalTo: tempImageView.trailingAnchor, constant: 50).isActive = true
            tempHumidityStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempHumidityStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        } else {
            print("*****isTransition: True*****")
            scrollView.addSubview(regionLabel)
            regionLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            regionLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 50).isActive = true
            
            scrollView.addSubview(tempImageView)
            tempImageView.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 30).isActive = true
            tempImageView.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -25).isActive = true
            tempImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true

            scrollView.addSubview(tempHumidityStackView)
            tempHumidityStackView.topAnchor.constraint(equalTo: tempImageView.topAnchor).isActive = true
            tempHumidityStackView.leadingAnchor.constraint(equalTo: tempImageView.trailingAnchor, constant: 50).isActive = true
            tempHumidityStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            tempHumidityStackView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        scrollView.addSubview(closeButton)
        closeButton.centerYAnchor.constraint(equalTo: regionLabel.centerYAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
 
    }
    
    func fetchDataForContentVC(regionName: String?, targetData: MainWeatherResponseModel?, isTransition: Bool = false, forURLString: String?) {
        print("스트링: \(forURLString)")
        if let regionName = forURLString {
            viewModel.getSubCurrentWeather(location: regionName) { response in
                self.subData = response
                DispatchQueue.main.async {
                    self.subCollectionView.reloadData()
                }
            }
        }

//        testTextLabel.text = targetData?.weather[0].description
        
        if let currentTemp = targetData?.main.temp, let humidity = targetData?.main.humidity {
            let degreeChangedTemp = Int(round(currentTemp - 273.15))
            DispatchQueue.main.async {
                self.regionLabel.text = regionName ?? "데이터를 불러오기 실패"
                self.presentTempLabel.text = "\(degreeChangedTemp)" + "℃"
                self.humidityLabel.text = "습도" + " " + "\(humidity)%"
            }
        }        
        
        //이미지명을 가져와서 캐시에 있는지 체크
        guard let weatherImg = targetData?.weather[0].icon else { return }
        let imgUrl = BaseURL.imgUrl.appending(weatherImg).appending("@2x.png") as NSString
        // 01d@2x.png 형태
        
        if let cachedImg = ImageCacheManager.shared.object(forKey: NSString(string: imgUrl.lastPathComponent)) {
            DispatchQueue.main.async {
                self.tempImageView.image = cachedImg
            }
        } else {
            //없다면 디스크 경로에 이미지 체크
            CustomFileManager.getImageFromDisk(imgUrl: imgUrl) { type in
                switch type {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.tempImageView.image = image
                    }
                case .failure(let err):
                    print("서버(or Disk) 이미지 호출 실패! \(err.localizedDescription)")
                }
            }
        }
        
        let size = CGSize(width: 1000, height: 10000)
        let estimateSize = testTextLabel.sizeThatFits(size)
        
        if !isTransition {
            
        } else {
            
        }
    }
    
    func fetchDataForCell(regionName: String, weatherImg: String, currentTemp: Double, currentHumidity: Int) {
        regionLabel.text = regionName
        let degreeChangedTemp = Int(round(currentTemp - 273.15))
        presentTempLabel.text = "\(degreeChangedTemp)" + "℃"
        humidityLabel.text = "\(currentHumidity)" + "%"
        
        //이미지명을 가져와서 캐시에 있는지 체크
        let imgUrl = BaseURL.imgUrl.appending(weatherImg).appending("@2x.png") as NSString
        // 01d@2x.png 형태
        
        if let cachedImg = ImageCacheManager.shared.object(forKey: NSString(string: imgUrl.lastPathComponent)) {
            DispatchQueue.main.async {
                self.tempImageView.image = cachedImg
                self.tempImageView.contentMode = .scaleAspectFit
            }
        } else {
            //없다면 디스크 경로에 이미지 체크
            CustomFileManager.getImageFromDisk(imgUrl: imgUrl) { type in
                switch type {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.tempImageView.image = image
                    }
                case .failure(let err):
                    print("서버(or Disk) 이미지 호출 실패! \(err.localizedDescription)")
                }
            }
        }
        
        
        //디스크 경로에 이미지가 있는지 체크
        //1. 있다면 캐시에 저장하고 이미지 불러오기
        //2. 없다면 url 호출로 이미지 불러오고, 디스크 경로에 저장하기
        
    }
}

extension WeatherContentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NUMBER_OF_CELL
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherCollectionViewSubCell", for: indexPath) as! WeatherCollectionViewSubCell

        if let dateStr = subData?.list[indexPath.row].dt {
            let unixTimeDate = Date(timeIntervalSince1970: dateStr)
            DispatchQueue.main.async {
                cell.timeLabel.text = "13시"
            }
        }
        if let imgName = subData?.list[indexPath.row].weather[0].icon {
            let imgUrl = BaseURL.imgUrl.appending(imgName).appending("@2x.png") as NSString
            if let cachedImg = ImageCacheManager.shared.object(forKey: NSString(string: imgUrl.lastPathComponent)) {
                DispatchQueue.main.async {
                    cell.imgView.image = cachedImg
                }
            } else {
                CustomFileManager.getImageFromDisk(imgUrl: imgUrl) { type in
                    switch type {
                    case .success(let image):
                        DispatchQueue.main.async {
                            cell.imgView.image = image
                        }
                    case .failure(let err):
                        print("서버(or Disk) 이미지 호출 실패! \(err.localizedDescription)")
                    }
                }
            }
        }
        return cell
    }
    
    
}
