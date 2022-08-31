//
//  RelativeLayoutUtilityClass.swift
//  wanted-pre-onboarding-iOS
//
//  Created by 이동희 on 2022/08/31.
//

import Foundation
import UIKit

class RelativeLayoutUtilityClass {

    var heightFrame: CGFloat?
    var widthFrame: CGFloat?

    init(referenceFrameSize: CGSize){
        heightFrame = referenceFrameSize.height
        widthFrame = referenceFrameSize.width
    }

    func relativeHeight(multiplier: CGFloat) -> CGFloat {
        return multiplier * self.heightFrame!
    }

    func relativeWidth(multiplier: CGFloat) -> CGFloat {
        return multiplier * self.widthFrame!
    }
}
