import UIKit

class AddHabitColorCell: UITableViewCell {
    
    var selectedColor = K.defaultColor
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let nibName = UINib(nibName: K.Cells.colorXib, bundle:nil)
        collectionView.register(nibName, forCellWithReuseIdentifier: K.Cells.colorCell)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension AddHabitColorCell: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return K.colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cells.colorCell, for: indexPath) as? ColorCell else{
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 25
        cell.backgroundColor = hexStringToUIColor(hex: Array(K.colors.keys)[indexPath.row])
        
        cell.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedColor = Array(K.colors.keys)[indexPath.row]
        viewController(forView: self)?.navigationController?.navigationBar.barTintColor = hexStringToUIColor(hex: Array(K.colors.keys)[indexPath.row])
        viewController(forView: self)?.navigationController?.navigationBar.tintColor = hexStringToUIColor(hex: Array(K.colors.values)[indexPath.row])
        (viewController(forView: self) as! AddHabitViewController).inputColor = selectedColor
    }
}
