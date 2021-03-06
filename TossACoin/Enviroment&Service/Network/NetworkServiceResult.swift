//
//  NetworkServiceResult.swift
//  TossACoin
//
//  Created by Софья Тимохина on 27.02.2021.
//

import Foundation

// MARK: - Результат подключения.
enum NetworkServiceResult<T> {
    case Success(T)
    case Error(Error)
}
