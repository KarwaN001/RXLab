//
//  ObserverVC.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import UIKit
import SwiftUI
import RxSwift
import RxCocoa

class ObserverVC: UIViewController {
    
    // MARK: - Properties
    private let viewModel = ObserverVM()
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Observer Pattern Example"
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Count: 0"
        label.font = .systemFont(ofSize: 32, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Status: Even"
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color: Blue"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("-", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    // MARK: - Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Observer Pattern"
        
        view.addSubview(titleLabel)
        view.addSubview(counterLabel)
        view.addSubview(statusLabel)
        view.addSubview(colorLabel)
        view.addSubview(incrementButton)
        view.addSubview(decrementButton)
        view.addSubview(resetButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            counterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            counterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: counterLabel.bottomAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            colorLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
            colorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            incrementButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 40),
            incrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -60),
            incrementButton.widthAnchor.constraint(equalToConstant: 50),
            incrementButton.heightAnchor.constraint(equalToConstant: 50),
            
            decrementButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 40),
            decrementButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 60),
            decrementButton.widthAnchor.constraint(equalToConstant: 50),
            decrementButton.heightAnchor.constraint(equalToConstant: 50),
            
            resetButton.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 30),
            resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalToConstant: 100),
            resetButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Button actions
        incrementButton.addTarget(self, action: #selector(incrementTapped), for: .touchUpInside)
        decrementButton.addTarget(self, action: #selector(decrementTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        // Observer 1: Update counter text
        viewModel.counterText
            .bind(to: counterLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Observer 2: Update even/odd status
        viewModel.isEven
            .map { $0 ? "Status: Even" : "Status: Odd" }
            .bind(to: statusLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Observer 3: Update color based on value
        viewModel.counterColor
            .subscribe(onNext: { [weak self] color in
                self?.colorLabel.text = "Color: \(color)"
                self?.updateCounterColor(color)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helper Methods
    private func updateCounterColor(_ color: String) {
        switch color {
        case "Blue":
            counterLabel.textColor = .systemBlue
        case "Green":
            counterLabel.textColor = .systemGreen
        case "Red":
            counterLabel.textColor = .systemRed
        default:
            counterLabel.textColor = .label
        }
    }
    
    // MARK: - Actions
    @objc private func incrementTapped() {
        viewModel.incrementCounter()
    }
    
    @objc private func decrementTapped() {
        viewModel.decrementCounter()
    }
    
    @objc private func resetTapped() {
        viewModel.resetCounter()
    }
}


// MARK: - SwiftUI Preview

struct ObserverVCRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ObserverVC {
        return ObserverVC()
    }
    
    func updateUIViewController(_ uiViewController: ObserverVC, context: Context) {
        
    }
}

struct ObserverVC_Previews: PreviewProvider {
    static var previews: some View {
        ObserverVCRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
