//
//  SearchModel.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct SearchModel {

    public var minimumSearchWordLength: UInt = 1
    public var throttleTimeInterval = 0.3

    public func searchTextFieldModel(_ searchTextField: UITextField,
                                     resetAction: @escaping () -> Void,
                                     searchAction: @escaping (String) -> Void,
                                     disposeBag: DisposeBag) {

        let searchWord: Driver<String>? = searchTextField.rx.text.orEmpty.asDriver()
            .flatMapLatest {
                let invalidCharacter = CharacterSet.alphanumerics.union(.whitespaces).inverted
                let validInputText = $0.trimmingCharacters(in: invalidCharacter)
                searchTextField.text = validInputText
                let shouldResetToAllData = (validInputText.count < self.minimumSearchWordLength)
                if shouldResetToAllData == true {
                    resetAction()
                }
                return Driver.just(validInputText)
            }
            .distinctUntilChanged()
            .throttle(self.throttleTimeInterval)
            .filter {
                $0.count >= self.minimumSearchWordLength
            }

        searchWord?.drive(onNext: { searchText in
            searchAction(searchText)
        }).disposed(by: disposeBag)
    }

    static func searchItems<T>(searchText: String,
                               objects: [T],
                               searchParameters: @escaping (T) -> [String],
                               result: @escaping ([T]) -> Void) {

        GCD.userInitiated.queue.async {

            let filterObjects = objects.filter {
                let parameters = searchParameters($0).map {$0.lowercased()}
                return (parameters.filter {$0.hasPrefix(searchText.lowercased())}.isEmpty == false)
            }
            result(filterObjects)
        }
    }
}
