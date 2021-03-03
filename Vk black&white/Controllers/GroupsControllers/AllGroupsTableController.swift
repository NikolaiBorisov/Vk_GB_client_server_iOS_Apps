//
// NotMyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit
import AlamofireImage
import Kingfisher

class AllGroupsTableController: UITableViewController {
    
    //@IBOutlet weak var searchBar: UISearchBar!
    
    var searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard
            let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var allGroups = [Group]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBar.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        tableView.rowHeight = 145
        
        NetworkManager.searchGroup(token: Session.shared.token, group: "Москва") { [weak self] groups in
            self?.allGroups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //не удается вызвать анимацию для появления групп
        animateTable()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as? MyGroupsCell else { return UITableViewCell() }

        let group = allGroups[indexPath.row]
        cell.configure(with: group)
        return cell
    }
    
}

extension AllGroupsTableController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            NetworkManager.searchGroup(token: Session.shared.token, group: searchText.lowercased()) { [weak self] groups in
                self?.allGroups = groups
            }
        } else {
            NetworkManager.searchGroup(token: Session.shared.token, group: "Москва") { [weak self] groups in
                self?.allGroups = groups
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
        tableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        NetworkManager.searchGroup(token: Session.shared.token, group: "Москва") { [weak self] groups in
            self?.allGroups = groups
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
}

extension AllGroupsTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

//My method
//    var allGroups = [Group]()
//
//    let allGroupsVK = Groups.makeGroups().sorted { $0.groupName < $1.groupName }
//    var filteredGroups = [AllGroups]()
//    var allGroupsSections = [AllGroupsSection]()
//
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//
//    var filtering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//
//
//
//        let allGroupsDictionary = Dictionary.init(grouping: allGroupsVK) { $0.groupName.prefix(1) }
//
//        allGroupsSections = allGroupsDictionary.map { AllGroupsSection(title: String($0.key), items: $0.value) }
//        allGroupsSections.sort { $0.title < $1.title }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        animateTable()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if filtering {
//            return 1
//        } else {
//            return allGroupsSections.count
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if filtering {
//            return filteredGroups.count
//        }
//        return allGroupsSections[section].items.count
//    }
//
//    override func sectionIndexTitles(for tableView: UITableView) -> [String]? { allGroupsSections.map { $0.title } }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as? MyGroupsCell
//        else { return UITableViewCell() }
//        var groups: AllGroups
//        if filtering {
//            groups = filteredGroups[indexPath.row]
//        } else {
//            groups = allGroupsSections[indexPath.section].items[indexPath.row]
//        }
//        cell.groupImage.image = groups.groupImage
//        cell.groupName.text = groups.groupName
//        return cell
//    }
//
////    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        guard
////            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyGroupsHeader") as? MyGroupsHeader else { return nil }
////        sectionHeader.textLabel?.text = String(self.allGroupsSections[section].title)
////        sectionHeader.tintColor = UIColor.systemTeal.withAlphaComponent(0.3)
////
////        return sectionHeader
////    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
//        view.backgroundColor = .systemTeal
//        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
//        label.font = UIFont(name: "Helvetica Neue", size: 17.0)
//        label.text = allGroupsSections[section].title
//        view.addSubview(label)
//        return view
//    }
//
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
//
//extension AllGroupsTableController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        filterContentForSearchText(searchController.searchBar.text!)
//        }
//    func filterContentForSearchText(_ searchText: String) {
//        filteredGroups = allGroupsVK.filter({ (allGroups: AllGroups) -> Bool in
//            return allGroups.groupName.lowercased().contains(searchText.lowercased())
//        })
//        tableView.reloadData()
//    }
//}

