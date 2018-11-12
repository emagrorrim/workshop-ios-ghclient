//
//  NewsTableViewCell.swift
//  GHClient
//
//  Created by Xin Guo  on 2018/11/1.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  @IBOutlet weak var typeImageView: UIImageView!
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var contentLabel: UILabel!
  
  func configure(with event: Event) {
    let viewModel = NewsTableViewCellViewModel(event: event)
    typeImageView.image = viewModel.typeIconImage
    timeLabel.text = viewModel.time
    contentLabel.attributedText = viewModel.description
    if let avatorURL = viewModel.avatorURL {
      avatarImageView.loadImage(withURL: avatorURL)
    }
  }
}
