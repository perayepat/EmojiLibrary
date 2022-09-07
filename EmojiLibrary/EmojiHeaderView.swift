//
//  EmojiHeaderView.swift
//  EmojiLibrary
//
//  Created by Pat on 2022/09/07.
//

import UIKit

class EmojiHeaderView: UICollectionReusableView{
    @IBOutlet weak var textLabel: UILabel!
    static let reuseIdentifier = String(describing: EmojiHeaderView.self)
}
