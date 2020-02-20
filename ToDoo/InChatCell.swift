import UIKit

class InChatCell: UITableViewCell {

    @IBOutlet weak var textBubble: UIView!
    
    private enum Constants {
      static let shadowColor = UIColor(red: 189 / 255, green: 204 / 255, blue: 215 / 255, alpha: 0.54)
      static let shadowRadius: CGFloat = 2
      static let shadowOffset = CGSize(width: 0, height: 1)
      static let chainedMessagesBottomMargin: CGFloat = 20
      static let lastMessageBottomMargin: CGFloat = 32
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textBubble.layer.cornerRadius = 6
        textBubble.backgroundColor = hexStringToUIColor(hex: "EDEDED")
        textBubble.layer.shadowColor = Constants.shadowColor.cgColor
        textBubble.layer.shadowOffset = Constants.shadowOffset
        textBubble.layer.shadowRadius = Constants.shadowRadius
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
