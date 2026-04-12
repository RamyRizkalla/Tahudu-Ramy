//
//  SettingsView.swift
//  Tahudu
//

import SwiftUI

struct SettingsView: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> UINavigationController {
    let settingsViewModel = SettingsViewModel(screenTitle: "My Account")
    let settingsViewController = SettingsViewController(style: .insetGrouped, viewModel: settingsViewModel)
    
    let navigatoinController = UINavigationController(rootViewController: settingsViewController)
    return navigatoinController
  }
  
  func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
    // Nothing here
  }
}
