//
//  File.swift
//  Vk black&white
//
//  Created by Macbook on 19.12.2020.
//

import UIKit

struct News {
    var newsAvatar: UIImage?
    var newsNameLabel: String
    var newsDataLabel: Date?
    var newsCommentLabel: String
    var newsImage: UIImage?
}

final class NewsFactory {
    static func makeNews() -> [News] {
        
        let news1 = News(newsAvatar: UIImage(named: "Neo"), newsNameLabel: "Mr. Anderson", newsDataLabel: nil, newsCommentLabel: "⚡️Breaking news⚡️ Neo is visiting Oracle! Lets wait for the Oracle's prophecy", newsImage: UIImage(named: "NO"))
        
        let news2 = News(newsAvatar: UIImage(named: "AgentSmith"), newsNameLabel: "Agent Smith", newsDataLabel: nil, newsCommentLabel: "⚡️Breaking news⚡️ Agent Smith hacked the Matrix code and spreading everywhere like a virus!", newsImage: UIImage(named: "SM"))
        return [news1, news2]
    }
}
