//
//  BarChartController.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 23/01/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit



class BarChartController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let values: [CGFloat] = [100,250,150,200,350,400,300,500,450]
    
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView?.backgroundColor =  .white
        collectionView?.register(BarCell.self, forCellWithReuseIdentifier: cellId)

        
    
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return values.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BarCell

        if let max = values.max() {
            let value = values[indexPath.item]
            let ratio = value / max
            cell?.barHeightConstraint?.constant = view.frame.height * ratio
        }

        
        cell?.barHeightConstraint?.constant = values[indexPath.item]
        
        
        
        return cell!
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      return CGSize(width: 30, height: view.frame.height)
       
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
