//
//  TableDataSource.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit

final class TableDataSource<V, T> : NSObject, UITableViewDataSource where V: UITableViewCell {

    typealias CellConfiguration = (V, T) -> V

    let models: [T]?
    private let configureCell: CellConfiguration
    private let cellIdentifier: String

    init(cellIdentifier: String, models: [T]?, configureCell: @escaping CellConfiguration) {
        self.models = models
        self.cellIdentifier = cellIdentifier
        self.configureCell = configureCell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? V

        guard let currentCell = cell else {
            fatalError("Identifier or class not registered with this table view")
        }

        guard models != nil, let model = models?[indexPath.row] else {
            return currentCell
        }
        return configureCell(currentCell, model)
    }
}
