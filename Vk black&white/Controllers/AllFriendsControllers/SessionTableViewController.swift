//
//  SessionTableViewController.swift
//  Vk black&white
//
//  Created by NIKOLAI BORISOV on 06.02.2021.
//

import UIKit

class SessionTableViewController: UITableViewController {
    let array = ["Token:", "UserID:"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isScrollEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        preferredContentSize = CGSize(width: 300, height: tableView.contentSize.height)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let textData = array[indexPath.row]
        cell.textLabel?.text = textData
        return cell
    }
   

}
