//
//  LoginFormController.swift
//  Vk black&white
//
//  Created by Macbook on 03.12.2020.
//

import UIKit
import AVFoundation


class LoginFormController: UIViewController {
    
    var player: AVAudioPlayer?
    
    @IBAction func exit(segue: UIStoryboardSegue) {
    }
    
    private let animator = Animator()
    
    @IBOutlet weak var cloudView: UIView!
    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var loginInputLable: UILabel!
    @IBOutlet weak var loginPasswordLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    //@IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    //Singleton section
    @IBOutlet weak var tokenTF: UITextField!
    @IBOutlet weak var userIDTF: UITextField!
    
    @IBAction func sessionDataButtonPressed(_ sender: UIButton) {
        //Read and print out the session data
        let session = Session.shared
        tokenTF.text = session.token
        userIDTF.text = String(describing: session.userId)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
        
        //Create an instance of class Session and fill in some data
        let session = Session.shared
        session.token = (SecCreateSharedWebCredentialPassword() as String?)!
        session.userId = Int.random(in: 0...10000)
        
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        //playSound() //background music
        //Анимированный переход на MyFriends
        //        let navigationController = UINavigationController()
        //        let myFriends = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AllFriendsController")
        //        navigationController.setViewControllers([myFriends], animated: false)
        //        navigationController.transitioningDelegate = self
        //        present(navigationController, animated: true)
        
        // Получаем текст логина
        let login = loginInput.text!
        // Получаем текст-пароль
        let password = passwordInput.text!
        // Проверяем, верны ли они
        if login == "" && password == "" {
            print("успешная авторизация")
        } else {
            print("неуспешная авторизация")
        }
    }
    //background music
    func playSound() {
        guard let url = Bundle.main.url(forResource: "MatrixTheme1", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    //Cloud animation
    //    func pathAnimation(){
    //
    //        let cloud = UIView()
    //        view.addSubview(cloud)
    //        cloudView.translatesAutoresizingMaskIntoConstraints = false
    //
    //        let path = UIBezierPath()
    //
    //        path.move(to: CGPoint(x: 10, y: 60))
    //        path.addQuadCurve(to: CGPoint(x: 20, y: 40), controlPoint: CGPoint(x: 5, y: 50))
    //        path.addQuadCurve(to: CGPoint(x: 40, y: 20), controlPoint: CGPoint(x: 20, y: 20))
    //        path.addQuadCurve(to: CGPoint(x: 70, y: 20), controlPoint: CGPoint(x: 55, y: 0))
    //        path.addQuadCurve(to: CGPoint(x: 80, y: 30), controlPoint: CGPoint(x: 80, y: 20))
    //        path.addQuadCurve(to: CGPoint(x: 110, y: 60), controlPoint: CGPoint(x: 110, y: 30))
    //        path.close()
    //
    //        let layerAnimation = CAShapeLayer()
    //
    //        layerAnimation.path = path.cgPath
    //        layerAnimation.strokeColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    //        layerAnimation.fillColor = UIColor.white.cgColor
    //        layerAnimation.lineWidth = 8
    //        layerAnimation.lineCap = .round
    //
    //        cloudView.layer.addSublayer(layerAnimation)
    //
    //        let pathAnimationEnd = CABasicAnimation(keyPath: "strokeEnd")
    //
    //        pathAnimationEnd.fromValue = 0
    //        pathAnimationEnd.toValue = 1
    //        pathAnimationEnd.duration = 2
    //        pathAnimationEnd.fillMode = .both
    //        pathAnimationEnd.isRemovedOnCompletion = false
    //        layerAnimation.add(pathAnimationEnd, forKey: nil)
    //
    //        let pathAnimationStart = CABasicAnimation(keyPath: "strokeStart")
    //
    //        pathAnimationStart.fromValue = 0
    //        pathAnimationStart.toValue = 1
    //        pathAnimationStart.duration = 2
    //        pathAnimationStart.fillMode = .both
    //        pathAnimationStart.isRemovedOnCompletion = false
    //        pathAnimationStart.beginTime = 1
    //
    //        let animationGroup = CAAnimationGroup()
    //
    //        animationGroup.duration = 3
    //        animationGroup.fillMode = CAMediaTimingFillMode.backwards
    //        animationGroup.animations = [pathAnimationEnd, pathAnimationStart]
    //        animationGroup.repeatCount = .infinity
    //        layerAnimation.add(animationGroup, forKey: nil)
    //    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateLoginScreen()
        //pathAnimation() //Cloud animation function
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Проверяем данные
        let checkResult = checkUserData()
        // Если данные не верны, покажем ошибку
        if !checkResult {
            showLoginError()
        }
        // Вернем результат
        return checkResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        if login == "" && password == "" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        // Создаем контроллер
        let alter = UIAlertController(title: "Ошибка", message: "Введены не верные данные пользователя", preferredStyle: .alert)
        // Создаем кнопку для UIAlertController
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        // Добавляем кнопку на UIAlertController
        alter.addAction(action)
        // Показываем UIAlertController
        present(alter, animated: true, completion: nil)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
}

extension LoginFormController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? { animator }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? { animator }
}

