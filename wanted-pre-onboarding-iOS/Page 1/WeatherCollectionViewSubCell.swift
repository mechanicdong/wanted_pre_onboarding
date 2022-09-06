//
//  WeatherCollectionViewSubCell.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/09/05.
//

import Foundation
import UIKit

class WeatherCollectionViewSubCell: UICollectionViewCell {
    var timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var imgView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var tempLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        contentView.addSubview(timeLabel)
        timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
