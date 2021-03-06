//
//MyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift


class MyGroupsViewController: UITableViewController, UISearchBarDelegate {
    
    //@IBOutlet weak var searchBar: UISearchBar!
    var searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard
            let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var myGroups: Results<Group>? {
        didSet {
            self.filteredGroups = self.myGroups
            self.tableView.reloadData()
        }
    }
    
    var notificationToken: NotificationToken?
    
    var filteredGroups: Results<Group>? {
        didSet {
            self.myGroupsDict.removeAll()
            self.firstLetter.removeAll()
            self.fillGroupsDict()
            tableView.reloadData()
        }
    }
    
    var myGroupsDict: [Character : [Group]] = [:]
    
    var firstLetter = [Character]()
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard
            segue.identifier == "AddGroup", // проверка идентификатора перехода
            let controller = segue.source as? AllGroupsTableController, // контроллер, с которого переходим
            let indexPath = controller.tableView.indexPathForSelectedRow, // если indexPath = индекс выделенной ячейки
            let myGroups = self.myGroups,
            !myGroups.contains(where: {$0.name == controller.allGroups[indexPath.row].name}) else { return }
        
        let group = controller.allGroups[indexPath.row]
        //self.myGroups.append(group)
        var newGroups = Array(myGroups)
        newGroups.append(group)
        try? RealmManager.save(items: newGroups)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateTable()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        tableView.rowHeight = 145
        tableView.register(MyGroupsHeader.self, forHeaderFooterViewReuseIdentifier: "MyGroupsHeader")
        
        self.myGroups = try? RealmManager.getBy(type: Group.self)
        
        let networkService = NetworkManager()
        networkService.loadGroups() { [weak self] groups in }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.notificationToken = self.myGroups?.observe { [weak self] change in
            guard let self = self else { return }
            switch change {
            case .initial:
                self.tableView.reloadData()
            case let .update(_, deletions, insertions, modifications):
                self.tableView.update(deletions: deletions, insertions: insertions, modifications: modifications)
            case .error(let error):
                self.show(error: error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.notificationToken?.invalidate()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.firstLetter.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let groupFirstLetter = self.firstLetter[section]
        return self.myGroupsDict[groupFirstLetter]?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        
        let firstLetter = self.firstLetter[indexPath.section]
        
        if let groups = self.myGroupsDict[firstLetter] {
            cell.configure(with: groups[indexPath.row])
        }
        
        return cell
    }
    
    //Метод просит источник данных зафиксировать вставку или удаление указанной строки в получателе
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = self.filteredGroups?[indexPath.row],
                  let objectToDelete = self.myGroups?.filter("NOT id !=%@", group.id)
            else { return }
            try? Realm().write { try? Realm().delete(objectToDelete)}
            
            let firstLetter = self.firstLetter[indexPath.section]
            self.myGroupsDict[firstLetter]?.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //Метод сообщает делегату, что  выбрана строка
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyGroupsHeader") as? MyGroupsHeader else { return nil }
        sectionHeader.textLabel?.text = String(self.firstLetter[section])
        sectionHeader.tintColor = UIColor.systemTeal.withAlphaComponent(0.3)
        
        return sectionHeader
        
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        self.firstLetter.map{String($0)}
    }
    
    private func fillGroupsDict() {
        if let filteredGroups = self.filteredGroups {
            for group in filteredGroups {
                let dictKey = group.name.first!
                if var groups = self.myGroupsDict[dictKey] {
                    groups.append(group)
                    self.myGroupsDict[dictKey] = groups
                } else {
                    self.firstLetter.append(dictKey)
                    self.myGroupsDict[dictKey] = [group]
                }
            }
            self.firstLetter.sort()
        }
    }
}

extension MyGroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterGroups(with: searchController.searchBar.text!)
    }
    
    func filterGroups(with text: String) {
        if text.isEmpty {
            self.filteredGroups = self.myGroups
            self.tableView.reloadData()
            return
        }
        self.filteredGroups = self.myGroups?.filter("name CONTAINS[cd] %@", text)
        self.tableView.reloadData()
    }
}


