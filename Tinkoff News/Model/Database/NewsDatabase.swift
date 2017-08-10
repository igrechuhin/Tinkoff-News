//
//  NewsDatabase.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 08.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData

final class NewsDatabase: Database {
  typealias Item = DatabaseNewsItem

  let context: NSManagedObjectContext

  init(context: NSManagedObjectContext) {
    self.context = context
  }

  func getItem(id: String) throws -> Item {
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "id = %@", id)
    return try context.fetch(fetchRequest).first ?? Item(context: context)
  }
}
