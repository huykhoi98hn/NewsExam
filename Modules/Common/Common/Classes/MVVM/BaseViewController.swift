//
//  BaseViewController.swift
//  Common
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation
import UIKit

public protocol BaseViewController: UIViewController {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel! { get set }
    func setViewModel(_ viewModel: ViewModel)
    func setupViews()
    func bindViewModel()
    func initData()
}

public extension BaseViewController {
    func setViewModel(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
}
