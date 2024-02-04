//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Rohit Kumar on 12/01/2024
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var meAvatar: UIImageView!
    @IBOutlet weak var youAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
