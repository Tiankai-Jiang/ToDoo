//
//  AddHabitColorCell.swift
//  ToDoo
//
//  Created by tiankai on 2020-01-28.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class AddHabitColorCell: UITableViewCell {

    let colors = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow, UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddHabitColorCell: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ColorCell", for: indexPath) as? ColorCell else{
            return UICollectionViewCell()
        }
        cell.backgroundColor = colors[indexPath.row]
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("123")
    }
}
