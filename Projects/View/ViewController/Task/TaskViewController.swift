//
//  TaskViewController.swift
//  Projects
//
//  Created by Min Wu on 28/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

//-------------------------------------------------------------------------------------------------------------
// MARK: - Task View Controller

class TaskViewController: UIViewController, UITableViewDelegate, SearchTableView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let cellIdentifier = "cell"
    var shouldUpdateTask = false

    var tasks = [TaskItem]()
    private(set) var taskGroupResults = PublishSubject<[TaskGroup]>()
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
        shouldUpdateTask = true
        store.dispatch(RoutingAction(storyBoard: .main, destination: .task, transitionStyle: .none))
        store.subscribe(self) {
            $0.select {
                $0.taskListState
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
        self.title = NSLocalizedString("TaskScreenTitle", comment: "Task")
    }

    private func configureSearchTextField() {
        let placeholderName = NSLocalizedString("SearchTaskTextFieldPlaceholder", comment: "Task")
        CommonUI.configureSearchTextField(searchTextField, placeholder: placeholderName)
    }

    //-------------------------------------------------------------------------------------------------------------
    // MARK: - UI

    enum CompleteStatus: String {
        case completed
        case uncompleted
    }

    func configureCell(_ cell: StandardCell, completed: Bool?, item: TaskItem) {

        let icon = (completed == true) ? IconButton.check.rawValue : IconButton.uncheck.rawValue
        let attributes: [NSAttributedStringKey: Any]? = (completed == true) ? [.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue] : nil
        let text = NSAttributedString(string: item.content ?? "", attributes: attributes)

        cell.configure(icon: icon,
                       text: text,
                       description: item.description,
                       tags: item.tags)

        cell.status = (completed == true) ? CompleteStatus.completed.rawValue : CompleteStatus.uncompleted.rawValue
    }
}
