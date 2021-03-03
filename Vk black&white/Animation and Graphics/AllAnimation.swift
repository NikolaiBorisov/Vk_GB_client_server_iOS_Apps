//
//  TableAnimation.swift
//  Vk black&white
//
//  Created by Macbook on 19.12.2020.
//

import UIKit
//TVC friends and groups animation
extension UITableViewController {
    
    func animateTable() {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        var index = 0
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            cell.alpha = 0
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
                cell.alpha = 1
            }, completion: nil)
            
            index += 1
        }
    }
}
//Login elements animation
extension LoginFormController {
    func animateLoginScreen() {
        //text fields and login labels animation
        let offset = view.bounds.width
        loginInput.transform = CGAffineTransform(translationX: -offset, y: 0)
        passwordInput.transform = CGAffineTransform(translationX: offset, y: 0)
        loginInputLable.transform = CGAffineTransform(translationX: -offset, y: 0)
        loginPasswordLabel.transform = CGAffineTransform(translationX: offset, y: 0)
        UIView.animate(withDuration: 1,
                       delay: 1,
                       options: .curveEaseOut,
                       animations: {
                        self.loginInput.transform = .identity
                        self.passwordInput.transform = .identity
                        self.loginInputLable.transform = .identity
                        self.loginPasswordLabel.transform = .identity
                       },
                       completion: nil)
        //Logo animation
        self.loginImage.transform = CGAffineTransform(translationX: 0,
                                                      y: -self.view.bounds.height/2)
        
        UIView.animate(withDuration: 1,
                       delay: 1,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
                        self.loginImage.transform = .identity
                       },
                       completion: nil)
        //LogIn button animation
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 2
        animation.duration = 2
        animation.beginTime = CACurrentMediaTime() + 1
        animation.fillMode = CAMediaTimingFillMode.backwards
        
        self.loginButton.layer.add(animation, forKey: nil)
        //Activity indicator view
        //loading.startAnimating()
    }
}
//Animate spring avatar friends and groups
import UIKit

extension UIImageView{
    
    func animateAvatar() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.7
        animation.toValue = 1
        animation.stiffness = 350
        animation.duration = 0.7
        self.layer.add(animation, forKey: nil)
    }
}
//Pulsation button animation
extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 0.60
        pulse.toValue = 1
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 1.0
        pulse.damping = 1
        layer.add(pulse, forKey: nil)
    }
}

