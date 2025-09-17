//
//  ObserverVM.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import Foundation
import RxSwift
import RxCocoa

class ObserverVM {
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // Subject that emits counter value changes
    private let counterSubject = BehaviorSubject<Int>(value: 0)
    
    // MARK: - Public Observables (for View to observe)
    var counterValue: Observable<Int> {
        return counterSubject.asObservable()
    }
    
    var counterText: Observable<String> {
        return counterValue.map { "Count: \($0)" }
    }
    
    var isEven: Observable<Bool> {
        return counterValue.map { $0 % 2 == 0 }
    }
    
    var counterColor: Observable<String> {
        return counterValue.map { value in
            switch value {
            case 0...5:
                return "Blue"
            case 6...10:
                return "Green"
            default:
                return "Red"
            }
        }
    }
    
    // MARK: - Actions
    func incrementCounter() {
        let currentValue = (try? counterSubject.value()) ?? 0
        counterSubject.onNext(currentValue + 1)
    }
    
    func decrementCounter() {
        let currentValue = (try? counterSubject.value()) ?? 0
        counterSubject.onNext(max(0, currentValue - 1))
    }
    
    func resetCounter() {
        counterSubject.onNext(0)
    }
}
