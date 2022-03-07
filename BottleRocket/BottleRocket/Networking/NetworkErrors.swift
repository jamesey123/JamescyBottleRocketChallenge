//
//  NetworkErrors.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case other(Error)
}
