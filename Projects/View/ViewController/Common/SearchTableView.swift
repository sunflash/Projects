//
//  SearchTableView.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable implicitly_unwrapped_optional

protocol SearchTableView {

    var cellIdentifier: String {get}

    var contentView: UIView! {get set}

    var searchView: UIView! {get set}

    var tableView: UITableView! {get set}
}

extension SearchTableView {

    func configureViews() {

        self.contentView.backgroundColor = ColourPaletteSecondary.gray
        self.searchView.backgroundColor = ColourPalettePrimary.darkBlue

        let nib = UINib(nibName: "StandardCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        self.tableView.layer.cornerRadius = 5
    }
}
