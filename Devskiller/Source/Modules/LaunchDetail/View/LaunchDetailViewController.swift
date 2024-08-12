//
//  LaunchDetailViewController.swift
//  Devskiller
//
//  Created by Muhammad Umair on 08/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit
import RxSwift
import RxCocoa

class LaunchDetailViewController: BaseViewController, LaunchDetailViewControllerProtocol {

    // ViewModel and DisposeBag for Rx subscriptions
    let viewModel: LaunchDetailViewModelProtocol
    private let disposeBag = DisposeBag()

    // UI Elements
    private let titleSectionView = UIView()
    private let titleSectionLabel = UILabel()
    private let titleLabel = UILabel()

    private let missionSectionView = UIView()
    private let missionSectionLabel = UILabel()
    private let dateLabel = UILabel()
    private let successLabel = UILabel()

    private let descriptionSectionView = UIView()
    private let descriptionSectionLabel = UILabel()
    private let descriptionLabel = UILabel()

    private let actionsSectionView = UIView()
    private let actionsSectionLabel = UILabel()
    private let wikipediaButton = UIButton(type: .system)
    private let youtubeButton = UIButton(type: .system)
    private let websiteButton = UIButton(type: .system)

    // MARK: - Initializer
    init(viewModel: LaunchDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupUI()
        setupBindings()
        setupNavigationBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup
    override func setupUI() {
        view.backgroundColor = .white

        // Configure UI sections and elements
        configureSection(titleSectionView, label: titleSectionLabel, withText: AppConstants.LaunchDetail.missionTitle.localized())
        configureHeadingLabel(titleLabel)

        configureSection(missionSectionView, label: missionSectionLabel, withText: AppConstants.LaunchDetail.date.localized())
        configureHeadingLabel(dateLabel, AppConstants.LaunchDetail.date.localized())
        configureHeadingLabel(successLabel, AppConstants.LaunchDetail.success.localized())

        configureSection(descriptionSectionView, label: descriptionSectionLabel, withText: AppConstants.LaunchDetail.description.localized())
        configureHeadingLabel(descriptionLabel)
        descriptionLabel.numberOfLines = 0

        configureSection(actionsSectionView, label: actionsSectionLabel, withText: AppConstants.LaunchDetail.actions.localized())
        configureButton(wikipediaButton, title: AppConstants.LaunchDetail.openWikipedia.localized(), backgroundColor: UIConstants.Colors.buttonBackground)
        configureButton(youtubeButton, title: AppConstants.LaunchDetail.watchOnYouTube.localized(), backgroundColor: UIConstants.Colors.buttonBackground)
        configureButton(websiteButton, title: AppConstants.LaunchDetail.visitWebsite.localized(), backgroundColor: UIConstants.Colors.buttonBackground)

        // Arrange UI elements in a stack view
        let stackView = UIStackView(arrangedSubviews: [
            titleSectionView, titleLabel,
            missionSectionView, dateLabel, successLabel,
            descriptionSectionView, descriptionLabel,
            actionsSectionView, wikipediaButton, youtubeButton, websiteButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ])
    }

    private func configureSection(_ containerView: UIView, label: UILabel, withText text: String) {
        containerView.backgroundColor = .black
        containerView.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = UIFont(name: UIConstants.Fonts.mediumFont, size: 16)
        label.textColor = .white
        label.textAlignment = .left
        
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func configureHeadingLabel(_ label: UILabel, _ title: String? = nil) {
        label.font = UIFont(name: UIConstants.Fonts.regularFont, size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
    }

    private func updateLabel(_ label: UILabel, withText text: String) {
        label.text = text
    }

    private func configureButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: UIConstants.Fonts.mediumFont, size: 16)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 15
        button.layer.masksToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        button.isEnabled = false
    }

    // MARK: - Navigation Setup
    private func setupNavigationBar() {
        navigationItem.title = AppConstants.LaunchDetail.title.localized()
    }

    // MARK: - Binding Setup
    override func setupBindings() {
        viewModel.launchDetail
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] launchDetail in
                self?.updateLabel(self?.titleLabel ?? UILabel(), withText: launchDetail.name)
                self?.updateLabel(self?.dateLabel ?? UILabel(), withText: launchDetail.date)
                self?.updateLabel(self?.successLabel ?? UILabel(), withText: launchDetail.success == true ? AppConstants.LaunchDetail.completed.localized() : AppConstants.LaunchDetail.failed.localized())
                self?.updateLabel(self?.descriptionLabel ?? UILabel(), withText: launchDetail.details ?? AppConstants.LaunchDetail.notAvailable.localized())
                self?.setupButtons(with: launchDetail)
            }, onError: { [weak self] error in
                self?.showError(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

    private func setupButtons(with launchDetail: LaunchDetailModel) {
        configureButtonAction(wikipediaButton, url: launchDetail.wikipediaURL)
        configureButtonAction(youtubeButton, url: launchDetail.videoID.flatMap { URL(string: "\(AppConstants.YouTube.url)\($0)") })
        configureButtonAction(websiteButton, url: launchDetail.articleURL)
    }

    private func configureButtonAction(_ button: UIButton, url: URL?) {
        button.isEnabled = (url != nil)
        button.alpha = url != nil ? 1.0 : 0.5
        button.rx.tap
            .subscribe(onNext: {
                if let url = url {
                    UIApplication.shared.openAppURL(url)
                }
            })
            .disposed(by: disposeBag)
    }

    func showError(_ message: String) {
        ErrorHandler.showError(message, on: self)
    }
}
