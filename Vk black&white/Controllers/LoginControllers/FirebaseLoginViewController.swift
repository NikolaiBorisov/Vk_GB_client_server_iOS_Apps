//
//  FirebaseLoginViewController.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 11.03.2021.
//

import UIKit
import FirebaseAuth

class FirebaseLoginViewController: UIViewController {
    
    //Firebase authentication method
    static let segueIdentifier = "TabBarSegue"
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private var listener: AuthStateDidChangeListenerHandle?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        listener = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            guard
                user != nil else { return }
            self?.emailTF.text = ""
            self?.passwordTF.text = ""
            self?.performSegue(withIdentifier: FirebaseLoginViewController.segueIdentifier, sender: nil)
        }
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard
            let email = emailTF.text, let password = passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard
            let email = emailTF.text, let password = passwordTF.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
}
