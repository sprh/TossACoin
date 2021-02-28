//
//  NetworkServiceResult.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

enum NetworkServiceResult<T> {
    case Success(T)
    case Error(Error)
}
