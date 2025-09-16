//
//  ObservableViewModel.swift
//  RXLab
//
//  Created by karwan Syborg on 16/09/2025.
//

import RxSwift
import RxCocoa

class ObservableViewModel {

    // Dispose bag for memory management
    let disposeBag = DisposeBag()
    
    // Output: Observable of strings
    let items = PublishSubject<String>()
    
    // Function to simulate emitting values
    func fetchItems() {
        let numbers = Observable.of("One", "Two", "Three")
        
        numbers.subscribe(onNext: { [weak self] value in
                self?.items.onNext(value)
            })
            .disposed(by: disposeBag)
    }
}
