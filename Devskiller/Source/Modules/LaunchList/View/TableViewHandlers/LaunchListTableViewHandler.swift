//
//  LaunchListTableViewHandler.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LaunchListTableViewHandler: NSObject, TableViewHandlerProtocol {
    
    // MARK: - Properties
    
    private var launches: [LaunchListModel] = []
    private let didSelectLaunch: (LaunchListModel) -> Void
    private let headerView: UIView
    private let viewModel: LaunchListViewModelProtocol
    private let disposeBag = DisposeBag()
    private weak var tableView: UITableView?
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstants.TableView.noDataFound.localized()
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    init(didSelectLaunch: @escaping (LaunchListModel) -> Void, headerView: UIView, viewModel: LaunchListViewModelProtocol) {
        self.didSelectLaunch = didSelectLaunch
        self.headerView = headerView
        self.viewModel = viewModel
        super.init()
        bindLaunches()
    }
        
    // MARK: - Configuration
    
    func configure(tableView: UITableView) {
        self.tableView = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: UIConstants.LaunchList.launchCellIdentifier)
        tableView.accessibilityIdentifier = UIConstants.LaunchList.launchTableIdentifier
        tableView.tableHeaderView = headerView
        tableView.addSubview(noDataLabel)
        noDataLabel.frame = tableView.bounds
        handleInfiniteScrolling(in: tableView)
    }
    
    // MARK: - Data Binding
    
    private func bindLaunches() {
        viewModel.launches
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] launches in
                self?.updateData(launches)
                self?.tableView?.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Infinite Scrolling
    
    private func handleInfiniteScrolling(in tableView: UITableView) {
        tableView.rx.contentOffset
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.isNearBottomEdge(scrollView: tableView)
            }
            .flatMapLatest { [weak self] _ -> Observable<Void> in
                guard let self = self else { return Observable.empty() }
                return self.viewModel.fetchMoreLaunches()
            }
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func isNearBottomEdge(scrollView: UIScrollView, edgeOffset: CGFloat = 100.0) -> Bool {
        return scrollView.contentOffset.y + scrollView.frame.size.height + edgeOffset > scrollView.contentSize.height
    }

    // MARK: - Data Handling
    
    internal func updateData(_ launches: [LaunchListModel]) {
        self.launches = launches
        noDataLabel.isHidden = !launches.isEmpty
    }
    
    // MARK: - UITableViewDataSource and UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UIConstants.LaunchList.launchCellIdentifier, for: indexPath) as? LaunchTableViewCell else {
            return UITableViewCell()
        }
        
        let launch = launches[indexPath.row]
        cell.configure(with: launch)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLaunch = launches[indexPath.row]
        didSelectLaunch(selectedLaunch)
    }
}
