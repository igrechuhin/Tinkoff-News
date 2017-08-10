//
//  CoreDataTableViewController.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 09.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData
import UIKit

class CoreDataTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  var fetchedResultsController: NSFetchedResultsController<DatabaseNewsItem>? {
    didSet {
      guard let fetchedResultsController = fetchedResultsController else { return }
      fetchedResultsController.delegate = self
      try! fetchedResultsController.performFetch()
    }
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return fetchedResultsController?.sections?.count ?? 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let sections = fetchedResultsController?.sections, sections.count > section {
      return sections[section].numberOfObjects
    } else {
      return 0
    }
  }

  //MARK: - NSFetchedResultsControllerDelegate
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
    case .update:
      tableView.reloadRows(at: [indexPath!], with: .automatic)
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    }
  }

  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    switch type {
    case .insert: tableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
    case .delete: tableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
    default: break
    }
  }

  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
}
