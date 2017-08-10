//
//  Coordinator.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

final class Coordinator: UISplitViewControllerDelegate {
  static let instance = Coordinator()

  private let splitController = UISplitViewController()
  private let masterNavigationController = UINavigationController()
  private let detailNavigationController = UINavigationController()

  private init() {
    splitController.viewControllers = [masterNavigationController, detailNavigationController]
    splitController.delegate = self
  }
  private func showFeed() {
    let newsFeedViewModel = NewsFeedViewModel(showItem: showNewsItem)

    let newsFeedViewController = NewsFeedViewController(viewModel: newsFeedViewModel)
    masterNavigationController.setViewControllers([newsFeedViewController], animated: true)
  }

  private func showNewsItem(itemID: String?) {
    let newsItemViewModel = NewsItemViewModel(itemID: itemID)

    let itemViewController = NewsItemViewController(viewModel: newsItemViewModel)
    let animated = alternative(iPhone: true, iPad: false)
    detailNavigationController.setViewControllers([itemViewController], animated: animated)
    splitController.showDetailViewController(detailNavigationController, sender: nil)
  }

  private func setup(window: UIWindow) {
    window.rootViewController = splitController
    window.makeKeyAndVisible()
  }

  func start(window: UIWindow) {
    showNewsItem(itemID: nil)
    showFeed()
    setup(window: window)
  }

  //MARK: - UISplitViewControllerDelegate
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    let itemViewController = detailNavigationController.viewControllers.first as! NewsItemViewController
    return itemViewController.viewModel.isEmpty
  }
}
