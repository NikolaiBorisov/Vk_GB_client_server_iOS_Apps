//
//MyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit
import Alamofire
import AlamofireImage


class MyGroupsViewController: UITableViewController, UISearchBarDelegate {
    
    //@IBOutlet weak var searchBar: UISearchBar!
    
    var searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard
            let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    var myGroups: [Group] = [] {
        didSet {
            self.filteredGroups = self.myGroups
        }
    }
    var filteredGroups = [Group]() {
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
            //Тут возникает ошибка, при попытке добавить новую группу из массива 
            !self.myGroups.contains(where: {$0.name == controller.allGroups[indexPath.row].name})
        
        else { return }
        
        //Не работает добавление групп из общего списка групп
        let group = controller.allGroups[indexPath.row]
        self.myGroups.append(group)
        self.filteredGroups.append(group)
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
        
        self.filteredGroups = self.myGroups
        
        let networkService = NetworkManager()
        networkService.loadGroups() { [weak self] groups in
            self?.myGroups = groups
        }
    }
    //
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
            let removed = self.filteredGroups.remove(at: indexPath.row)
            if let index = self.myGroups.firstIndex(of: removed) {
                self.myGroups.remove(at: index)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    //Метод сообщает делегату, что  выбрана строка
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    //
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyGroupsHeader") as? MyGroupsHeader else { return nil }
        sectionHeader.textLabel?.text = String(self.firstLetter[section])
        sectionHeader.contentView.backgroundColor = .systemTeal
        return sectionHeader
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        self.firstLetter.map{String($0)}
    }
    
    private func fillGroupsDict() {
        for group in self.filteredGroups {
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

extension MyGroupsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterGroups(with: searchController.searchBar.text!)
    }
    
    func filterGroups(with text: String) {
        if text.isEmpty {
            self.filteredGroups = myGroups
            return
        }
        self.filteredGroups = self.myGroups.filter { $0.name.lowercased().contains(text.lowercased()) }
    }
}



