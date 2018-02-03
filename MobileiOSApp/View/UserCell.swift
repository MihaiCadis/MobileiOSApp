//
//  UserCell.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 23/01/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: frame.origin.x + 10 , y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        detailTextLabel?.frame = CGRect(x: frame.origin.x + 10 , y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
