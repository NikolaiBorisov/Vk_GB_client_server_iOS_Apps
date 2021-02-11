//
//  MatrixViewController.swift
//  Vk black&white
//
//  Created by Macbook on 14.12.2020.
//

import UIKit

class MatrixViewController: UIViewController {

    @IBOutlet weak var matrix: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        matrix.loadGif(name: "Matrix")
        }
}
