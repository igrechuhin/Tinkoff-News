//
//  NewsFeedCell.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 03.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

final class NewsFeedCell: UITableViewCell {
  @IBOutlet private weak var label: UILabel!

  var model: DatabaseNewsItem! {
    didSet {
      label.text = model.text?.decodingHTML()
    }
  }
}
