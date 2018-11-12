//
//  File.swift
//  GHClient
//
//  Created by Xin Guo  on 2018/11/6.
//  Copyright © 2018 com.thoughtworks.workshop. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkClient {
  func get(url: URL, header: [String: String]?, completion: @escaping (Data?, Error?) -> Void)
}

class AlamofireNetworkClient: NetworkClient {
  func get(url: URL, header: [String: String]?, completion: @escaping (Data?, Error?) -> Void) {
    Alamofire.request(url, method: .get, parameters: nil, headers: header).validate().response { dataResponse in
      if let error = dataResponse.error {
        completion(nil, error)
        return
      }
      completion(dataResponse.data, nil)
    }
  }
}
