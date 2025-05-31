//
//  WebViewModel.swift
//  Weather(WebKit)
//
//  Created by Владимир Сербин on 31.05.2025.
//

import SwiftUI
import WebKit

class WebViewModel: ObservableObject {
    var webView: WKWebView? // Ссылка на WebView

    @Published var canGoBack = false // Состояние для кнопки "назад"
    @Published var canGoForward = false // Состояние для кнопки "вперёд"

    func goBack() {
        webView?.goBack() // Возврат на предыдущую страницу
    }

    func goForward() {
        webView?.goForward() // Переход вперёд
    }

    func reload() {
        webView?.reload() // Перезагрузка текущей страницы
    }
    
    func goHome() {
        if let homeURL = URL(string: "https://www.meteoblue.com") {
            webView?.load(URLRequest(url: homeURL))
        }
    }

}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // убираем #

        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)

        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255

        self.init(red: r, green: g, blue: b)
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
