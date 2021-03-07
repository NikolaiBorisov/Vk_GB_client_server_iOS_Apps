//
//MyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit
import Alamofire
import AlamofireImage


class MyGroupsViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var myGroups = [Group]() {
        didSet {
            self.filteredGroups = self.myGroups
        }
    }
    var filteredGroups = [Group]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
            guard
                segue.identifier == "AddGroup", // проверка идентификатора перехода
                let controller = segue.source as? AllGroupsTableController, // контроллер, с которого переходим
                let indexPath = controller.tableView.indexPathForSelectedRow, // если indexPath = индекс выделенной ячейки
                !self.myGroups.contains(where: {$0.name == controller.allGroupsVK[indexPath.row].groupName})
                
            else { return }
    
            let group = controller.allGroupsVK [indexPath.row]
        //Не работает добавление групп из общего списка групп
            //self.myGroups.append(group)
            //self.filteredGroups.append(group)
            tableView.reloadData()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animateTable()
        
        self.searchBar.delegate = self
        self.filteredGroups = myGroups
        tableView.rowHeight = 145
        
        let networkService = NetworkManager()
        networkService.loadGroups() { [weak self] groups in
            self?.myGroups = groups
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsCell
        else { return UITableViewCell() }
        
        let group = self.filteredGroups[indexPath.row]
        cell.configure(with: group)
        
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
}

extension MyGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterGroups(with: searchText)
    }
    
    fileprivate func filterGroups(with text: String) {
        if text.isEmpty {
            self.filteredGroups = self.myGroups
            self.tableView.reloadData()
            return
        }
        self.filteredGroups = self.myGroups.filter {$0.name.lowercased().contains(text.lowercased())}
        self.tableView.reloadData()
    }
}
    
//    let searchController = UISearchController(searchResultsController: nil)
//    var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//
//    var myGroups = [GroupsVk]()
//    var myGroupsSections = [MyGroupsSection]()
//    fileprivate lazy var filteredGroups = self.myGroups
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
//        navigationItem.searchController = searchController
//        searchController.searchBar.delegate = self
//        definesPresentationContext = true
//
//        LoadGroupsVK.loadGroups(token: Session.shared.token) { [weak self] group in
//            self?.myGroups = group
//            self?.filteredGroups = group
//            self?.tableView.reloadData()
//        }
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        animateTable()
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { filteredGroups.count }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsCell
//        else { return UITableViewCell() }
//
//        cell.groupName.text = myGroups[indexPath.row].name
//        AF.request((myGroups[indexPath.row].photo200)!).responseImage { response in
//            do {
//                let image = try response.result.get()
//                cell.groupImage.image = image
//            } catch {
//                print("No photo found!")
//            }
//        }
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//// Добавление групп не работает
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        guard
//            segue.identifier == "AddGroup", // проверка идентификатора перехода
//            let controller = segue.source as? AllGroupsTableController, // контроллер, с которого переходим
//            let indexPath = controller.tableView.indexPathForSelectedRow, // если indexPath = индекс выделенной ячейки
//            !self.myGroups.contains(where: {$0.name == controller.allGroups[indexPath.row].groupName})
//            //!myGroups.contains(allGroupsTVC.allGroupsSections[indexPath.section].items[indexPath.row].groupName)
//        else { return }
//
//        let group = controller.allGroups[indexPath.row]
//        self.myGroups.append(group)
//        self.filteredGroups.append(group)
//        tableView.reloadData()
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // изменение строки (удаление/ или вставка)
//        if editingStyle == .delete { // Если была нажата кнопка «Удалить»
//            filteredGroups.remove(at: indexPath.row) // Удаляем группу из массива
//            tableView.deleteRows(at: [indexPath], with: .fade) // удаляем строку из таблицы
//        }
//    }
//
////Не работают хедеры для моих групп
////    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
////        view.backgroundColor = .lightGray
////        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
////        label.font = UIFont(name: "Helvetica Neue", size: 17.0)
////        label.text = myGroupsSections[section].title
////        view.addSubview(label)
////        return view
////    }
//}
//
////  Поиск не работает
//extension MyGroupsViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        //filterContentForSearchTExt(searchController.searchBar.text!)
//        filterGroups(with: searchController.searchBar.text!)
//    }
//
//    func filterGroups(with text: String) {
//        if text.isEmpty {
//            self.filteredGroups = myGroups
//            return
//        }
//        self.filteredGroups = self.myGroups.filter { $0.name.lowercased().contains(text.lowercased()) }
//    }
//
//}


