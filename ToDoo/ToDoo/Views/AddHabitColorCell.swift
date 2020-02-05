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
        let nibName = UINib(nibName: "ColorCell", bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: "ColorCell")
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
    }
}
