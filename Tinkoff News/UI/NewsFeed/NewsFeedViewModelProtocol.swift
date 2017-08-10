//
//  NewsFeedViewModelProtocol.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData

protocol NewsFeedViewModelProtocol: class {
  var fetchedResultsController: NSFetchedResultsController<DatabaseNewsItem>  { get }

  func refresh(completion: NewsSyncManager.Completion)

  func showItem(atIndexPath indexPath: IndexPath)
}
