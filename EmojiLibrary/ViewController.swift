
import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
      collectionView.dataSource = dataSource
      collectionView.delegate = delegate
  }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "showEmojiDetail",
        let emojiCell = sender as? EmojiCell,
        let emojiDetailController = segue.destination as? EmojiDetailController,
        let indexPath = collectionView.indexPath(for: emojiCell),
        let emoji = Emoji.shared.emoji(at: indexPath) else {
            fatalError("Could not show detail")
        }
        //get data from the view and pass it over
        //using the indexpath to get the data out of the emojie to the detail controller
        emojiDetailController.emoji = emoji
    }

}



