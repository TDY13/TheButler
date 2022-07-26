//
//  ChooseApartmentsViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class ChooseApartmentsViewController: UIViewController {
    
    var mainView = ChooseApartmentView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    func initViewController() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.backButton.addTarget(self, action: #selector(backToSettingsVC), for: .touchUpInside)
        mainView.tableView.register(ChooseApartmentsTableViewCell.self, forCellReuseIdentifier: ChooseApartmentsTableViewCell.id)
    }
    
    @objc func backToSettingsVC() {
        navigationController?.popViewController(animated: true)
    }
}
extension ChooseApartmentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChooseApartmentsTableViewCell.id, for: indexPath) as? ChooseApartmentsTableViewCell else { return UITableViewCell() }
//        cell.configureWithItem(doors[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        87
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ResidentsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
