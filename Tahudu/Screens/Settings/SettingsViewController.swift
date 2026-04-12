//
//  SettingsViewController.swift
//  Tahudu
//

import Foundation
import UIKit

final class SettingsViewController: UITableViewController {
  private let viewModel: SettingsViewModel
  
  init(style: UITableView.Style, viewModel: SettingsViewModel) {
    self.viewModel = viewModel
    super.init(style: style)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    super.loadView()
    setupNavigationBar()
    setupTableView()
    setupData()
  }
  
  private func setupNavigationBar() {
    self.title = viewModel.screenTitle
    self.navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .systemGroupedBackground
    tableView.tableFooterView = UIView()
    tableView.register(SettingsCell.self)
  }
  
  private func setupData() {
    viewModel.setupSettingsData()
  }
}

extension SettingsViewController {
  override func numberOfSections(in _: UITableView) -> Int {
    return viewModel.settingsData.count
  }
  
  override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.settingsData[section].rows.count
  }
  
  override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: SettingsCell = tableView.dequeueReusableCell(for: indexPath)
    let row = viewModel.settingsData[indexPath]
    cell.configure(with: row.settingsItem)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let row = viewModel.settingsData[indexPath]

    switch row {
    case .language:
      openSystemSettings()
    case .country:
      showCountrySelectionScreen()
    case .notifications:
      showNotificationScreen()
    case .about:
      showAboutScreen()
    case .feedback:
      showFeedbackScreen()
    }
  }
}

// ===============================

/// NO NEED TO TUOCH THIS!!!
extension SettingsViewController {
  private func openSystemSettings() {
    print(#function)
  }
  
  private func showCountrySelectionScreen() {
    print(#function)
  }
  
  private func showNotificationScreen() {
    print(#function)
  }
  
  private func showAboutScreen() {
    print(#function)
  }
  
  private func showFeedbackScreen() {
    print(#function)
  }
}
