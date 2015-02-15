//
//  TweetCell.swift
//  CakeBird
//
//  Created by Rhett Rogers on 8/23/14.
//  Copyright (c) 2014 Lyokotech. All rights reserved.
//

import Foundation
import UIKit

class TweetCell : UICollectionViewCell {

  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)    
  }
  @IBOutlet weak var avatarImage: UIImageView!
  @IBOutlet weak var text: UILabel!
  
  @IBOutlet weak var replyCountLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!

  @IBOutlet weak var favoriteCountLabel: UILabel!

  @IBOutlet weak var realNameLabel: UILabel!

  @IBOutlet weak var screenNameLabel: UILabel!
  @IBOutlet weak var authorAvatarView: UIImageView!
  
  
}