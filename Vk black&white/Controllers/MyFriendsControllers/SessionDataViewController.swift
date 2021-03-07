//
//  SessionDataViewController.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 06.02.2021.
//

import UIKit

class SessionDataViewController: UIViewController {
    @IBOutlet weak var tokenTF: UITextField!
    @IBOutlet weak var userIDTF: UITextField!
    
    @IBAction func sessionDataButtonPressed(_ sender: UIButton) {
        
        let session = Session.shared
        tokenTF.text = session.token
        userIDTF.text = String(describing: session.userId)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = Session.shared
        session.token = (SecCreateSharedWebCredentialPassword() as String?)!
        session.userId = Int.random(in: 0...1000)

    }

}
