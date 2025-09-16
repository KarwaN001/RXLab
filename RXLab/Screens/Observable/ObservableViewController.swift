//
//  ObservableViewController.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class ObservableViewController: UIViewController {

    private let viewModel = ObservableViewModel()
    private let disposeBag = DisposeBag()
    
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.text = "Press button to see Observable"
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 18)
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let button: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Emit Values", for: .normal)
        btn.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        btn.layer.cornerRadius = 8
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Observable Example"
        
        setupViews()
        bindViewModel()
    }
    
    private func setupViews() {
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        // Bind items emitted from viewModel to label
        viewModel.items
            .scan("") { previous, new in
                previous + " " + new
            }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }
    
    @objc private func buttonTapped() {
        viewModel.fetchItems()
        var random = Int.random(in: 1...100)
        print("buttonTapped  TEST \(random)")
    }
}


// MARK: - SwiftUI Preview

struct ObservableViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ObservableViewController {
        return ObservableViewController()
    }
    
    func updateUIViewController(_ uiViewController: ObservableViewController, context: Context) {
        
    }
}

struct ObservableViewController_Previews: PreviewProvider {
    static var previews: some View {
        ObservableViewControllerRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
