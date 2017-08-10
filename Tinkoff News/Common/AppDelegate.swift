//
//  AppDelegate.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import CoreData
import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  let syncManager = NewsSyncManager()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    Coordinator.instance.start(window: window!)

    return true
  }
}

