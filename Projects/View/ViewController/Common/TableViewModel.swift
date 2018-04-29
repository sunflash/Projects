//
//  TableViewModel.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

struct TableViewModel {

    // swiftlint:disable:next line_length
    static func tableViewDataSource<T: AnimatableSectionModelType>(configureCell: @escaping TableViewSectionedDataSource<T>.ConfigureCell) -> RxTableViewSectionedAnimatedDataSource<T> {

        let animationConfiguration = AnimationConfiguration(insertAnimation: .fade,
                                                            reloadAnimation: .none,
                                                            deleteAnimation: .fade)

        return RxTableViewSectionedAnimatedDataSource<T>(
            animationConfiguration: animationConfiguration,
            configureCell: configureCell)
    }
}
