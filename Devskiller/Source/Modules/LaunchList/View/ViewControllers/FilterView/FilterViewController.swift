//
//  FilterViewController.swift
//  Devskiller
//
//  Created by Muhammad Umair on 06/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//
import UIKit

class FilterViewController: BaseViewController {
    
    weak var delegate: FilterViewControllerDelegate?
    
    // Filter properties
    private var selectedYear: String?
    private var selectedLaunchStatus: LaunchStatus = .all
    private var isAscending: Bool = true
    
    // Available years for filtering
    private let availableYears = [AppConstants.Filter.allYears.localized()] + Array(2006...2024).map { String($0) }
    
    // MARK: - UI Elements
    private lazy var yearPickerView: UIPickerView = FilterUIElements.yearPickerView(delegate: self)
    private lazy var launchStatusSegmentedControl: UISegmentedControl = FilterUIElements.launchStatusSegmentedControl(target: self)
    private lazy var sortOrderSegmentedControl: UISegmentedControl = FilterUIElements.sortOrderSegmentedControl(target: self)
    private lazy var applyButton: UIButton = FilterUIElements.applyButton(target: self)
    
    // MARK: - Setup UI
    override func setupUI() {
        super.setupUI()
        view.backgroundColor = .white
        
        let overlayView = FilterUIElements.overlayView()
        view.addSubview(overlayView)
        
        let containerView = FilterUIElements.containerView()
        view.addSubview(containerView)
        
        containerView.addSubview(yearPickerView)
        containerView.addSubview(launchStatusSegmentedControl)
        containerView.addSubview(sortOrderSegmentedControl)
        containerView.addSubview(applyButton)
        
        FilterUIElements.setupConstraints(for: overlayView, containerView: containerView, elements: [yearPickerView, launchStatusSegmentedControl, sortOrderSegmentedControl, applyButton])
    }

    // MARK: - Actions
    @objc internal func launchStatusChanged() {
        switch launchStatusSegmentedControl.selectedSegmentIndex {
        case 1:
            selectedLaunchStatus = .success
        case 2:
            selectedLaunchStatus = .failed
        default:
            selectedLaunchStatus = .all
        }
    }
    
    @objc internal func sortOrderChanged() {
        isAscending = sortOrderSegmentedControl.selectedSegmentIndex == 0
    }
    
    @objc internal func applyFilterTapped() {
        delegate?.applyFilter(year: selectedYear, status: selectedLaunchStatus, isAscending: isAscending)
        dismiss(animated: true, completion: nil)
    }
    
    // Present as bottom sheet
    func presentAsBottomSheet(on viewController: UIViewController) {
        let transitionDelegate = BottomSheetTransitioningDelegate()
        transitioningDelegate = transitionDelegate
        modalPresentationStyle = .custom
        viewController.present(self, animated: true, completion: nil)
    }
}

// MARK: - UIPickerViewDelegate and DataSource
extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return availableYears.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return availableYears[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedYear = availableYears[row] == AppConstants.Filter.allYears.localized() ? nil : availableYears[row]
    }
}
