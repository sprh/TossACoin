//
//  NewsViewModel.swift
//  TossACoin
//
//  Created by Софья Тимохина on 08.03.2021.
//

import Foundation

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
    
    func getNews(completion: @escaping () -> Void) {
        networkService.getNews(symbol: mintedCoin.coin.name, page: page) { [weak self] result in
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
    
    public func createCell(cell: NewsCollectionViewCell, at indexPath: Int){
        if (articles.count <= indexPath) { return }
        let article = articles[indexPath]
        cell.loadData(article: article)
    }
    
    func getArticlesCount() -> Int {
        return articles.count
    }
}
