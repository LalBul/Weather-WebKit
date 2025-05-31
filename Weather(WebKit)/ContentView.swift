//
//  ContentView.swift
//  Weather(WebKit)
//
//  Created by Владимир Сербин on 31.05.2025.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject private var webViewModel = WebViewModel()

    func customButton(systemName: String, action: @escaping () -> Void, disabled: Bool = false) -> some View {
        Button(action: action) {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 38, height: 38)
                .clipShape(Circle())
                .opacity(disabled ? 0.5 : 1)
                .scaleEffect(disabled ? 1.0 : 1.05)
                .animation(.spring(), value: disabled)
        }
        .disabled(disabled)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // SafeArea background
                Color(hex: "#124673")
                    .frame(height: geometry.safeAreaInsets.top)
                    .edgesIgnoringSafeArea(.top)

                WebViewContainer(webViewModel: webViewModel)
                    .edgesIgnoringSafeArea(.bottom)

                Divider()

                HStack {
                    customButton(systemName: "chevron.backward", action: {
                        webViewModel.goBack()
                    }, disabled: !webViewModel.canGoBack)

                    Spacer()

                    customButton(systemName: "house", action: {
                        webViewModel.goHome()
                    })

                    Spacer()

                    customButton(systemName: "arrow.clockwise", action: {
                        webViewModel.reload()
                    })

                    Spacer()

                    customButton(systemName: "chevron.forward", action: {
                        webViewModel.goForward()
                    }, disabled: !webViewModel.canGoForward)
                }
                .padding()
                .background(Color(hex: "#124673"))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}


