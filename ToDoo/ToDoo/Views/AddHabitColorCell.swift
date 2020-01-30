//
//  AddHabitColorCell.swift
//  ToDoo
//
//  Created by tiankai on 2020-01-28.
//  Copyright © 2020 tiankai. All rights reserved.
//

import UIKit

class AddHabitColorCell: UITableViewCell {
    
    var selectedColor = K.defaultColor
    
    let colors = ["9DF3C4","62D2A2","1FAB89", "C6F1E7", "70ACB1", "59606D", "FFFE9F", "FFD480", "FCA180", "F56262"]
    
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.colorCell, for: indexPath) as? ColorCell else{
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 25
        cell.backgroundColor = hexStringToUIColor(hex: colors[indexPath.row])
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = colors[indexPath.row]
        viewController(forView: self)?.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: colors[indexPath.row])
//        self.tableView
//        print(selectedColor)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        var view = superview
        while let v = view, v.isKind(of: UITableView.self) == false {
            view = v.superview
        }
        return view as? UITableView
    }
}


func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func viewController(forView: UIView) -> UIViewController? {
    var nr = forView.next
    while nr != nil && !(nr! is UIViewController) {
        nr = nr!.next
    }
    return nr as? UIViewController
}
