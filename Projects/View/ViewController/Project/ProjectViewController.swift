//
//  ProjectViewController.swift
//  Projects
//
//  Created by Min Wu on 08/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

//-------------------------------------------------------------------------------------------------------------
// MARK: - Project View Controller

class ProjectViewController: UIViewController, UITableViewDelegate, SearchTableView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    let headerHeight: CGFloat = 50
    let cellIdentifier = "cell"

    var projects = [Project]()
    var dataSource: RxTableViewSectionedAnimatedDataSource<ProjectGroup>?
    private(set) var projectGroupResults = PublishSubject<[ProjectGroup]>()
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
        store.dispatch(RoutingAction(storyBoard: .main, destination: .project, transitionStyle: .none))
        self.navigationController?.navigationBar.isHidden = true
        getProjects()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }

    //-------------------------------------------------------------------------------------------------------------
    // MARK: - Setup

    private func configureView() {
        configureSearchTextField()
        configureViews()
    }

    private func configureSearchTextField() {
        let placeholder = NSLocalizedString("SearchProjectTextFieldPlaceholder", comment: "Project")
        CommonUI.configureSearchTextField(searchTextField, placeholder: placeholder)
    }

    //-------------------------------------------------------------------------------------------------------------
    // MARK: - Table View Delegate

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let projectGroup = dataSource?[section]
        guard let groupName = projectGroup?.groupName else {return nil}

        let headerView = StandardHeaderView(frame: CGRect(x: 0, y: 0, width: 200, height: headerHeight))
        headerView.autoresizingMask = .flexibleWidth
        headerView.configureHeader(groupName, icon: IconButton.category.rawValue)
        return headerView
    }
}
