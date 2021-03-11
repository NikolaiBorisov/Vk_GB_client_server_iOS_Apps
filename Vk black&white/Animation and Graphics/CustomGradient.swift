//
//  CustomGradient.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 17.02.2021.
//

import Foundation
import UIKit

class CustomGradient: UIView {
    
    //1st method
    var gradientLayer = CAGradientLayer()
    var vertical: Bool = true
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradientLayer.frame = self.bounds
        
        if gradientLayer.superlayer == nil {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
            gradientLayer.colors = [UIColor.lightGray.cgColor, UIColor.darkGray.cgColor, UIColor.black.cgColor]
            gradientLayer.locations = [0, 0.5, 1]
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}


//2nd method
//
//@IBDesignable class GradientView: UIView {
//
//
//    @IBInspectable var startColor: UIColor = .white {
//        didSet {
//            self.updateColors()
//        }
//    }
//
//    @IBInspectable var endColor: UIColor = .black {
//        didSet {
//            self.updateColors()
//        }
//    }
//
//    @IBInspectable var startLocation: CGFloat = 0 {
//        didSet {
//            self.updateLocations()
//        }
//    }
//
//    @IBInspectable var endLocation: CGFloat = 1 {
//        didSet {
//            self.updateLocations()
//        }
//    }
//
//    @IBInspectable var startPoint: CGPoint = .zero {
//        didSet {
//            self.updateStartPoint()
//        }
//    }
//
//    @IBInspectable var endPoint: CGPoint = CGPoint(x: 0, y: 1) {
//        didSet {
//            self.updateEndPoint()
//        }
//    }
//
//    override static var layerClass: AnyClass {
//        return CAGradientLayer.self
//    }
//
//    var gradientLayer: CAGradientLayer {
//        return self.layer as! CAGradientLayer
//    }
//
//    func updateLocations() {
//        self.gradientLayer.locations = [self.startLocation as NSNumber, self.endLocation as NSNumber]
//    }
//
//    func updateColors() {
//        self.gradientLayer.colors = [self.startColor.cgColor, self.endColor.cgColor]
//    }
//
//    func updateStartPoint() {
//        self.gradientLayer.startPoint = startPoint
//    }
//
//    func updateEndPoint() {
//        self.gradientLayer.endPoint = endPoint
//    }
//
//}
//
