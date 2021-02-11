//
// NotMyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit

struct SectionG {
    var title: String
    var items: [Groups]
}

class NotMyGroupsViewController: UITableViewController {
    
    //2nd meth
    //var nm = NetworkManager(accessToken: Session.shared.token, userId: Session.shared.userId)
    
    var groups = GroupFactory.makeGroup()
    var filteredGroups = [Groups] ()
    var groupsSection = [SectionG]()
    var searching = false
    
    @IBOutlet weak var searchBarForGroups: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2nd m
        //nm.searchGroup(withTitle: "")
        //1st m
        //NetworkManager.groupSearch(token: Session.shared.token, query: "")
    }
    
    //Как добавить хедеры в группы?
    //    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    //        tableView.sectionIndexColor = .darkGray
    //        tableView.sectionIndexBackgroundColor = .init(displayP3Red: 31, green: 33, blue: 36, alpha: 0.0)
    //      return  groupsSection.map {$0.title}
    //    }
    //
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let headerView = UIView()
    //        let label = UILabel()
    //        headerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    //        label.text = groupsSection[section].title
    //        label.textColor = UIColor.black
    //        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
    //        headerView.addSubview(label)
    //        label.translatesAutoresizingMaskIntoConstraints = false
    //        NSLayoutConstraint.activate([
    //        label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
    //        label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
    //        label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16)
    //        ])
    //        return headerView
    //    }
    
   
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            return filteredGroups.count
        } else {
            return groups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as! MyGroupsCell // привязка ячеек к идентификатору и к нашему классу, кт заимствует общий VC
        if searching {
            cell.groupName.text = filteredGroups[indexPath.row].title
            cell.groupImage.image = filteredGroups[indexPath.row].photo
        } else {
            cell.groupName.text = groups[indexPath.row].title
            cell.groupImage.image = groups[indexPath.row].photo
        }
        return cell
    }
}

extension NotMyGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //NetworkManager.groupSearch(title: searchText)
        filteredGroups = groups.filter({$0.title.lowercased().contains(searchText.lowercased())})
        searching = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.endEditing(true) //dismiss the search bar
        tableView.reloadData()
    }
}

