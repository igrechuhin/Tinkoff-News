//
//  NewsItemViewModel.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 10.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import Foundation

final class NewsItemViewModel: NewsItemViewModelProtocol {
  private let itemID: String?

  var isEmpty: Bool { return itemID == nil }

  var syncCompletion: NewsSyncManager.Completion {
    didSet {
      if let item = item, item.content == nil {
        NewsSyncManager.shared.sync(.pullItem(id: itemID!), completion: { [weak self] in
          self?.syncCompletion?()
        })
      }
    }
  }

  var item: DatabaseNewsItem? {
    if let itemID = itemID {
      return try? NewsDatabase(context: NewsSyncManager.shared.viewContext).getItem(id: itemID)
    } else {
      return nil
    }
  }

  init(itemID: String?) {
    self.itemID = itemID
  }
}
