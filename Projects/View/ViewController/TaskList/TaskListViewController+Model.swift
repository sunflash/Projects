//
//  TaskListViewController+Model.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import ReSwift

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task List Group

struct TaskListGroup {

    var groupName: String

    var taskLists: [TaskList]

    init(groupName: String, taskLists: [TaskList]) {
        self.groupName = groupName
        self.taskLists = taskLists
    }
}

extension TaskList: IdentifiableType, Equatable {

    // Identify is uniquely define an object
    public typealias Identity = String
    public var identity: String {
        return id ?? ""
    }
    public static func == (lhs: TaskList, rhs: TaskList) -> Bool {
        return lhs.id == rhs.id && lhs.uncompletedCount == rhs.uncompletedCount
    }
}

extension TaskListGroup: AnimatableSectionModelType {

    // Identify is uniquely define an object
    typealias Identity = String
    var identity: String {
        return groupName
    }
    // Items declare data for section rows
    typealias Item = TaskList
    var items: [TaskList] {
        return taskLists
    }

    init(original: TaskListGroup, items: [TaskList]) {
        self = original
        self.taskLists = items
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Rx Model

extension TaskListViewController {

    func loadModels() {
        searchTextFieldModel()
        tableViewModel()
    }

    private func searchTextFieldModel() {

        let searchModel = SearchModel()

        searchModel.searchTextFieldModel(searchTextField, resetAction: { [weak self] in
            self?.showTaskLists(self?.taskLists)
        }, searchAction: { [weak self] searchText in
            self?.searchTaskList(searchText)
        }, disposeBag: self.disposeBag)
    }

    private func tableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<TaskListGroup> {

        return TableViewModel.tableViewDataSource { (_, tableView, _, item) in

            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? StandardCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "default")
            }

            cell.configure(icon: IconButton.document.rawValue,
                           text: item.name,
                           description: item.description,
                           tags: nil)

            cell.accessoryView = CommonUI.counterLabel(item.uncompletedCount)

            return cell
        }
    }

    private func tableViewModel() {

        let dataSource = tableViewDataSource()
        let displayCell = self.taskListGroupResults.bind(to: self.tableView.rx.items(dataSource: dataSource))
        displayCell.disposed(by: self.disposeBag)

        tableView.rx.modelSelected(TaskList.self).subscribe(onNext: { [weak self] selectedTaskList in
            GCD.main.queue.async {
                self?.tableView.deselectRow()
                store.dispatch(SelectTaskListAction(taskList: selectedTaskList))
                store.dispatch(RoutingAction(storyBoard: .main, destination: .task, transitionStyle: .push))
            }
        }).disposed(by: self.disposeBag)

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Action

extension TaskListViewController {

    private func showTaskLists(_ taskLists: [TaskList]?) {

        GCD.userInitiated.queue.async { [weak self] in

            let updateResults: ([TaskListGroup]) -> Void = { taskListGroups in
                GCD.main.queue.async { [weak self] in
                    self?.taskListGroupResults.onNext(taskListGroups)
                }
            }

            guard let taskLists = taskLists, taskLists.isEmpty == false else {
                updateResults([TaskListGroup]())
                return
            }
            let taskListGroup = TaskListGroup(groupName: "TaskList", taskLists: taskLists)
            updateResults([taskListGroup])
        }
    }

    private func searchTaskList(_ searchText: String) {

        SearchModel.searchItems(searchText: searchText, objects: taskLists, searchParameters: {
            let taskListName = $0.name ?? ""
            let taskListNameSegment = $0.name?.split(by: " ") ?? [String]()
            let descriptionSegment = $0.description?.split(by: " ") ?? [String]()
            let searchParameters: [String] = [taskListName] + taskListNameSegment + descriptionSegment
            return searchParameters
        }, result: { [weak self] in

            self?.showTaskLists($0)
        })
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Data

extension TaskListViewController {

    func getTaskLists(projectId: String) {

        LoadingIndicator.startAnimating(message: NSLocalizedString("GetTaskList", comment: "Task List"))

        _ = ProjectAPI.getTaskLists(projectId: projectId) { [weak self] in

            LoadingIndicator.stopAnimating()

            guard $0.isSuccess == true, let taskLists = $0.object else {
                Message.showErrorMessage(text: NSLocalizedString("GetTaskListFailedMessage", comment: "Status"))
                return
            }

            taskLists.forEach {
                print($0.objectDescription)
            }

            self?.taskLists = taskLists

            if let searchText = self?.searchTextField.text, searchText.isEmpty == false {
                self?.searchTextField.sendActions(for: .valueChanged)
            } else {
                self?.showTaskLists(taskLists)
            }
        }
    }
}
