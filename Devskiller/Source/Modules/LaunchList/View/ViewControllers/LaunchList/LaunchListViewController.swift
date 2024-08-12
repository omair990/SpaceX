//
//  LaunchListViewController.swift
//  Devskiller
//
//  Created by Muhammad Umair on 04/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class LaunchListViewController: BaseViewController, LaunchListViewControllerProtocol {

    private let tableView = UITableView()
    internal let viewModel: LaunchListViewModelProtocol
    private let tableViewHandler: LaunchListTableViewHandler
    private let disposeBag = DisposeBag()

    // Lazy initialization of the CompanyInfoHeaderView
    private lazy var companyInfoHeaderView: CompanyInfoHeaderView = {
        let headerView = CompanyInfoHeaderView()
        return headerView
    }()

    // Create a shared observable for companyInfo
    private lazy var sharedCompanyInfo: Observable<CompanyResponseModel> = {
        return viewModel.companyInfo.share(replay: 1, scope: .forever)
    }()
    
    // Create a shared observable for launches
    private lazy var sharedLaunches: Observable<[LaunchListModel]> = {
        return viewModel.launches.share(replay: 1, scope: .forever)
    }()

    // Initializer for injecting ViewModel and TableViewHandler
    init(viewModel: LaunchListViewModelProtocol, tableViewHandler: LaunchListTableViewHandler) {
        self.viewModel = viewModel
        self.tableViewHandler = tableViewHandler
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupBindings()
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Update the layout of the table view header when the view's layout is updated
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeaderViewHeight()
    }

    // Set up the UI elements
    override func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableViewHandler.configure(tableView: tableView)
        tableView.accessibilityIdentifier = UIConstants.LaunchList.launchTableIdentifier

        // Set the company info header as the table view's header
        tableView.tableHeaderView = companyInfoHeaderView
        tableView.tableHeaderView?.layoutIfNeeded() // Ensure the header view layout is applied
    }

    // Set up RxSwift bindings to handle data updates
    override func setupBindings() {
        // Bind shared company info to the header view
        sharedCompanyInfo
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] companyInfo in
                self?.companyInfoHeaderView.configure(with: companyInfo)
                self?.updateTableHeaderViewHeight()
            }, onError: { [weak self] error in
                self?.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)

        // Bind shared launches to the table view handler
        sharedLaunches
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] launches in
                self?.displayLaunches(launches)
            }, onError: { [weak self] error in
                self?.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    // Update the height of the table view header to match its content
    private func updateTableHeaderViewHeight() {
        guard let header = tableView.tableHeaderView else { return }

        // Invalidate the layout and force the view to update its constraints
        header.setNeedsLayout()
        header.layoutIfNeeded()

        // Calculate the correct height of the header
        let targetSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let height = header.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height

        // Update the frame only if the height has changed
        if header.frame.height != height {
            var frame = header.frame
            frame.size.height = height
            header.frame = frame

            // Reassign the header view to ensure the table view recalculates the header's height
            tableView.tableHeaderView = header
        }
    }

    // Update the table view with the new data
    func displayLaunches(_ launches: [LaunchListModel]) {
        tableViewHandler.updateData(launches)
        tableView.reloadData()
    }

    // Show an error message using the centralized error handler
    func showError(_ message: String) {
        ErrorHandler.showError(message, on: self)
    }
}
