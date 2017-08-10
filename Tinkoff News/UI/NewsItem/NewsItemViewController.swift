//
//  NewsItemViewController.swift
//  Tinkoff News
//
//  Created by Ilya Grechuhin on 02.08.17.
//  Copyright © 2017 gr.ia. All rights reserved.
//

import UIKit

final class NewsItemViewController: UIViewController {
  let viewModel: NewsItemViewModelProtocol

  @IBOutlet private weak var webView: UIWebView! {
    didSet {
      webView.scrollView.alwaysBounceVertical = false
    }
  }

  init(viewModel: NewsItemViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)

  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.syncCompletion = { [weak self] in
      DispatchQueue.main.async {
        self?.refresh()
      }
    }
    refresh()
  }

  func refresh() {
    if viewModel.isEmpty {
      title = L("Please select news")
      webView.loadHTMLString("", baseURL: nil)
    } else {
      let item = viewModel.item!
      title = item.id
      webView.loadHTMLString(item.content ?? "", baseURL: nil)
    }
  }
}
