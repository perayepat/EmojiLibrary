import UIKit

class EmojiCell: UICollectionViewCell {
  static let reuseIdentifier = String(describing: EmojiCell.self)
    
  @IBOutlet weak var emojiLabel: UILabel!
    
    var isEditing: Bool = false
    
    override var isSelected: Bool{
        // didSet if the cell is in editing mode then switch the background color
        didSet{
            if isEditing{
                contentView.backgroundColor = isSelected ? UIColor.systemRed.withAlphaComponent(0.5) : UIColor.systemGroupedBackground
            }else{
                contentView.backgroundColor = UIColor.systemGroupedBackground
            }
        }
    }
}
