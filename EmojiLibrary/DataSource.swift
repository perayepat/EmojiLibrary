//
//  DataSource.swift
//  EmojiLibrary
//
//  Created by Pat on 2022/09/07.
//

import UIKit

//Nsobject because the collection view expects a objc object
class DataSource: NSObject, UICollectionViewDataSource {
    let emoji  = Emoji.shared
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        //customise the number of sections using a enum
        emoji.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //specify how many items per sections
        let category  = emoji.sections[section]
        let emoji = self.emoji.data[category]?.count ?? 0
        return emoji
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Dequeue and configure cell
        guard let emojiCell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCell.reuseIdentifier, for: indexPath) as? EmojiCell else{
            fatalError("Cell cannot be created")
        }
        
        let category = emoji.sections[indexPath.section]
        let emoji = self.emoji.data[category]?[indexPath.item] ?? ""
        
        emojiCell.emojiLabel.text = emoji
        
        return emojiCell
    }
    
}
