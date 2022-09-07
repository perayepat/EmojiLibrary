
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

}



