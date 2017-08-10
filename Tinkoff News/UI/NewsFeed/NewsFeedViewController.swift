//
//  NewsFeedViewController.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

final class NewsFeedViewController: CoreDataTableViewController {
  private let viewModel: NewsFeedViewModelProtocol

  init(viewModel: NewsFeedViewModelProtocol) {
    self.viewModel = viewModel
    super.init(style: .plain)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupTableView()
    setupRefreshControl()

    title = L("News Feed")
    fetchedResultsController = viewModel.fetchedResultsController
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }

  private func setupTableView() {
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableViewAutomaticDimension

    tableView.registerNib(cellClass: NewsFeedCell.self)
  }

  private func setupRefreshControl() {
    refreshControl = UIRefreshControl()
    refreshControl!.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
  }

  @objc
  private func refreshAction() {
    viewModel.refresh { [weak self] in
      DispatchQueue.main.async {
        self?.refreshControl?.endRefreshing()
      }
    }
  }

  //MARK: - UITableViewDataSource
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(cellClass: NewsFeedCell.self, indexPath: indexPath)
    cell.model = viewModel.fetchedResultsController.object(at: indexPath)
    return cell
  }

  //MARK: - UITableViewDelegate
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.showItem(atIndexPath: indexPath)
  }
}
