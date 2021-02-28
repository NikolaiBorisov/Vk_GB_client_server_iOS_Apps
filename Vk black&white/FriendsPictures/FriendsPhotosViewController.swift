//
//  FriendsPhotosViewController
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit
import RealmSwift

class FriendsPhotosViewController: UICollectionViewController {
    
    @IBAction func closePhotosView(_ unwindSegue: UIStoryboardSegue) {}
    
    var user: User?
    
    private lazy var userImages = try? Realm().objects(Photo.self) {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var userAvatar: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let networkService = NetworkManager()
        if let userId = self.user?.id {
            networkService.loadPhotos(for: userId) { [weak self] photos in
                //self?.userImages = photos.compactMap { $0.sizes[$0.sizes.count - 1].url }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "SwipePhoto",
            let controller = segue.destination as? ImagesGalleryViewController,
            let cell = sender as? FriendsPhotoCell,
            let imageIndexPath = self.collectionView.indexPath(for: cell) else { return }
        
        controller.friend = user
        controller.title = ("\(user?.lastName ?? "") \(user?.firstName ?? "")")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.convertToArray(results: userImages).count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as? FriendsPhotoCell,
            let imgArray = self.userImages?[indexPath.row]
        else { return UICollectionViewCell() }
        
        let img = imgArray.sizes[indexPath.row]
        cell.configure(with: img.url)
        return cell
    }
}

extension FriendsPhotosViewController {
    private func convertToArray <T>(results: Results<T>?) -> [T] {
        guard let results = results else { return [] }
        return Array(results)
    }
}
