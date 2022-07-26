//
//  HomeViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 07.06.2022.
//

import UIKit

class HomeViewController: UIViewController {
    var mainView = HomeView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        initViewController()
    }
    
    private func initViewController() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.id)
        mainView.settingsButton.addTarget(self, action: #selector(didShowSettingsVC), for: .touchUpInside)
    }
}

extension HomeViewController {
    @objc private func didShowSettingsVC() {
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.id, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("✅")
    }
    
    
}
