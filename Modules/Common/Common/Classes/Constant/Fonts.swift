//
//  Fonts.swift
//  Common
//
//  Created by Nguyen Huy Khoi on 28/10/2022.
//

import Foundation
import UIKit

public struct Fonts {
    public static func regular(size: CGFloat) -> UIFont {
        
        return .systemFont(ofSize: size, weight: .regular)
    }
    
    public static func medium(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .medium)
    }
    
    public static func semibold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .semibold)
    }
    
    public static func bold(size: CGFloat) -> UIFont {
        return .systemFont(ofSize: size, weight: .bold)
    }
}
