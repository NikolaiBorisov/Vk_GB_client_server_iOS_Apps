//
//  ImagesGalleryViewController.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 14.02.2021.
//

import UIKit
import Kingfisher

class ImagesGalleryViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var albumURLs = [String]()
    var index: Int = 0

    var ownerId = Int()
    var images = [UIImage?]()
    var selectedPhoto = 0
    var leftImageView: UIImageView!
    var middleImageView: UIImageView!
    var rightImageView: UIImageView!
    var swipeToRight: UIViewPropertyAnimator!
    var swipeToLeft: UIViewPropertyAnimator!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let gestPan = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        view.addGestureRecognizer(gestPan)
        setImage()
        startAnimate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.subviews.forEach({ $0.removeFromSuperview() })
    }

    func setImage() {
        var indexPhotoLeft: Int = selectedPhoto - 1
        let indexPhotoMid: Int = selectedPhoto
        var indexPhotoRight: Int = selectedPhoto + 1
        if indexPhotoLeft < 0 {
            indexPhotoLeft = images.count - 1
        }
        if indexPhotoRight > images.count - 1 {
            indexPhotoRight = 0
        }
        view.subviews.forEach({ $0.removeFromSuperview() })

        leftImageView = UIImageView()
        middleImageView = UIImageView()
        rightImageView = UIImageView()

        leftImageView.contentMode = .scaleAspectFill
        middleImageView.contentMode = .scaleAspectFill
        rightImageView.contentMode = .scaleAspectFill

        view.addSubview(leftImageView)
        view.addSubview(middleImageView)
        view.addSubview(rightImageView)

        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        middleImageView.translatesAutoresizingMaskIntoConstraints = false
        rightImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            middleImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            middleImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            middleImageView.heightAnchor.constraint(equalTo: middleImageView.widthAnchor, multiplier: 4/3),
            middleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            leftImageView.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            leftImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            leftImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            leftImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),

            rightImageView.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            rightImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rightImageView.heightAnchor.constraint(equalTo: middleImageView.heightAnchor),
            rightImageView.widthAnchor.constraint(equalTo: middleImageView.widthAnchor),
        ])

        leftImageView.image = images[indexPhotoLeft]
        middleImageView.image = images[indexPhotoMid]
        rightImageView.image = images[indexPhotoRight]

        middleImageView.layer.cornerRadius = 8
        rightImageView.layer.cornerRadius = 8
        leftImageView.layer.cornerRadius = 8

        middleImageView.clipsToBounds = true
        rightImageView.clipsToBounds = true
        leftImageView.clipsToBounds = true

        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.middleImageView.transform = scale
        self.rightImageView.transform = scale
        self.leftImageView.transform = scale
    }

    func startAnimate(){
        setImage()
        UIView.animate(
            withDuration: 1,
            delay: 0,
            options: [],
            animations: {
                self.middleImageView.transform = .identity
                self.rightImageView.transform = .identity
                self.leftImageView.transform = .identity
            })
    }

    @objc func onPan(_ recognizer: UIPanGestureRecognizer){
        switch recognizer.state {
        case .began:
            swipeToRight = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            let translation = CGAffineTransform(translationX: self.view.bounds.maxX - 40, y: 0)
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                        }, completion: { _ in
                            self.selectedPhoto -= 1
                            if self.selectedPhoto < 0 {
                                self.selectedPhoto = self.images.count - 1
                            }
                            self.startAnimate()
                        })
                })
            swipeToLeft = UIViewPropertyAnimator(
                duration: 0.5,
                curve: .easeInOut,
                animations: {
                    UIView.animate(
                        withDuration: 0.01,
                        delay: 0,
                        options: [],
                        animations: {
                            let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                            let translation = CGAffineTransform(translationX: -self.view.bounds.maxX + 40, y: 0)
                            let transform = scale.concatenating(translation)
                            self.middleImageView.transform = transform
                            self.rightImageView.transform = transform
                            self.leftImageView.transform = transform
                        }, completion: { _ in
                            self.selectedPhoto += 1
                            if self.selectedPhoto > self.images.count - 1 {
                                self.selectedPhoto = 0
                            }
                            self.startAnimate()
                        })
                })
        case .changed:

            let translationX = recognizer.translation(in: self.view).x
            if translationX > 0 {
                swipeToRight.fractionComplete = abs(translationX)/100
            } else {
                swipeToLeft.fractionComplete = abs(translationX)/100
            }
        case .ended:
            swipeToRight.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            swipeToLeft.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            return
        }
    }

}

