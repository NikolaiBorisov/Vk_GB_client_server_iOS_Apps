//
//  NewsTableViewCell.swift
//  Vk black&white
//
//  Created by Macbook on 19.12.2020.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var newsAvatar: RoundingAvatar!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsDateTime: UILabel!
    @IBOutlet weak var newsComment: UILabel!
    @IBOutlet weak var newsImage: RoundingPictures!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var viewsEye: UIButton!
    @IBOutlet weak var viewsCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.setImage(#imageLiteral(resourceName: "11_119290_heart_romance_valentines_day_download_red_heart_clipart"), for: .selected)
        likeButton.setImage(#imageLiteral(resourceName: "2e72b56197ecc776518d48477fd8e494"), for: .normal)
    }
    
    @IBAction func pulsation(_ sender: UIButton) {
        sender.pulsate()
    }
    
    @IBAction func like(_ sender: Any) {
        likeButton.isSelected.toggle()
        likeCounter.textColor = likeButton.isSelected ? .red : .lightGray
        likeCounter.text = likeButton.isSelected ? "1" : "0"
        UIView.animateKeyframes(withDuration: 0.2, delay: 0.2, options: .autoreverse, animations: { self.likeCounter.frame.origin.y += 10 })
        self.likeCounter.frame.origin.y -= 10
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
