//
//  HomeCoordinator.swift
//  Home
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation

public class HomeCoordinator {
    var navigationController: UINavigationController
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func start() {
        let newsViewController = NewsViewController()
        navigationController.pushViewController(newsViewController, animated: false)
    }
}
