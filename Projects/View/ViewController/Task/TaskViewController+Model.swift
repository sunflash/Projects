//
//  TaskViewController+Model.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import ReSwift

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task Group

struct TaskGroup {

    var groupName: String

    var tasks: [TaskItem]

    init(groupName: String, tasks: [TaskItem]) {
        self.groupName = groupName
        self.tasks = tasks
    }
}

extension TaskItem: IdentifiableType, Equatable {

    // Identify is uniquely define an object
    public typealias Identity = Int64
    public var identity: Int64 {
        return id ?? -1
    }
    public static func == (lhs: TaskItem, rhs: TaskItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TaskGroup: AnimatableSectionModelType {

    // Identify is uniquely define an object
    typealias Identity = String
    var identity: String {
        return groupName
    }
    // Items declare data for section rows
    typealias Item = TaskItem
    var items: [TaskItem] {
        return tasks
    }

    init(original: TaskGroup, items: [TaskItem]) {
        self = original
        self.tasks = items
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Rx Model

extension TaskViewController {

    func loadModels() {
        searchTextFieldModel()
        tableViewModel()
    }

    private func searchTextFieldModel() {

        let searchModel = SearchModel()

        searchModel.searchTextFieldModel(searchTextField, resetAction: { [weak self] in
            self?.showTasks(self?.tasks)
        }, searchAction: { [weak self] searchText in
            self?.searchTask(searchText)
        }, disposeBag: self.disposeBag)
    }

    private func tableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<TaskGroup> {

        return TableViewModel.tableViewDataSource { [weak self] (_, tableView, _, item) in

            guard let cellIdentifier = self?.cellIdentifier,
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? StandardCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "default")
            }

            self?.configureCell(cell, completed: item.completed, item: item)

            cell.tapIconAction = { [weak self] in

                guard let taskId = item.id else {return}

                let resultAction: (Bool, HTTPResults<String>) -> Void = { [weak self] (completed, result) in

                    let isSuccess = (result.isSuccess == true && result.object == "OK")
                    let status = isSuccess ? completed : !completed
                    self?.configureCell(cell, completed: status, item: item)
                }

                if cell.status == CompleteStatus.completed.rawValue {
                    // Mark task as uncomplete with local update (fast)
                    self?.configureCell(cell, completed: false, item: item)
                    // Update task as uncomplete in remote server (slow)
                    _ = ProjectAPI.uncompleteTask(taskId: taskId) {
                        resultAction(false, $0)
                    }

                } else if cell.status == CompleteStatus.uncompleted.rawValue {
                    // Mark task as completed with local update (fast)
                    self?.configureCell(cell, completed: true, item: item)
                     // Update task as complete in remote server (slow)
                    _ = ProjectAPI.completeTask(taskId: taskId) {
                        resultAction(true, $0)
                    }
                }
            }
            return cell
        }
    }

    private func tableViewModel() {

        let dataSource = tableViewDataSource()
        let displayCell = self.taskGroupResults.bind(to: self.tableView.rx.items(dataSource: dataSource))
        displayCell.disposed(by: self.disposeBag)

        tableView.rx.modelSelected(TaskItem.self).subscribe(onNext: { [weak self] _ in
            GCD.main.queue.async {
                self?.tableView.deselectRow()
            }
        }).disposed(by: self.disposeBag)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Action

extension TaskViewController {

    private func showTasks(_ tasks: [TaskItem]?) {

        GCD.userInitiated.queue.async { [weak self] in

            let updateResults: ([TaskGroup]) -> Void = { taskGroups in
                GCD.main.queue.async { [weak self] in
                    self?.taskGroupResults.onNext(taskGroups)
                }
            }

            guard let tasks = tasks, tasks.isEmpty == false else {
                updateResults([TaskGroup]())
                return
            }
            let taskGroup = TaskGroup(groupName: "Task", tasks: tasks)
            updateResults([taskGroup])
        }
    }

    private func searchTask(_ searchText: String) {

        SearchModel.searchItems(searchText: searchText, objects: tasks, searchParameters: {
            let content = $0.content ?? ""
            let contentSegment = $0.content?.split(by: " ") ?? [String]()
            let descriptionSegment = $0.description?.split(by: " ") ?? [String]()
            let tagNames = $0.tags?.compactMap {$0.name} ?? [String]()
            let tagSegment = tagNames.compactMap {$0.split(by: " ")}.flatMap {$0}
            let searchParameters: [String] = [content] + contentSegment + descriptionSegment + tagNames + tagSegment
            return searchParameters
        }, result: { [weak self] in

            self?.showTasks($0)
        })
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Data

extension TaskViewController {

    func getTasks(taskListId: String) {

        LoadingIndicator.startAnimating(message: NSLocalizedString("GetTask", comment: "Task"))

        _ = ProjectAPI.getTasks(taskListId: taskListId) { [weak self] in

            LoadingIndicator.stopAnimating()

            guard $0.isSuccess == true, let tasks = $0.object else {
                Message.showErrorMessage(text: NSLocalizedString("GetTaskFailedMessage", comment: "Status"))
                return
            }

            for (index, task) in tasks.enumerated() {
                if index == 3 {break}
                print(task.objectDescription)
            }

            self?.tasks = tasks

            if let searchText = self?.searchTextField.text, searchText.isEmpty == false {
                self?.searchTextField.sendActions(for: .valueChanged)
            } else {
                self?.showTasks(tasks)
            }
        }
    }
}
