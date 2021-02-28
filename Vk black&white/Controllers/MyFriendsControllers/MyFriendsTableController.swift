//
//  AllFriendsController.swift
//  Vk black&white
//
//  Created by Macbook on 08.12.2020.
//

import UIKit
import AVFoundation
import Alamofire
import Kingfisher
import RealmSwift

class MyFriendsTableController: UITableViewController, UISearchBarDelegate {
    //Просмотреть друзей онлайн
    @IBAction func onlineSegmentControl(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0: filteredFriends = self.convertToArray(results: friends)
        case 1: filteredFriends = self.convertToArray(results: friends).filter { $0.statusOnline == 1 }
        default: print("0")
        }
    }
    
    //Add search bar in main story board and coonect to this outlet, if you gonna use the 2nd method for searching friends
    //@IBOutlet weak var searchBar: UISearchBar!
    
    //Set up a search bar without story board
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    //
    private lazy var friends = try? Realm().objects(User.self) {
        //После загрузки друзей массив отсортированных друзей равен массиву друзей
        didSet {
            self.filteredFriends = self.convertToArray(results: friends)
            self.tableView.reloadData()
        }
    }
    
   
    //Создаем массив друзей отсортированных по первой букве в алфавитном порядке
    var filteredFriends = [User]() {
        didSet {
            //После загрузки друзей обновляем словарь удаляя друзей
            self.friendsDict.removeAll()
            //Удаляем массив первых букв
            self.firstLetters.removeAll()
            //Заполняем словарь друзей заново
            self.fillFriendsDict()
            //Обновляем данные в таблице
            tableView.reloadData()
        }
    }
    //Создаем словарь друзей, гле ключ - это первая буква, значение  - это имя и фамилия друга
    var friendsDict: [Character: [User]] = [:]
    //Создаем массив первых букв имен
    var firstLetters = [Character]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Animation of friends appearance не работает
        animateTable()
        
        //Search bar activation without story board
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.setValue("Cancel", forKey: "cancelButtonText")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        //Set up the row height according the height in SB
        tableView.rowHeight = 145
        //Set up the headers
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
        
        //При загрузке вью отсортированный массив друзей равен массиву друзей
        self.filteredFriends = self.convertToArray(results: friends)
        
        //Вызываем метод загрузки друзей из НетворкМенеджер
        let networkService = NetworkManager()
        networkService.loadFriends() { [weak self] friends in
            //self?.friends = self?.convertToArray(results: friends)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Animate friends appearance не работает
        animateTable()
        //tableView.reloadData()
    }
    
    //Количество секций в таблице равно кол-ву друзей отсортированных по 1й букве в алфавитном порядке
    override func numberOfSections(in tableView: UITableView) -> Int {
        self.firstLetters.count
    }
    //Кол-во строк в секции равно кол-ву друзей отсортированных по первой букве в алф порядке
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Присваиваем переменной массив секций друзей по 1й букве
        let nameFirstLetter = self.firstLetters[section]
        //Возвращаем словарь друзей типа ключ - первая буква, значение - имя друга, присваиваем нулевое значение по дефолту с помощью нил коалейсинг оператор на случай если значение = nil
        return self.friendsDict[nameFirstLetter]?.count ?? 0
    }
    //Запрашиваем у источника данных ячейку для вставки в определенное место тейбл вью
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Создаем ячейку и делаем проверку через гард
        guard
            //Ячейка равна переиспользуемой ячейке с идентификатором в определенном месте по индексу
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? MyFriendsCell //Делаем приведение типа нашей ячейки к типу ячейки во FriendsCellVC
        else { return UITableViewCell() } //Если ячейка не обнаружена, то возвращаем системную пустую ячейку
        //Присваиваем константе массив первых букв по опредленному месту в секции
        let firstLetter = self.firstLetters[indexPath.section]
        //Если константа users = словарю друзей, то созадем ячейку с именем друга, фото, статусом
        if let users = self.friendsDict[firstLetter] {
            cell.configure(with: users[indexPath.row])
        }
        return cell
    }
    
    //Set up headers 1st method (use "class FriendsSectionHeader: UITableViewHeaderFooterView" for set up)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader") as? FriendsSectionHeader else { return nil }
        //Присваиваем хедеру строковое значение из массива первых букв
        sectionHeader.textLabel?.text = String(self.firstLetters[section])
        //Устанавливаем фон хедера и его прозрачность
        sectionHeader.tintColor = UIColor.systemTeal.withAlphaComponent(0.3)
        
        return sectionHeader
    }
    //Set up headers 2nd method (both are usable)
    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
    //        view.backgroundColor = .lightGray
    //        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
    //        label.font = UIFont(name: "Helvetica Neue", size: 17.0)
    //        label.text = String(self.firstLetters[section])
    //        view.addSubview(label)
    //        return view
    //    }
    
    //Метод для установки боковой буквенной панели поиска
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        self.firstLetters.map{String($0)} //Используем значения преобразованного массива первых букв имен, где функция map возвращает коллекцию из первых букв
    }
    
    //Метод перехода к коллекции фото друзей
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showUserImage", //Присваиваем segue идентификатор
            let controller = segue.destination as? FriendsPhotosViewController, //Кастим наш текущий контроллер к типу контроллера назначения
            let indexPath = tableView.indexPathForSelectedRow //Осуществляем переход по индексу в выбранную ячейку
        else { return }
        
        let firstLetter = self.firstLetters[indexPath.section]
        
        if let users = self.friendsDict[firstLetter] {
            let user = users[indexPath.row]
            controller.user = user
        }
    }
    
    //Метод заполнения словаря друзей
    private func fillFriendsDict() {
        for user in self.filteredFriends {
            let dictKey = user.firstName.first!
            if var users = self.friendsDict[dictKey] {
                users.append(user)
                self.friendsDict[dictKey] = users
            } else {
                self.firstLetters.append(dictKey)
                self.friendsDict[dictKey] = [user]
            }
        }
        self.firstLetters.sort()
    }
    
}
//Search bar 1st method for the programmatic search bar  (search only by last name)
extension MyFriendsTableController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterFriends(with: searchController.searchBar.text!)
    }
    
    func filterFriends(with text: String) {
        if text.isEmpty {
            self.filteredFriends = self.convertToArray(results: friends)
            return
        }
        self.filteredFriends = self.convertToArray(results: friends).filter { ($0.firstName + $0.lastName).lowercased().contains(text.lowercased()) }
    }
}

extension MyFriendsTableController {
    private func convertToArray <T>(results: Results<T>?) -> [T] {
        guard let results = results else { return [] }
        return Array(results)
    }
}
//Search bar 2nd method for the story board search bar (search only by first name). Yiu need to add search bar in the story board manualy
//extension MyFriendsTableController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterFriends(with: searchText)
//    }
//
//    fileprivate func filterFriends(with text: String) {
//        if text.isEmpty {
//            self.filteredFriends = friends
//            return
//        }
//
//        self.filteredFriends = self.friends.filter {$0.firstName.lowercased().contains(text.lowercased())}
//    }
//}
