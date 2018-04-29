//
//  ProjectViewController+Model.swift
//  Projects
//
//  Created by Min Wu on 22/04/2018.
//  Copyright © 2018 Min Wu. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import ReSwift

//-------------------------------------------------------------------------------------------------------------
// MARK: - Project Group

struct ProjectGroup {

    var groupName: String

    var projects: [Project]

    init(groupName: String, projects: [Project]) {
        self.groupName = groupName
        self.projects = projects
    }
}

extension Project: IdentifiableType, Equatable {

    // Identify is uniquely define an object
    public typealias Identity = String
    public var identity: String {
        return id ?? ""
    }
    public static func == (lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }
}

extension ProjectGroup: AnimatableSectionModelType {

    // Identify is uniquely define an object
    typealias Identity = String
    var identity: String {
        return groupName
    }
    // Items declare data for section rows
    typealias Item = Project
    var items: [Project] {
        return projects
    }

    init(original: ProjectGroup, items: [Project]) {
        self = original
        self.projects = items
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Rx Model

extension ProjectViewController {

    func loadModels() {
        searchTextFieldModel()
        tableViewModel()
    }

    private func searchTextFieldModel() {

        let searchModel = SearchModel()

        searchModel.searchTextFieldModel(searchTextField, resetAction: { [weak self] in
            self?.showProjects(self?.projects)
        }, searchAction: { [weak self] searchText in
            self?.searchProjects(searchText)
        }, disposeBag: self.disposeBag)
    }

    private func tableViewDataSource() -> RxTableViewSectionedAnimatedDataSource<ProjectGroup> {

        return TableViewModel.tableViewDataSource { (_, tableView, _, item) in

            guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier) as? StandardCell else {
                return UITableViewCell(style: .default, reuseIdentifier: "default")
            }

            cell.configure(text: item.name,
                           description: item.description,
                           tags: item.tags)
            return cell
        }
    }

    private func tableViewModel() {

        let dataSource = tableViewDataSource()
        let displayCell = self.projectGroupResults.bind(to: self.tableView.rx.items(dataSource: dataSource))
        displayCell.disposed(by: self.disposeBag)

        tableView.rx.modelSelected(Project.self).subscribe(onNext: {[weak self] selectedProject in
            GCD.main.queue.async {
                self?.tableView.deselectRow()
                store.dispatch(SelectProjectAction(project: selectedProject))
                store.dispatch(RoutingAction(storyBoard: .main, destination: .taskList, transitionStyle: .push))
            }
        }).disposed(by: self.disposeBag)

        self.dataSource = dataSource

        tableView.rx.setDelegate(self).disposed(by: disposeBag)
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Action

extension ProjectViewController {

    private func showProjects(_ projects: [Project]?) {

        GCD.userInitiated.queue.async { [weak self] in

            let updateResults: ([ProjectGroup]) -> Void = { projectGroups in
                GCD.main.queue.async { [weak self] in
                    self?.projectGroupResults.onNext(projectGroups)
                }
            }

            guard let projects = projects, projects.isEmpty == false, let projectGroups = self?.groupProjectByCategory(projects) else {
                updateResults([ProjectGroup]())
                return
            }
            updateResults(projectGroups)
        }
    }

    private func searchProjects(_ searchText: String) {

        SearchModel.searchItems(searchText: searchText, objects: projects, searchParameters: {
            // "Cool Project 5" -> ["cool", "project", "5"]
            let projectName = $0.name ?? ""
            let projectNameSegments = $0.name?.split(by: " ") ?? [String]()
            let projectTagNames = $0.tags?.compactMap {$0.name} ?? [String]()
            let projectTagSegments = projectTagNames.compactMap {$0.split(by: " ")}.flatMap {$0}
            let searchParameters: [String] = [projectName] + projectNameSegments + projectTagNames + projectTagSegments
            return searchParameters
        }, result: { [weak self] in
            self?.showProjects($0)
        })
    }
}

//-------------------------------------------------------------------------------------------------------------
// MARK: - Data

extension ProjectViewController {

    private func groupProjectByCategory(_ projects: [Project]) -> [ProjectGroup] {

        let projectByCategory: [String: [Project]] = Dictionary(grouping: projects, by: {$0.category?.name ?? ""})
        var projectGroups = [ProjectGroup]()

        for (categoryName, projectsInCategory) in projectByCategory {
            let projectGroup = ProjectGroup(groupName: categoryName, projects: projectsInCategory)
            projectGroups.append(projectGroup)
        }
        return projectGroups
    }

    func getProjects() {

        var query = ProjectQuery()
        query.projectStatusFilterType = .active

        LoadingIndicator.startAnimating(message: NSLocalizedString("GetProject", comment: "Project"))

        _ = ProjectAPI.getAllProjects(query) { [weak self] in

            LoadingIndicator.stopAnimating()

            guard $0.isSuccess == true, let projects = $0.object else {
                Message.showErrorMessage(text: NSLocalizedString("GetProjectFailedMessage", comment: "Status"))
                return
            }

            projects.forEach {
                print($0.objectDescription)
            }

            self?.projects = projects

            if let searchText = self?.searchTextField.text, searchText.isEmpty == false {
                self?.searchTextField.sendActions(for: .valueChanged)
            } else {
                self?.showProjects(projects)
            }
        }
    }
}
