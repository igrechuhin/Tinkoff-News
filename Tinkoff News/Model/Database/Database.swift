//
//  Database.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 10.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData

protocol Database {
  associatedtype Item

  var context: NSManagedObjectContext { get }

  init(context: NSManagedObjectContext)

  func saveContext() throws

  func getItem(id: String) throws -> Item
}

extension Database {
  func saveContext() throws {
    if context.hasChanges {
      try context.save()
    }
  }
}
