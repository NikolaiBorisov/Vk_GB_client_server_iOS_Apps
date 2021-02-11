//
//  VKLoginViewController.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 10.02.2021.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {
    
    //2nd method NetworkManager
    //let nm = NetworkManager(accessToken: Session.shared.token, userId: Session.shared.userId)
    
    let netConstants = NetworkConstants()
    
    @IBOutlet weak var webView: WKWebView! {
        //Subscribe webview delegate
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Compose the components for Vk
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: netConstants.clientID),//insert client ID
            //Scope for friends, photos, groups
            URLQueryItem(name: "scope", value: netConstants.scope),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: netConstants.versionAPI)
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
    }
    
}

extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment
        else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        print(params)
        //check availability of received parameters
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString) else {
            decisionHandler(.allow)
            return
        }
        
        Session.shared.userId = Int(userIdString) ?? 0 // save received userId to the Session singleton
        Session.shared.token = token // save received token to the Session singleton
        //Requests 1st method:
        NetworkManager.loadGroups(token: token)
        //NetworkManager.loadFriends(token: token)
        //NetworkManager.loadFriendsPhotos(token: token)
        //NetworkManager.groupSearch(token: token, query: "GeekBrains")
        
        //Requests 2nd method: При вызове методов выдает ошибку: "токен не был передан".qqqqqqq
//        nm.getGroups()
//        nm.getFriends()
//        nm.getPhotos()
//        nm.searchGroup(withTitle: "GeekBrains")
        
        print("access_token: " + token)
        print("userID: " + userIdString)
        
        decisionHandler(.cancel) // navigation ended
        performSegue(withIdentifier: "ToTabBar", sender: nil) // go to the next VC
    }
}
