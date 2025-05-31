//
//  WebViewContainer.swift
//  Weather(WebKit)
//
//  Created by Владимир Сербин on 31.05.2025.
//

import SwiftUI
import WebKit

// Обёртка над WebView с передачей модели
struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var webViewModel: WebViewModel

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webViewModel.webView = webView

        // Добавляем pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.backgroundColor = hexStringToUIColor(hex: "124673")
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh(_:)), for: .valueChanged)
        
        webView.scrollView.refreshControl = refreshControl

        if let url = URL(string: "https://www.meteoblue.com") {
            webView.load(URLRequest(url: url))
        }
        

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(webViewModel: webViewModel)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var webViewModel: WebViewModel

        init(webViewModel: WebViewModel) {
            self.webViewModel = webViewModel
        }

        // Завершаем refresh после загрузки
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webViewModel.canGoBack = webView.canGoBack
            webViewModel.canGoForward = webView.canGoForward
            webView.scrollView.refreshControl?.endRefreshing()
        }

        // Метод при pull-to-refresh
        @objc func handleRefresh(_ sender: UIRefreshControl) {
            webViewModel.reload()
        }
    }
}
