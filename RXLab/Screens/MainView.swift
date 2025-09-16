//
//  MainView.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import UIKit

class MainViewController: UIViewController {

    // ScrollView to handle all buttons if they exceed screen height
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    // RxSwift concepts
    private let concepts = [
        "Observable", "Observer", "Disposable", "Subjects",
        "Relays (RxCocoa)", "Special Observable Types", "Transformation Operators",
        "Filtering Operators", "Combining Operators", "Error Handling",
        "Schedulers", "DelegateProxy (RxCocoa)", "Binder (RxCocoa)", "RxTest"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "RxLab Main"
        
        setupScrollView()
        setupStackView()
        setupButtons()
    }
    
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40) // padding
        ])
    }
    
    private func setupButtons() {
        for concept in concepts {
            let button = UIButton(type: .system)
            button.setTitle(concept, for: .normal)
            button.titleLabel?.font = .boldSystemFont(ofSize: 18)
            button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.1)
            button.layer.cornerRadius = 8
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            
            // Currently no functionality
            // button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
    }
    
    // Placeholder for future button action
    @objc private func buttonTapped(_ sender: UIButton) {
        print("Button tapped: \(sender.currentTitle ?? "")")
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        
    }
}

struct MainViewController_Previews: PreviewProvider {
    static var previews: some View {
        MainViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
#endif
