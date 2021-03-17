//
//  NewsViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation
import UIKit

class NewsViewModel {
    let mintedCoin: MintedCoin
    let enviroment: Enviroment
    let networkService: NetworkService
    private var page: Int = 1
    private var articles: [Article] = []
    
    init(mintedCoin: MintedCoin, enviroment: Enviroment, networkService: NetworkService) {
        self.mintedCoin = mintedCoin
        self.enviroment = enviroment
        self.networkService = networkService
    }
    
    // Получение новостей.
    func getNews(completion: @escaping () -> Void) {
        networkService.getNews(symbol: mintedCoin.coin.name) { [weak self] result in
            guard let `self` = self else { return }

            switch result {
            case .Success(let news):
                guard news.news.count > 0 else {
                    return completion()
                }
                
                news.news.forEach{ self.articles.append($0) }
                self.page += 1
                completion()
            case .Error:
                print("Error")
            }
        }
    }
    
    // Создание ячейки под новость.
    public func createCell(cell: NewsCollectionViewCell, at indexPath: Int){
        if (articles.count <= indexPath) { return }
        let article = articles[indexPath]
        cell.loadData(title: article.title, imageUrl: article.imageUrl)
        cell.backgroundColor = indexPath % 2 == 0 ? UIColor(named: "evenCellColorColor") : UIColor(named: "backgroundColor")
    }
    
    // Количество новостей.
    func getArticlesCount() -> Int {
        return articles.count
    }
    
    // Открытие новости.
    func openArticle(at indexPath: Int) {
        guard let url = URL(string: articles[indexPath].url) else {
            return
        }
        // Открытие ссылки.
        UIApplication.shared.open(url)
    }
}
