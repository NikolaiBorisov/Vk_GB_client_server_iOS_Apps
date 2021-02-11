//
//  DateTime.swift
//  Vk black&white
//
//  Created by Macbook on 21.12.2020.
//

import UIKit
//Random date and time for news section
func getDateAndTime() -> String {
    let date: Date = Date() - TimeInterval(Int.random(in: 0...10000000))
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_Ru")
    //dateFormatter.dateFormat = "d MMMM yyyy d HH:mm"
    dateFormatter.dateFormat = "d MMM yy HH:mm"
    let postDate = String(dateFormatter.string(from: date))
    return postDate
}
