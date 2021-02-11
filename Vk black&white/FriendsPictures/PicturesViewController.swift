//
//  PicturesViewController.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit

class PicturesViewController: UICollectionViewController, iCarouselDelegate, iCarouselDataSource {
    
    //2nd meth
    //var nm = NetworkManager(accessToken: Session.shared.token, userId: Session.shared.userId)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2nd m
        //nm.getPhotos(ownerId: "")
        //1st m
        //NetworkManager.loadFriendsPhotos(token: Session.shared.token)
        
        title = friend.name
        //Тип карусели
        carouselView.type = .coverFlow2
        carouselView.contentMode = .scaleToFill
        carouselView.isPagingEnabled = true

    }

    //Кол-во элементов в карусели
    func numberOfItems(in carousel: iCarousel) -> Int {
        return friend.photos.count
    }
    //Вывод отдельного фото на экран в карусели
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var imageView: UIImageView!
        if view == nil {
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 300))
            imageView.contentMode = .scaleAspectFill
        } else {
            imageView = view as? UIImageView
        }
        imageView.image = friend.photos[index]
        return imageView
    }
    //Смена объектов в карусели
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if option == iCarouselOption.spacing {
            return 1
        }
        return value
    }
    //Аутлет для вью карусели
    @IBOutlet weak var carouselView: iCarousel!

    var friend: User!

}


//Метод просмотра каждого фото по отдельности с переходом на отдельный экран
//    class PicturesViewController: UICollectionViewController {
//
//    private var galleryCollectionView = GalleryCollectionView()
//
//    var friend: User!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        title = friend.name
//
//        view.addSubview(galleryCollectionView)
//    }
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "ShowSinglePhoto" {
//                let singlePhotoVC = segue.destination as! FriendsSinglePhotoVC
//                let cell = sender as! PicturesCell
//                singlePhotoVC.image = cell.pictures.image
//            }
//        }
//
//        override func numberOfSections(in collectionView: UICollectionView) -> Int { 1 }
//
//        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { friend.photos.count }
//
//        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsPictures", for: indexPath) as! PicturesCell
//            let album = friend.photos[indexPath.row]
//            cell.pictures.image = album
//            return cell
//        }
//    }


//Разделение фото на две колонки
//extension PicturesViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.frame.width - 50) / 2
//        return CGSize(width: width, height: width)
//    }
//}

//class PicturesViewController: UICollectionViewController {
//Right and left swipe not finished
//    Connect a UIImageView to the outlet below
//    @IBOutlet weak var swipeImageView: UIImageView!
//    Type in the names of your images below
//    let imageNames = ["","","","",""]
//
//    var friend: User!
//
//    var currentImage = 0
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
//        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
//        self.view.addGestureRecognizer(swipeRight)
//
//        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
//        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
//        self.view.addGestureRecognizer(swipeLeft)
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
//
//        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
//
//
//            switch swipeGesture.direction {
//            case UISwipeGestureRecognizer.Direction.left:
//                if currentImage == friend.photos.count - 1 {
//                    currentImage = 0
//
//                }else{
//                    currentImage += 1
//                }
//                swipeImageView.image = UIImage(named: imageNames[currentImage])
//
//            case UISwipeGestureRecognizer.Direction.right:
//                if currentImage == 0 {
//                    currentImage = friend.photos.count - 1
//                }else{
//                    currentImage -= 1
//                }
//                swipeImageView.image = UIImage(named: imageNames[currentImage])
//            default:
//                break
//            }
//        }
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//}
