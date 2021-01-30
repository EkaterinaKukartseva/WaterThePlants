//
//  RoundedView.swift
//  WaterThePlants
//
//  Created by EKATERINA  KUKARTSEVA on 26.01.2021.
//

import UIKit
//
//@IBDesignable
class RoundedView: UIView {
    
    var arrayMask: CACornerMask = []

    @IBInspectable var isTopRightCornerRounded: Bool = false
    {
        didSet {
            if isTopRightCornerRounded {
                arrayMask.insert(.layerMaxXMinYCorner)
            }
        }
    }

    @IBInspectable var isTopLeftCornerRounded: Bool = false
    {
        didSet {
            if isTopLeftCornerRounded {
                arrayMask.insert(.layerMinXMinYCorner)
            }
        }
    }

    @IBInspectable var isBottomRightCornerRounded: Bool = false
    {
        didSet {
            if isBottomRightCornerRounded {
                arrayMask.insert(.layerMaxXMaxYCorner)
            }
        }
    }

    @IBInspectable var isBottomLeftCornerRounded: Bool = false
    {
        didSet {
            if isBottomLeftCornerRounded {
                arrayMask.insert(.layerMinXMaxYCorner)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.maskedCorners = arrayMask
    }

}
