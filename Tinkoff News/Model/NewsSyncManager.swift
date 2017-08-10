//
//  NewsSyncManager.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 07.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData
import UIKit

final class NewsSyncManager {
  typealias Completion = (() -> Void)?

  lazy var persistentContainer = NSPersistentContainer(name: "Tinkoff_News")

  static var shared: NewsSyncManager {
    return (UIApplication.shared.delegate as! AppDelegate).syncManager
  }

  var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }

  init() {
    persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error {
        self.processError(error)
      }
    })
    viewContext.automaticallyMergesChangesFromParent = true
  }

  func sync(_ request: NewsTarget, completion: Completion) {
    Network.fetch(request: request,
                  onCompletion: { data in
                    self.processResponse(data: data, forRequest: request, completion: completion)
    },
                  onError: { error in
                    self.processError(error)
                    completion?()
    })
  }

  private func processResponse(data: Data, forRequest request: NewsTarget, completion: Completion) {
    persistentContainer.performBackgroundTask { context in
      let db = NewsDatabase(context: context)
      do {
        switch request {
        case .pullFeed: try NewsMapper.mapFeed(data: data, db: db)
        case .pullItem: try NewsMapper.mapItem(data: data, db: db)
        }
        try db.saveContext()
      } catch {
        self.processError(error)
      }
      completion?()
    }
  }

  private func processError(_ error: Error) {
    switch error {
    case let error as NetworkError:
      switch error {
      case .invalidResponse(let response): fatalError("Network invalid response error. Response: \(String(describing: response))")
      case .invalidStatusCode(let code): fatalError("Network invalid status code. Code: \(code)")
      case .noData: fatalError("Network no data error.")
      }
    case let error as DataMapperError:
      switch error {
      case .invalidResultCode: fatalError("Data mapper invalid result code")
      case .missingPayload: fatalError("Data mapper missing payload")
      case .invalidPayloadType: fatalError("Data mapper invalid payload type")
      case .corruptedPayload: fatalError("Data mapper corrupted payload")
      }
    case let error as NSError:
      fatalError("NewsSyncManager generic NSError: \(error), \(error.userInfo)")
    default:
      fatalError("NewsSyncManager generic error: \(error)")
    }
  }
}
