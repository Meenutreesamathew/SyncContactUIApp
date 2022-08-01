//
//  ContactTableViewCell.swift
//  SyncContactUIApp
//
//  Created by SANISH PAUL on 01/08/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var phoneOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
