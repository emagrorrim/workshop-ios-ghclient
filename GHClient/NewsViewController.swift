//
//  ViewController.swift
//  ghclient-ios
//
//  Created by Xin Guo  on 2018/10/28.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import UIKit

let username = "your_username"
let url = "https://api.github.com/users/\(username)/received_events"

class NewsViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  
  private var events: [Event] = []
  
  private let reuseIdentifier = "NewsTableViewCell"
  private let networkClient: NetworkClient = AlamofireNetworkClient()

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    fetchGithubEvents()
  }

  private func fetchGithubEvents() {
    let header = RequestHeaderBuilder()
      .configure(username: "your_username")
      .configure(password: "your_password")
      .build()
    networkClient.get(url: URL(string: url)!, header: header) { data, error in
      if let error = error {
        // handler error
        print(error)
        return
      }
      
      let decoder = JSONDecoder()
      self.events = (try? decoder.decode([Event].self, from: data!)) ?? []
      self.tableView.reloadData()
    }
  }
}

extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return events.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
      return UITableViewCell()
    }
    cell.configure(with: events[indexPath.row])
    return cell
  }
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 75
  }
}
