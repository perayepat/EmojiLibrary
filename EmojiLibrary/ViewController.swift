///whenever you modify the underlaying data modify the data source first then apply the chagnes to the collection view 


import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = DataSource()
    let delegate = EmojiCollectionViewDelegate(numberOfItemsPerRow: 6, interItemSpacing: 8)
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
      collectionView.dataSource = dataSource
      collectionView.delegate = delegate
      collectionView.allowsMultipleSelection = true
      //Edit button
      navigationItem.leftBarButtonItem = editButtonItem
  }
    
    
    //Setting the editing book from the emoji cell here using this funciton
    override func setEditing(_ editing: Bool, animated: Bool) {
            super.setEditing(editing, animated: animated)
        
        deleteButton.isEnabled = isEditing
        addButton.isEnabled = !isEditing
        
        collectionView.indexPathsForVisibleItems.forEach {
            guard let emojiCell = collectionView.cellForItem(at: $0) as? EmojiCell else {return}
            emojiCell.isEditing = editing
        }
        if !isEditing{
            collectionView.indexPathsForSelectedItems?.compactMap({$0}).forEach{
                //returns an optional array of all the selected items
                collectionView.deselectItem(at: $0 , animated: true)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing && identifier == "showEmojiDetail"{
            return false
        }else{
            return true
        }
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

    
    @IBAction func addEmoji(_ sender: UIBarButtonItem){
        let (category, randomEmoji) = Emoji.randomEmoji()
        dataSource.addEmoji(randomEmoji, to: category)
        //collectionView.reloadData() //expensive for bigger apps
        let emojiCount = collectionView.numberOfItems(inSection: 0)  //count is greater than the last index value
        let insertedIndex = IndexPath(item: emojiCount, section: 0)
        collectionView.insertItems(at: [insertedIndex])
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let selectedIndices = collectionView.indexPathsForSelectedItems else {return}
        let sectionsToDelete = Set(selectedIndices.map({$0.section}))
        sectionsToDelete.forEach { section in
            //reverse the selected item value at a particular section
            let indexPathsForSection = selectedIndices.filter({$0.section == section})
            let sortedIndexPaths = indexPathsForSection.sorted(by: {$0.item > $1.item })
            
            dataSource.deleteEmoji(at: sortedIndexPaths)
            collectionView.deleteItems(at: sortedIndexPaths)
        }
        
        dataSource.deleteEmoji(at: selectedIndices)
        collectionView.deleteItems(at: selectedIndices)
        
        // reverse the index paths
        //reverse the selected item value at a particular section
        let indexPathsToDelete = selectedIndices.map({$0.item}).reversed()
    }
}



