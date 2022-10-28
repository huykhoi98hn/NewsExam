//
//  BaseViewModel.swift
//  Common
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation

public protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    var input: Input { get set }
    var output: Output { get set }
}
