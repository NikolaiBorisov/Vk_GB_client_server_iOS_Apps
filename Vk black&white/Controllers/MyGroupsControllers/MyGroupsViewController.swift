//
//MyGroupsViewController.swift
//  Vk black&white
//  Created by Macbook on 08.12.2020.

import UIKit
import Alamofire

class MyGroupsViewController: UITableViewController, UISearchBarDelegate {
    
    //2nd meth
    //var nm = NetworkManager(accessToken: Session.shared.token, userId: Session.shared.userId)
    
    var groups = [ // var groups = [Groups]() - пустой TVC
        Groups(title: "GeekBrains", photo: UIImage(named: "Geeks")),
        Groups(title: "Google", photo: UIImage(named: "Google"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //2nd m
        //nm.getGroups()
        //1st m
        //NetworkManager.loadGroups(token: Session.shared.token)
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { groups.count }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! MyGroupsCell
        let group = groups[indexPath.row]
        cell.groupName.text = group.title
        cell.groupImage.image = group.photo
        return cell
    }
    
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        if segue.identifier == "AddGroup" { // проверка идентификатора перехода
            let allGroupsTVC = segue.source as! NotMyGroupsViewController // контроллер, с которого переходим
            if let indexPath = allGroupsTVC.tableView.indexPathForSelectedRow { // если indexPath = индекс выделенной ячейки
                
                if allGroupsTVC.searching {
                    let group = allGroupsTVC.filteredGroups[indexPath.row] // получить группу по индексу
                    if !groups.contains(where: { g -> Bool in // проверка на наличие строки в избранном
                        return group.title == g.title}) {
                        groups.append(group)
                        tableView.reloadData()
                    }
                } else {
                    let group = allGroupsTVC.groups[indexPath.row]
                    if !groups.contains(where: { g -> Bool in
                        return group.title == g.title}) {
                        groups.append(group)
                        tableView.reloadData()
                }
            }
        }
    }
}

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { // изменение строки (удаление/ или вставка)
        if editingStyle == .delete { // Если была нажата кнопка «Удалить»
            groups.remove(at: indexPath.row) // Удаляем группу из массива
            tableView.deleteRows(at: [indexPath], with: .fade) // удаляем строку из таблицы
        }
    }
}

