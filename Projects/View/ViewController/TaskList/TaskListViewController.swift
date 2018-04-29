//
//  TaskListViewController.swift
//  Projects
//
//  Created by Min Wu on 24/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task List View Controller

class TaskListViewController: UIViewController, UITableViewDelegate, SearchTableView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "cell"
    var shouldUpdateTaskList = false

    var taskLists = [TaskList]()
    private(set) var taskListGroupResults = PublishSubject<[TaskListGroup]>()
    private(set) var disposeBag = DisposeBag()

    //-------------------------------------------------------------------------------------------------------------
    // MARK: - View

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.invisible(true)
        configureView()
        loadModels()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldUpdateTaskList = true
        store.dispatch(RoutingAction(storyBoard: .main, destination: .taskList, transitionStyle: .none))
        store.subscribe(self) {
            $0.select {
                $0.projectState
            }
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        store.unsubscribe(self)
    }

    //-------------------------------------------------------------------------------------------------------------
    // MARK: - Setup

    private func configureView() {
        configureSearchTextField()
        configureViews()
        self.title = NSLocalizedString("TaskListScreenTitle", comment: "Task List")
    }

    private func configureSearchTextField() {
        let placeholderName = NSLocalizedString("SearchTaskListTextFieldPlaceholder", comment: "Task List")
        CommonUI.configureSearchTextField(searchTextField, placeholder: placeholderName)
    }
}
