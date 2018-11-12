//
//  File.swift
//  GHClient
//
//  Created by Xin Guo  on 2018/11/5.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import Foundation

class RequestHeaderBuilder {
  private var username: String?
  private var password: String?
  
  func configure(username: String) -> RequestHeaderBuilder {
    self.username = username
    return self
  }
  
  func configure(password: String) -> RequestHeaderBuilder {
    self.password = password
    return self
  }
  
  func build() -> [String: String] {
    var headers = [String: String]()
    guard let username = username, !username.isEmpty,
          let password = password, !password.isEmpty,
          let encodedAuthentication = base64Encode(emailOrUsername: username, password: password) else {
      return headers
    }
    headers["Authorization"] = "Basic \(encodedAuthentication)"
    return headers
  }
  
  private func base64Encode(emailOrUsername: String, password: String) -> String? {
    let credentialsData = "\(emailOrUsername):\(password)".data(using: .utf8)
    let base64Credentials = credentialsData?.base64EncodedString()
    return base64Credentials
  }
}
