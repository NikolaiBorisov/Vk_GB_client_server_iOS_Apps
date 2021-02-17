//
//  FriendsPhotosViewController
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit

class FriendsPhotosViewController: UICollectionViewController {
    
    @IBAction func closePhotosView(_ unwindSegue: UIStoryboardSegue) {}
    
    var user: User?
    var userImages = [String]() {
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
                self?.userImages = photos.compactMap { $0.sizes[$0.sizes.count - 1].url }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showUserImage",
            let controller = segue.destination as? ImagesGalleryViewController,
            let cell = sender as? FriendsPhotoCell,
            let imageIndexPath = self.collectionView.indexPath(for: cell)
        else { return }
        
        controller.albumURLs = self.userImages
        controller.index = imageIndexPath.row
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.userImages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendPhotoCell", for: indexPath) as? FriendsPhotoCell
        else { return UICollectionViewCell() }
        
        let img = self.userImages[indexPath.row]
        cell.configure(with: img)
        return cell
    }
}

