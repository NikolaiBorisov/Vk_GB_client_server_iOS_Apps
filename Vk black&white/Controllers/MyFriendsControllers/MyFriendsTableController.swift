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

class MyFriendsTableController: UITableViewController, UISearchBarDelegate {
    
    //Add search bar in main story board and coonect to this outlet if you gonna use the 2nd method for searching friends
    @IBOutlet weak var searchBar: UISearchBar!
    
    //Set up a search bar without story board
    let searchController = UISearchController(searchResultsController: nil)
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    //Создаем пустой массив друзей
    var friends: [User] = [] {
        //После загрузки друзей массив отсортированных друзей равен массиву друзей
        didSet {
            self.filteredFriends = self.friends
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
        self.filteredFriends = self.friends
        
        //Вызываем метод загрузки друзей из НетворкМенеджер
        let networkService = NetworkManager()
        networkService.loadFriends() { [weak self] friends in
            self?.friends = friends
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
        //Создаем переменную status и присваиваем случаный статус в сети или нет
        let status = UserSatus.setRandomStatus()
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
            //cell.friendsPhoto.addGestureRecognizer(UITapGestureRecognizer(target: cell.friendsPhoto, action: #selector(cell.friendsPhoto.handleTap)))
            //Отображаем в ячейке рандомный статус друга
            cell.friendsStatus.text = status.rawValue
        }
        return cell
    }
    
    //Set up headers 1st method (use "class FriendsSectionHeader: UITableViewHeaderFooterView" for set up)
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader") as? FriendsSectionHeader else { return nil }
        //Присваиваем хедеру строковое значение из массива первых букв
        sectionHeader.textLabel?.text = String(self.firstLetters[section])
        //Устанавливаем фон хедера
        sectionHeader.contentView.backgroundColor = .systemTeal
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
            self.filteredFriends = friends
            return
        }
        self.filteredFriends = self.friends.filter { $0.lastName.lowercased().contains(text.lowercased()) }
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




//2nd method

//    let vkService = NetworkManager()
//    var users = [UserVK]() {
//        didSet {
//            self.sortedUsers = self.users
//        }
//    }
//    var sortedUsers = [UserVK]()
//    var usersInAlphabeticalOrder = [[UserVK]]()
//    var firstLettersOfnames = [Character]()
//
//
//    //Set up search bar
//    var filteredUsers = [UserVK]()
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//
//    private var searchBarIsActive: Bool = false
//    private var isFiltering: Bool {
//        return !searchBarIsEmpty && searchBarIsActive
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //backgroundMusic.playSound()
//
//        //Get users from a server
//        vkService.loadFriends { [weak self] users in
//            self?.users = users
//            self?.tableView.reloadData()
//        }
//
//        //Sort users by last name
//        self.sortedUsers = users.sorted{$0.lastName < $1.lastName}
//
//        //Get array of friends in alphabetical order
//        for user in self.sortedUsers {
//            if (self.firstLettersOfnames.contains(user.lastName.first!)) {
//                self.usersInAlphabeticalOrder[self.usersInAlphabeticalOrder.count - 1].append(user)
//            } else {
//                self.firstLettersOfnames.append(user.lastName.first!)
//                self.usersInAlphabeticalOrder.append([user])
//            }
//        }
//        self.tableView.reloadData()
//    }
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if isFiltering {
//            return 1
//        } else {
//            return usersInAlphabeticalOrder.count
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredUsers.count
//        } else{
//            return usersInAlphabeticalOrder[section].count
//        }
//    }
//
//    // override func sectionIndexTitles(for tableView: UITableView) -> [String]? { friendsSections.map { $0.title } }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard
//            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? FriendsCell
//        else { return UITableViewCell() }
//
//        cell.friendsPhoto.alpha = 0
//
//        UIView.animate(withDuration: 1, animations: { cell.friendsPhoto.alpha = 1})
//        UIView.animate(withDuration: 1, delay: 0.1, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.6, options: [], animations: {cell.frame.origin.x -= 100})
//
//        var user: UserVK
//
//        if isFiltering {
//            user = filteredUsers[indexPath.row]
//        } else {
//            user = usersInAlphabeticalOrder[indexPath.section][indexPath.row]
//        }
//
//        cell.selectionStyle = .none
//
//        //Set user's image to the cell
//        if let imageUrl = URL(string: user.avatarURL) {
//            DispatchQueue.global().async {
//                let data = try? Data(contentsOf: imageUrl)
//                if let data = data {
//                    let image = UIImage(data: data)
//                    DispatchQueue.main.async {
//                        cell.friendsPhoto.image = image
//                    }
//                }
//            }
//        }
//
//        //Set user's name to the cell
//        cell.friendsName.text = user.lastName + "" + user.firstName
//
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if isFiltering {
//            return .none
//        } else {
//            return "\(self.firstLettersOfnames[section])"
//        }
//    }
//
//    //Хедеры
//    //    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    //        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 10.0))
//    //        view.backgroundColor = .lightGray
//    //        let label = UILabel(frame: CGRect(x: 45, y: 5, width: tableView.frame.width - 10, height: 20.0))
//    //        label.font = UIFont(name: "Helvetica Neue", size: 17.0)
//    //        label.text = friendsSections[section].title
//    //        view.addSubview(label)
//    //        return view
//    //    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showUserImage" { //check segue identifier
//            if let indexPath = self.tableView.indexPathForSelectedRow { // get the index path to the controller's selected row
//                let photoController = segue.destination as! ImagesGalleryViewController // get the link to the controller
//
//                var user: UserVK
//
//                if isFiltering { // if search bar is active
//                    user = filteredUsers[indexPath.row]
//                } else {
//                    user = usersInAlphabeticalOrder[indexPath.section][indexPath.row]
//                }
//                photoController.ownerId = user.id
//            }
//        }
//    }
//}
////    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////    }
////}
//extension MyFriendsTableController: UISearchBarDelegate {
//
//    internal func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBarIsActive = true;
//    }
//    internal func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBarIsActive = true;
//    }
//    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBarIsActive = false;
//    }
//    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBarIsActive = false;
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredUsers = users.filter({(user:UserVK) in
//            return user.lastName.lowercased().contains(searchText.lowercased())
//        })
//        if(filteredUsers.count == 0) {
//            searchBarIsActive = false;
//        } else {
//            searchBarIsActive = true;
//        }
//        tableView.reloadData()
//    }
//
//}
