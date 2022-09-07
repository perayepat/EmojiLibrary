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
    
    //sections
    //Kind lets you return a header or a footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let emojiHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: EmojiHeaderView.reuseIdentifier, for: indexPath) as? EmojiHeaderView else {
            fatalError("Cannot create EmojiHeaderView")
        }
        let category = emoji.sections[indexPath.section]
        
        emojiHeaderView.textLabel.text = category.rawValue
        return  emojiHeaderView
    }
    
}


extension DataSource{
    func addEmoji(_ emoji: String, to category: Emoji.Category){
        guard var emojiData = self.emoji.data[category] else {return}
        emojiData.append(emoji)
        self.emoji.data.updateValue(emojiData, forKey: category)
    }
    
    func deleteEmoji(at indexPath: IndexPath){
        //using the indexPath to pick the emoji using the section for category
        let category = emoji.sections[indexPath.section]
        guard var emojiData = emoji.data[category] else { return }
        emojiData.remove(at: indexPath.item)
        
        //now we need to update the array
        emoji.data.updateValue(emojiData, forKey: category)
    }
    
    //for multiple index paths to delete several emojis
    func deleteEmoji(at indexPaths: [IndexPath]){
        for path in indexPaths{
            deleteEmoji(at: path)
        }
    }
}
