//
//  ContentView.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import SwiftUI
import UIKit

struct MainViewHost: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        MainViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        
    }
}

struct ContentView: View {
    var body: some View {
        MainViewHost()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
