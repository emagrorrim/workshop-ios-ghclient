//
//  UIImageView+Networking.swift
//  GHClient
//
//  Created by Xin Guo  on 2018/11/12.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
  func loadImage(withURL url: URL) {
    self.af_setImage(withURL: url)
  }
}
