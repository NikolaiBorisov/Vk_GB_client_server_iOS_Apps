//
//  Gif.swift
//  Vk black&white
//
//  Created by Macbook on 14.12.2020.
//

import UIKit

class Gif: UIViewController {

    @IBOutlet weak var gif: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gif.loadGif(name: "WRed")
        
    }
}
