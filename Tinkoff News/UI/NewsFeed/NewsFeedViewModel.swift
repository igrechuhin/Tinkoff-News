//
//  NewsFeedViewModel.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData

final class NewsFeedViewModel: NewsFeedViewModelProtocol {
  typealias ShowItem = (String) -> Void
  let showItem: ShowItem

  let fetchedResultsController: NSFetchedResultsController<DatabaseNewsItem> = {
    let request: NSFetchRequest<DatabaseNewsItem> = DatabaseNewsItem.fetchRequest()
    request.predicate = NSPredicate(value: true)
    request.sortDescriptors = [NSSortDescriptor(key: "publicationDate", ascending: false)]
    request.fetchBatchSize = 20
    request.propertiesToFetch = ["id", "text"]
    return NSFetchedResultsController(fetchRequest: request,
                                      managedObjectContext: NewsSyncManager.shared.viewContext,
                                      sectionNameKeyPath: nil,
                                      cacheName: nil)
  }()

  init(showItem: @escaping ShowItem) {
    self.showItem = showItem
    refresh(completion: nil)
  }

  func refresh(completion: NewsSyncManager.Completion) {
    NewsSyncManager.shared.sync(.pullFeed, completion: completion)
  }

  func showItem(atIndexPath indexPath: IndexPath) {
    showItem(fetchedResultsController.object(at: indexPath).id!)
  }
}
