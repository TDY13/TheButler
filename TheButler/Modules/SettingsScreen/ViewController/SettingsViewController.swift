//
//  SettingsViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 08.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    var logoutMessage: String?
    var mainView = SettingsView()    
    let settingsModel = SettingsModel.allCases
    
    override func loadView() {
        view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    private func initViewController() {
        mainView.settingsTableView.delegate = self
        mainView.settingsTableView.dataSource = self
        
        mainView.settingsTableView.registerReusableCell(DisplayNameCell.self)
        mainView.settingsTableView.registerReusableCell(SettingsSwitchCell.self)
        mainView.settingsTableView.registerReusableCell(SettingsTableViewCell.self)
        
        mainView.backButton.addTarget(self, action: #selector(didShowHomeVC), for: .touchUpInside)
        mainView.logoutButton.addTarget(self, action: #selector(didTapLogoutButton), for: .touchUpInside)
    }
}
//MARK: - Delegate
extension SettingsViewController {
    @objc private func didShowHomeVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapLogoutButton() {
        logoutRequestProcessing()
        
    }
    
    func logoutRequestProcessing() {
        guard let logoutModel = getLogoutModel() else { return }
        AuthService.shared.logoutRequest(model: logoutModel) { response in
            self.logoutMessage = response.message
            self.logoutDataProcessing()
            print("5️⃣❇️\(response.message ?? "Data not received!")❇️")
        } fail: { error in
            self.logoutErrorProcessing()
            print("5️⃣❗️\(error)❗️")
        }
    }
    
    func getLogoutModel() -> LogoutRequestModel? {
        guard let deviceUUID = UIDevice.current.identifierForVendor?.uuidString else {
            return nil
        }
        return LogoutRequestModel(deviceUUID: deviceUUID)
    }
    
    private func logoutDataProcessing() {
        let alert = UIAlertController(title: "Do you really want to logout?", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            let vc = VerificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func logoutErrorProcessing() {
        if logoutMessage != "OK" {
            let alert = UIAlertController(title: "Some network problems", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let vc = VerificationViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

//MARK: tableView delegate and datasource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model: SettingsModel = settingsModel[row]
        
        switch model {
        case .displayName:
            let cell: DisplayNameCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = model.getTitle()
            cell.descriptionLabel.text = model.getDescription()
            cell.settingsIcon.image = model.getIcon()
            return cell
        case .doNotDisturb, .ringtone:
            let cell: SettingsSwitchCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = model.getTitle()
            cell.descriptionLabel.text = model.getDescription()
            cell.settingsIcon.image = model.getIcon()
            return cell
        case .editResidents, .widgetLock:
            let cell: SettingsTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.titleLabel.text = model.getTitle()
            cell.descriptionLabel.text = model.getDescription()
            cell.settingsIcon.image = model.getIcon()
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let vc = ChooseApartmentsViewController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

