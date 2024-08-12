//
//  CompanyInfoHeaderView.swift
//  Devskiller
//
//  Created by Muhammad Umair on 05/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit

class CompanyInfoHeaderView: UIView {

    // MARK: - UI Elements
    private let companyTitleBackgroundView = UIView()
    private let companyTitleLabel = UILabel()
    private let companyDetailsLabel = UILabel()
    private let launchesTitleBackgroundView = UIView()
    private let launchesTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        // Setup title background views
        companyTitleBackgroundView.backgroundColor = .black
        companyTitleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(companyTitleBackgroundView)

        launchesTitleBackgroundView.backgroundColor = .black
        launchesTitleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(launchesTitleBackgroundView)

        // Setup title labels
        companyTitleLabel.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.headerFontSize)
        companyTitleLabel.textColor = .white
        companyTitleLabel.text = AppConstants.CompanyInfo.companyTitle.localized()
        companyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        companyTitleBackgroundView.addSubview(companyTitleLabel)

        launchesTitleLabel.font = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.headerFontSize)
        launchesTitleLabel.textColor = .white
        launchesTitleLabel.text = AppConstants.CompanyInfo.launchesTitle.localized()
        launchesTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        launchesTitleBackgroundView.addSubview(launchesTitleLabel)

        // Setup company details label
        companyDetailsLabel.font = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize)
        companyDetailsLabel.numberOfLines = 0
        companyDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(companyDetailsLabel)

        // Setup constraints
        NSLayoutConstraint.activate([
            // Company Title Background View
            companyTitleBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            companyTitleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            companyTitleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            companyTitleBackgroundView.heightAnchor.constraint(equalToConstant: 40),

            // Company Title Label
            companyTitleLabel.leadingAnchor.constraint(equalTo: companyTitleBackgroundView.leadingAnchor, constant: UIConstants.Margins.sideMargin),
            companyTitleLabel.centerYAnchor.constraint(equalTo: companyTitleBackgroundView.centerYAnchor),

            // Company Details Label
            companyDetailsLabel.topAnchor.constraint(equalTo: companyTitleBackgroundView.bottomAnchor, constant: UIConstants.Margins.large),
            companyDetailsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.Margins.sideMargin),
            companyDetailsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.Margins.sideMargin),

            // Launches Title Background View
            launchesTitleBackgroundView.topAnchor.constraint(equalTo: companyDetailsLabel.bottomAnchor, constant: UIConstants.Margins.large),
            launchesTitleBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            launchesTitleBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            launchesTitleBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            launchesTitleBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIConstants.Margins.large).withPriority(.defaultLow),

            // Launches Title Label
            launchesTitleLabel.leadingAnchor.constraint(equalTo: launchesTitleBackgroundView.leadingAnchor, constant: UIConstants.Margins.sideMargin),
            launchesTitleLabel.centerYAnchor.constraint(equalTo: launchesTitleBackgroundView.centerYAnchor)
        ])
    }

    // MARK: - Configure View
    func configure(with model: CompanyResponseModel) {

        let founderText = String(format: AppConstants.CompanyInfo.foundedBy, model.name, model.founder, model.founded)
        let detailsText = String(format: AppConstants.CompanyInfo.details, model.employees, model.launchSites, model.valuation)
        companyDetailsLabel.text = "\(founderText)\n\(detailsText)"
    }

    // Update the view's intrinsic content size to ensure dynamic height adjustment
    override var intrinsicContentSize: CGSize {
        let fittingSize = UIView.layoutFittingCompressedSize
        return systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}

