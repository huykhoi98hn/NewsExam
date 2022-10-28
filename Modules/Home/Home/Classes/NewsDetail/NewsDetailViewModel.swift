//
//  DetailViewModel.swift
//  Home
//
//  Created by Savvycom2021 on 16/08/2022.
//

import Foundation
import Common
import RxSwift

class NewsDetailViewModel: BaseViewModel {
    public struct Input {}
    
    public struct Output {
        var newsData: Observable<News>
    }
    
    public var input: Input
    public var output: Output
    
    private let newsData: BehaviorSubject<News>
    
    init(news: News) {
        newsData = BehaviorSubject(value: news)
        
        input = Input()
        output = Output(newsData: newsData.asObservable())
    }
}
