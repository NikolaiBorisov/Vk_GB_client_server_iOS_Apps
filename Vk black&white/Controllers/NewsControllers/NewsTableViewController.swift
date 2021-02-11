//
//  NewsTableViewController.swift
//  Vk black&white
//
//  Created by Macbook on 19.12.2020.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let news = NewsFactory.makeNews()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) { animateTable() }

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { news.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsTableViewCell
        
        let postDate = getDateAndTime()
        cell.newsDateTime.text = postDate
        cell.newsName.text = news[indexPath.row].newsNameLabel
        cell.newsAvatar.image = news[indexPath.row].newsAvatar
        cell.newsImage.image = news[indexPath.row].newsImage
        cell.newsComment.text = news[indexPath.row].newsCommentLabel
        //когда был в сети
//        let rightNow = Date()
//        let calendar = Calendar.current
//        let time = calendar.dateComponents([.minute], from: rightNow).minute!
//        cell.newsDateTime.text = String(time) + " minutes ago"
        //кол-во просмотров
        let viewsCounter = Int.random(in: 0...100)
        cell.viewsCounter.textColor = viewsCounter == 0 ? .lightGray : .systemBlue
        cell.viewsEye.tintColor = viewsCounter == 0 ? .lightGray : .systemBlue
        cell.viewsCounter.text = String(viewsCounter)
        
        return cell
    }
}


