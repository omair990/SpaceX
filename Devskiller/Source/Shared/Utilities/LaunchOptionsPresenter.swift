//
//  LaunchOptionsPresenter.swift
//  Devskiller
//
//  Created by Muhammad Umair on 07/02/1446 AH.
//  Copyright © 1446 AH Mindera. All rights reserved.
//

import Foundation
import UIKit

/// A presenter responsible for showing launch options in an action sheet.
class LaunchOptionsPresenter {
    
    /// Displays an action sheet with launch options, presenting it from the specified view controller.
    /// - Parameters:
    ///   - launch: The `LaunchListModel` object containing the launch details.
    ///   - viewController: The `UIViewController` from which the action sheet is presented.
    static func showLaunchOptions(for launch: LaunchListModel, from viewController: UIViewController) {
        let actionSheet = createLaunchOptionsActionSheet(for: launch)
        viewController.present(actionSheet, animated: true)
    }
    
    /// Creates an action sheet for the specified launch, including options to view articles, Wikipedia, and videos.
    /// - Parameter launch: The `LaunchListModel` object containing the launch details.
    /// - Returns: A configured `UIAlertController` action sheet.
    private static func createLaunchOptionsActionSheet(for launch: LaunchListModel) -> UIAlertController {
        let actionSheet = UIAlertController(
            title: launch.name,
            message: AppConstants.FilterDetail.actionSheetTitle.localized(),
            preferredStyle: .actionSheet
        )
        
        // Add different actions based on available URLs in the launch model.
        addArticleAction(to: actionSheet, for: launch)
        addWikipediaAction(to: actionSheet, for: launch)
        addVideoAction(to: actionSheet, for: launch)
        
        // Add a cancel action to allow the user to dismiss the action sheet.
        let cancelAction = UIAlertAction(
            title: AppConstants.FilterDetail.cancelTitle.localized(),
            style: .cancel
        )
        actionSheet.addAction(cancelAction)
        
        // Customize the title and message font dynamically.
        setAttributedText(for: actionSheet, title: launch.name, message: AppConstants.FilterDetail.actionSheetTitle.localized())
        
        return actionSheet
    }
    
    /// Adds an action to open an article if the article URL is available.
    /// - Parameters:
    ///   - actionSheet: The `UIAlertController` to which the action is added.
    ///   - launch: The `LaunchListModel` containing the article URL.
    private static func addArticleAction(to actionSheet: UIAlertController, for launch: LaunchListModel) {
        if let articleURL = launch.articleURL {
            let articleAction = UIAlertAction(
                title: AppConstants.FilterDetail.openArticleTitle.localized(),
                style: .default
            ) { _ in
                UIApplication.shared.open(articleURL)
            }
            actionSheet.addAction(articleAction)
        }
    }
    
    /// Adds an action to open a Wikipedia page if the Wikipedia URL is available.
    /// - Parameters:
    ///   - actionSheet: The `UIAlertController` to which the action is added.
    ///   - launch: The `LaunchListModel` containing the Wikipedia URL.
    private static func addWikipediaAction(to actionSheet: UIAlertController, for launch: LaunchListModel) {
        if let wikipediaURL = launch.wikipediaURL {
            let wikipediaAction = UIAlertAction(
                title: AppConstants.FilterDetail.openWikipediaTitle.localized(),
                style: .default
            ) { _ in
                UIApplication.shared.open(wikipediaURL)
            }
            actionSheet.addAction(wikipediaAction)
        }
    }
    
    /// Adds an action to open a YouTube video if the video ID is available.
    /// - Parameters:
    ///   - actionSheet: The `UIAlertController` to which the action is added.
    ///   - launch: The `LaunchListModel` containing the video ID.
    private static func addVideoAction(to actionSheet: UIAlertController, for launch: LaunchListModel) {
        if let videoID = launch.videoID, let videoURL = videoID.toYouTubeURL() {
            let videoAction = UIAlertAction(
                title: AppConstants.FilterDetail.openVideoTitle.localized(),
                style: .default
            ) { _ in
                UIApplication.shared.open(videoURL)
            }
            actionSheet.addAction(videoAction)
        }
    }
    
    /// Sets attributed text for the action sheet's title and message, allowing dynamic font customization.
    /// - Parameters:
    ///   - actionSheet: The `UIAlertController` whose title and message are being customized.
    ///   - title: The title text to display.
    ///   - message: The message text to display.
    private static func setAttributedText(for actionSheet: UIAlertController, title: String, message: String?) {
        // Load fonts dynamically or fall back to system fonts if the specified ones are not available.
        let titleFont = UIFont(name: UIConstants.Fonts.boldFont, size: UIConstants.FontSize.titleFontSize) ?? UIFont.boldSystemFont(ofSize: UIConstants.FontSize.titleFontSize)
        let messageFont = UIFont(name: UIConstants.Fonts.regularFont, size: UIConstants.FontSize.bodyFontSize) ?? UIFont.systemFont(ofSize: UIConstants.FontSize.bodyFontSize)

        // Localize the title and message strings.
        let localizedTitle = title.localized()
        let localizedMessage = message?.localized() ?? ""

        // Create attributed strings with the dynamic fonts.
        let titleAttrString = NSAttributedString(string: localizedTitle, attributes: [NSAttributedString.Key.font: titleFont])
        let messageAttrString = NSAttributedString(string: localizedMessage, attributes: [NSAttributedString.Key.font: messageFont])

        // Set the attributed strings for the title and message.
        actionSheet.setValue(titleAttrString, forKey: "attributedTitle")
        actionSheet.setValue(messageAttrString, forKey: "attributedMessage")
    }
}
