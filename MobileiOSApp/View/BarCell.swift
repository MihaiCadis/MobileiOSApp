//
//  BarCell.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 23/01/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit

class BarCell: UICollectionViewCell {
    
    
    let barView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var barHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(barView)
        
        
        barHeightConstraint = barView.heightAnchor.constraint(equalToConstant: 300)
        barHeightConstraint?.isActive = true
        barView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        barView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        barView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
