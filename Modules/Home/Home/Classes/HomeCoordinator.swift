//
//  HomeCoordinator.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation
import Common

public class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let newsViewController = NewsViewController()
        let viewModel = NewsViewModel()
        newsViewController.setViewModel(viewModel)
        navigationController.pushViewController(newsViewController, animated: false)
    }
}
