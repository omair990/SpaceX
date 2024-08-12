//
//  FilterUIElements.swift
//  Devskiller
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

struct FilterUIElements {
    
    static func yearPickerView(delegate: UIPickerViewDelegate & UIPickerViewDataSource) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = delegate
        pickerView.dataSource = delegate
        pickerView.backgroundColor = .white
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }
    
    static func launchStatusSegmentedControl(target: Any) -> UISegmentedControl {
        let control = UISegmentedControl(items: [
            AppConstants.Filter.all.localized(),
            AppConstants.Filter.success.localized(),
            AppConstants.Filter.failed.localized()
        ])
        control.selectedSegmentIndex = 0
        control.addTarget(target, action: #selector(FilterViewController.launchStatusChanged), for: .valueChanged)
        control.applyDefaultFont()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    static func sortOrderSegmentedControl(target: Any) -> UISegmentedControl {
        let control = UISegmentedControl(items: [
            AppConstants.SortOrder.ascending.localized(),
            AppConstants.SortOrder.descending.localized()
        ])
        control.selectedSegmentIndex = 0
        control.addTarget(target, action: #selector(FilterViewController.sortOrderChanged), for: .valueChanged)
        control.applyDefaultFont()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }
    
    static func applyButton(target: Any) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(AppConstants.Filter.apply.localized(), for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: UIConstants.Fonts.mediumFont, size: UIConstants.FontSize.missionFontSize)
        button.layer.cornerRadius = 8
        button.addTarget(target, action: #selector(FilterViewController.applyFilterTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    static func overlayView() -> UIView {
        let overlayView = UIView()
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        return overlayView
    }
    
    static func containerView() -> UIView {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = UIConstants.Margins.large
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }
    
    static func setupConstraints(for overlayView: UIView, containerView: UIView, elements: [UIView]) {
        guard let superview = overlayView.superview else { return }
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: superview.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 15),
            containerView.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -15),
            containerView.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
        
        let margins = UIConstants.Margins.self
        var previousElement: UIView?
        
        for element in elements {
            containerView.addSubview(element)
            
            NSLayoutConstraint.activate([
                element.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margins.sideMargin),
                element.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -margins.sideMargin)
            ])
            
            if let previous = previousElement {
                NSLayoutConstraint.activate([
                    element.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: margins.verticalSpacing)
                ])
            } else {
                NSLayoutConstraint.activate([
                    element.topAnchor.constraint(equalTo: containerView.topAnchor, constant: margins.verticalSpacing)
                ])
            }
            
            previousElement = element
        }
        
        if let applyButton = elements.last {
            NSLayoutConstraint.activate([
                applyButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -margins.large),
                applyButton.heightAnchor.constraint(equalToConstant: 44)
            ])
        }
    }
}
