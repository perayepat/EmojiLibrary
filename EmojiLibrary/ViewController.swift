
import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = DataSource()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
      collectionView.dataSource = dataSource
  }

}



