//
//  AllFriendsController.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit
import  AVFoundation

struct SectionF {
    var title: String
    var items: [User]
}

class AllFriendsController: UITableViewController, UISearchBarDelegate {
    
    //2nd meth
    //var nm = NetworkManager(accessToken: Session.shared.token, userId: Session.shared.userId)
    
    let friends = FriendsFactory.makeFriends()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredFriends = [User]()
    var friendSection = [SectionF]()
    var searching = false
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        //2nd meth
        // nm.getFriends()
        //1st meth
        //NetworkManager.loadFriends(token: Session.shared.token)
        
        let friendDictionary = Dictionary.init(grouping: friends) {
            $0.name.prefix(1)
        }
        friendSection = friendDictionary.map {SectionF(title: String($0.key), items: $0.value)}
        friendSection.sort {$0.title < $1.title}
        
        //setupGestures()
        
        
    }
    
    //MARK: - Singleton Section for popOver menu is not working
//    private func setupGestures() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
//        tapGesture.numberOfTapsRequired = 1
//        //button.addGestureRecognizer(tapGesture)
//    }
//
//    @objc private func tapped() {
//        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") else { return }
//        popVC.modalPresentationStyle = .popover
//        let popOverVC = popVC.popoverPresentationController
//        popOverVC?.delegate = self
//        //popOverVC?.sourceView = self.button
//        //popOverVC?.sourceRect = CGRect(x: self.button.bounds.midX, y: self.button.bounds.minY, width: 0, height: 0)
//        popVC.preferredContentSize = CGSize(width: 300, height: 300)
//        self.present(popVC, animated: true, completion: nil)
//    }
    
    //MARK:- The end of the Singleton section
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searching {
            return 1
        } else {
            return friendSection.count
        }
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        friendSection.map {$0.title}
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return  filteredFriends.count
        } else {
            return friendSection[section].items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! AllFriendsCell
        
        let user = friends[indexPath.row]
        cell.friendsName.text = user.name
        cell.friendsName.adjustsFontSizeToFitWidth = true
        cell.friendsName.minimumScaleFactor = CGFloat(10)
        cell.friendsPhoto.image = user.avatar
        let status = UserSatus.setRandomStatus()
        switch status {
        case .online: cell.friendsStatus.textColor = .black
        default: cell.friendsStatus.textColor = .lightGray
        //Статус без switch
        //cell.friendsStatus.textColor = status == .online ? .black : .lightGray
        //cell.friendsStatus.text = status.rawValue
        }
        cell.friendsStatus.text = status.rawValue
        
        if searching {
            cell.friendsName.text = filteredFriends[indexPath.row].name
            cell.friendsPhoto.image = filteredFriends[indexPath.row].avatar
        } else {
            cell.friendsName.text = friendSection[indexPath.section].items[indexPath.row].name
            cell.friendsPhoto.image = friendSection[indexPath.section].items[indexPath.row].avatar
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel()
        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        label.text = friendSection[section].title
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
        headerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
        ])
        return headerView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserImage" {
            let photoAlbum = segue.destination as? PicturesViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                //let friend = friends[indexPath.row]
                //photoAlbum?.friend = friend
                
                if searching {
                    photoAlbum?.friend = filteredFriends[indexPath.row]
                } else {
                    photoAlbum?.friend = friendSection[indexPath.section].items[indexPath.row]
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriends = friends.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.endEditing(true) //dismiss the keyboard
        tableView.reloadData()
    }
    //Dismiss the keyboard is not working...???!!!
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        self.view.endEditing(true)
    //    }
    
    //background music
    
    var player: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "MatrixTheme3", withExtension: "mp3") else { return }
        
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
}

extension AllFriendsController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
