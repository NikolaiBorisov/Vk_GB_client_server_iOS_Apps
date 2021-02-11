//
//  FriendsSinglePhotoVC.swift
//  Vk black&white
//
//  Created by Macbook on 24.12.2020.
//

import UIKit


class FriendsSinglePhotoVC: UIViewController {
    
    var image: UIImage?

    @IBOutlet weak var singlePhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        singlePhoto.image = image
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        present(shareController, animated: true, completion: nil)
        shareController.completionWithItemsHandler = {_, Bool, _, _ in if Bool {
            print("Success!")
        }
        }
        
    }
}