//    @IBOutlet weak var imageView1: UIImageView!
//    @IBOutlet weak var imageView2: UIImageView!
//    @IBOutlet weak var imageView3: UIImageView!
//
//    enum PhotoSwipeDirection {
//        case left
//        case right
//    }
//
//    var panGR: UIPanGestureRecognizer!
//    var animator: UIViewPropertyAnimator!
//    var swipeGR: UISwipeGestureRecognizer!
//
//    var direction: PhotoSwipeDirection = .left
//
//    var centerImageView: UIImageView!
//    var rightImageView: UIImageView!
//    var leftImageView: UIImageView!
//
//    var centerFramePosition: CGRect!
//    var rightFramePosition: CGRect!
//    var leftFramePosition: CGRect!
//
//    var albumURLs = [String]()
//    var index: Int = 0
//
//    var toLeftAnimation = {}
//    var toRightAnimation = {}
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupGallery()
//        setupAnimations()
//    }
//
//    private func setupGallery() {
//        self.centerFramePosition = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.rightFramePosition = CGRect(x: UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        self.leftFramePosition = CGRect(x: -UIScreen.main.bounds.width, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//
//        self.imageView1.frame = centerFramePosition
//        self.imageView2.frame = rightFramePosition
//        self.imageView3.frame = leftFramePosition
//
//        self.centerImageView = imageView1
//        self.rightImageView = imageView2
//        self.leftImageView = imageView3
//
//        centerImageView.kf.setImage(with: URL(string: self.albumURLs[index]))
//        if index + 1 < albumURLs.count {
////            rightImageView.image = album[index + 1]
//            self.rightImageView.kf.setImage(with: URL(string: self.albumURLs[index + 1]))
//        } else {
////            rightImageView.image = album[0]
//            self.rightImageView.kf.setImage(with: URL(string: self.albumURLs[0]))
//        }
//        if index - 1 >= 0 {
////            leftImageView.image = album[index - 1]
//            self.leftImageView.kf.setImage(with: URL(string: self.albumURLs[index - 1]))
//        } else {
////            leftImageView.image = album[album.count - 1]
//            self.leftImageView.kf.setImage(with: URL(string: self.albumURLs[self.albumURLs.count - 1]))
//        }
//
//        panGR = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
//        view.addGestureRecognizer(panGR)
//        panGR.delegate = self
//
//        swipeGR = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
//        swipeGR.direction = .down
//        view.addGestureRecognizer(swipeGR)
//        swipeGR.delegate = self
//
//    }
//
//    private func setupAnimations() {
//        toLeftAnimation = self.getAnimation(to: .left)
//        toRightAnimation = self.getAnimation(to: .right)
//    }
//
//    private func getAnimation(to direction: PhotoSwipeDirection) -> () -> Void {
//        let finalPosition = UIScreen.main.bounds.width
//        return {
//            UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: [], animations: {
//                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
//                    self.centerImageView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 0.8)
//                }
//
//                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.75) {
//                    switch direction {
//                    case .left:
//                        self.centerImageView.frame  =  self.centerImageView.frame.offsetBy(dx:  -finalPosition, dy: 0.0)
//                        self.rightImageView.frame  =  self.rightImageView.frame.offsetBy(dx:  -finalPosition, dy: 0.0)
//                    case .right:
//                        self.centerImageView.frame  =  self.centerImageView.frame.offsetBy(dx:  finalPosition, dy: 0.0)
//                        self.leftImageView.frame  =  self.leftImageView.frame.offsetBy(dx:  finalPosition, dy: 0.0)
//                    }
//                }
//
//                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 1) {
//                    self.centerImageView.alpha  = 0.0
//                }
//            })
//        }
//    }
//
//    private func reconfigureImageViews(to direction: PhotoSwipeDirection) {
//        switch direction {
//        case .left:
//            let tmpIV = centerImageView
//            centerImageView = rightImageView
//            rightImageView = tmpIV
//
//            rightImageView.frame = rightFramePosition
//            rightImageView.alpha  = 1
//            rightImageView.transform = .identity
//
//            index = index + 1 < albumURLs.count ? index + 1 : 0
//        case .right:
//            let tmpIV = centerImageView
//            centerImageView = leftImageView
//            leftImageView = tmpIV
//
//            leftImageView.frame = leftFramePosition
//            leftImageView.alpha  = 1
//            leftImageView.transform = .identity
//
//            index = index - 1 >= 0 ? index - 1 : albumURLs.count - 1
//        }
//
//        if index == albumURLs.count-1 {
////            rightImageView.image = album[0]
//            self.rightImageView.kf.setImage(with: URL(string: self.albumURLs[0]))
//        } else {
////            rightImageView.image = album[index + 1]
//            self.rightImageView.kf.setImage(with: URL(string: self.albumURLs[index + 1]))
//        }
//
//        if index == 0 {
////            leftImageView.image = album[album.count-1]
//            self.leftImageView.kf.setImage(with: URL(string: self.albumURLs[self.albumURLs.count - 1]))
//        } else {
////            leftImageView.image = album[index - 1]
//            self.leftImageView.kf.setImage(with: URL(string: self.albumURLs[index - 1]))
//        }
//
//    }
//
//    @objc func didPan( _ panGesture: UIPanGestureRecognizer) {
//        let finalPosition = UIScreen.main.bounds.width
//
//        switch panGesture.state {
//        case .began:
//            animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeIn)
//            direction = panGesture.velocity(in: self.view).x > 0 ? .right : .left
//
//            switch direction {
//            case .left:
//                animator.addAnimations(self.toLeftAnimation)
//            case .right:
//                animator.addAnimations(self.toRightAnimation)
//            }
//
//            animator.addCompletion { _ in
//                if !self.animator.isReversed {
//                    self.reconfigureImageViews(to: self.direction)
//                }
//            }
//
//            animator.pauseAnimation()
//
//        case .changed:
//            let translation = panGesture.translation(in: self.view)
//            let multiplayer = direction == .left ?  -1 : 1
//            animator.fractionComplete = CGFloat(multiplayer) * translation.x / finalPosition
//
//        case .ended:
//            let velocity = panGesture.velocity(in: self.view)
//            let shouldCancel = direction == .left && velocity.x > 0 || direction == .right && velocity.x < 0 || animator.fractionComplete < 0.25
//            if shouldCancel && !animator.isReversed { animator.isReversed.toggle() }
//
//            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0.0)
//
//        default: return
//        }
//
//
//    }
//
//    @objc func didSwipe(_ swipeGesture: UISwipeGestureRecognizer) {
//        performSegue(withIdentifier: "closePhotosView", sender: nil)
//
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        if gestureRecognizer == self.swipeGR &&
//            otherGestureRecognizer == self.panGR {
//            return true
//        }
//        return false
//    }
//
//}

    
