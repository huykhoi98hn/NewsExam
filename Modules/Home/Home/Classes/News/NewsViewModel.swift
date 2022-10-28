//
//  NewsViewModel.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation
import RxSwift
import Network
import Common

public class NewsViewModel: BaseViewModel {
    private let searchText = PublishSubject<String?>()
    private let page = BehaviorSubject<Int>(value: 1)
    private let loadmore = PublishSubject<Void>()
    private let refresh = PublishSubject<Void>()
    private let canLoadmore = BehaviorSubject<Bool>(value: true)
    private let isLoadmore = BehaviorSubject<Bool>(value: false)
    private let showLoading = PublishSubject<Bool>()
    private let newsArray = PublishSubject<([News], Int)>()
    private let onNextDetail = PublishSubject<News>()
    private let pageSize: Int = 20
    private let disposeBag = DisposeBag()
    
    public struct Input {
        var searchText: AnyObserver<String?>
        var loadmore: AnyObserver<Void>
        var refresh: AnyObserver<Void>
        var onNextDetail: AnyObserver<News>
    }
    
    public struct Output {
        var newsArray: Observable<([News], Int)>
        var showLoading: Observable<Bool>
        var onNextDetail: Observable<News>
    }
    
    public var input: Input
    public var output: Output
    
    init() {
        input = Input(
            searchText: searchText.asObserver(),
            loadmore: loadmore.asObserver(),
            refresh: refresh.asObserver(),
            onNextDetail: onNextDetail.asObserver()
        )
        output = Output(
            newsArray: newsArray.asObservable(),
            showLoading: showLoading.asObservable(),
            onNextDetail: onNextDetail.asObservable()
        )
        
        searchText
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.canLoadmore.onNext(true)
                self.isLoadmore.onNext(false)
                self.page.onNext(1)
            }).disposed(by: disposeBag)
        
        page
            .withLatestFrom(searchText) { ($0, $1) }
            .subscribe(onNext: { [weak self] (page, keyword) in
                guard let self = self else {
                    return
                }
                self.requestNews(keyword: keyword, page: page, pageSize: self.pageSize)
        }).disposed(by: disposeBag)
        
        loadmore
            .withLatestFrom(
                Observable.combineLatest(page, isLoadmore, canLoadmore)
            ) { ($0, $1.0, $1.1, $1.2) }
            .subscribe(onNext: { [weak self] (_, page, isLoadmore, canLoadmore) in
                guard let self = self, canLoadmore, !isLoadmore else {
                    return
                }
                self.page.onNext(page + 1)
        }).disposed(by: disposeBag)
        
        refresh.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.canLoadmore.onNext(true)
            self.isLoadmore.onNext(false)
            self.page.onNext(1)
        }).disposed(by: disposeBag)
    }
    
    private func requestNews(keyword: String?, page: Int, pageSize: Int) {
        let request = NewsRequest(keyword: keyword, page: page, pageSize: pageSize)
        isLoadmore.onNext(true)
        showLoading.onNext(page == 1)
        APIService.shared.doRequest(request) { [weak self] (result: Result<NewsResponse, Error>) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let response):
                self.canLoadmore.onNext(response.totalResults >= page * pageSize)
                self.newsArray.onNext((response.articles, page))
            case .failure(let failure):
                self.canLoadmore.onNext(false)
                self.newsArray.onError(failure)
            }
            self.isLoadmore.onNext(false)
            self.showLoading.onNext(false)
        }
    }
}
