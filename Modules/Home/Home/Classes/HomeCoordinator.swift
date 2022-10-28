//
//  HomeCoordinator.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation
import Common
import RxSwift

public class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var disposeBag = DisposeBag()
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let newsViewController = NewsViewController()
        let viewModel = NewsViewModel()
        newsViewController.setViewModel(viewModel)
        viewModel.output.onNextDetail.subscribe(onNext: { [weak self] news in
            self?.pushDetailNews(news)
        }).disposed(by: disposeBag)
        navigationController.pushViewController(newsViewController, animated: false)
    }
    
    private func pushDetailNews(_ news: News) {
        let newsDetailViewController = NewsDetailViewController()
        let viewModel = NewsDetailViewModel(news: news)
        newsDetailViewController.setViewModel(viewModel)
        navigationController.pushViewController(newsDetailViewController, animated: true)
    }
}
