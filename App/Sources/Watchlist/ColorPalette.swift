//
//  ColorPalette.swift
//  
//
//  Created by Adrian Chmura on 26/09/2023.
//

import Foundation
import UIKit

public protocol ColorPalette {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
}

struct DefaultPalette: ColorPalette {
    var backgroundColor: UIColor { return UIColor.white }
    var textColor: UIColor { return UIColor.black }
}

struct DarkModePalette: ColorPalette {
    var backgroundColor: UIColor { return UIColor.black }
    var textColor: UIColor { return UIColor.white }
}

public class ColorPaletteManager {
    public static let shared = ColorPaletteManager()

    public var currentPalette: ColorPalette

    private init() {
        currentPalette = DefaultPalette()
    }

    public func switchToDarkMode() {
        currentPalette = DarkModePalette()
    }

    public func switchToDefault() {
        currentPalette = DefaultPalette()
    }
}
