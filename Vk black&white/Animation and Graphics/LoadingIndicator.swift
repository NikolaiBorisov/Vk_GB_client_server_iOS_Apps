//
//  LoadingIndicator.swift
//  Vk black&white
//
//  Created by Macbook on 21.12.2020.
//

import UIKit

final class LoadIndicator: UIView {
    
    var circles = [CALayer]()
    let containerView = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .black
        
        let circlesCount = 3
        let side: CGFloat = 10
        let offset: CGFloat = 5
        print(bounds.width)
        let x: CGFloat = 0  
        let circleColor = UIColor.white
        
        for i in 0..<circlesCount {
            let circle = CAShapeLayer()
            circle.opacity = 0.5
            circle.path = UIBezierPath(ovalIn: CGRect(x: x + (side + offset) * CGFloat(i),
            y: 10 ,width: side,height:side)).cgPath
            circle.fillColor = circleColor.cgColor
            containerView.layer.addSublayer(circle)
            circles.append(circle)
        }
        containerView.center = CGPoint(x: bounds.width / 2.4, y: bounds.height / 2.4 )
        addSubview(containerView)
        startAnimating()
    }
    
    private func startAnimating() {
        var offset: TimeInterval = 0.0
        circles.forEach {
            $0.removeAllAnimations()
            $0.add(scaleAnimation(offset), forKey: nil)
            offset = offset + 0.10
        }
    }

    private func scaleAnimation(_ after: TimeInterval = 0) -> CAAnimationGroup {
        let scaleDown = CABasicAnimation(keyPath: "opacity")
        scaleDown.beginTime = after
        scaleDown.fromValue = 0.1
        scaleDown.toValue = 1.0
        scaleDown.duration = 2
        scaleDown.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)

        let group = CAAnimationGroup()
        group.animations = [scaleDown]
        group.repeatCount = Float.infinity
        group.autoreverses = false
        group.duration = CFTimeInterval(1)
        
        return group
    }
}

//Three dots animation on the additional ViewController 
//import UIKit
//
//class LoadingDots: UIViewController {
//
//    @IBOutlet weak var dot1: RoundingAvatar!
//    @IBOutlet weak var dot2: RoundingAvatar!
//    @IBOutlet weak var dot3: RoundingAvatar!
//
//    override func viewDidAppear(_ animated: Bool) {
//
//        UIView.animate(withDuration: 2, delay: 0,
//                       animations: {
//                        self.dot1.backgroundColor = UIColor.black
//                       })
//        UIView.animate(withDuration: 2, delay: 1,
//                       animations: {
//                        self.dot2.backgroundColor = UIColor.black
//                       })
//        UIView.animate(withDuration: 2, delay: 2,
//                       animations: {
//                        self.dot3.backgroundColor = UIColor.black
//                       },
//                       completion: {(success) in
//                        self.performSegue(withIdentifier: "Next", sender: self)
//                       })
//    }
//}
