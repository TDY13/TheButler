//
//  ResidentsViewController.swift
//  InterQR-Internship
//
//  Created by Дмитрий Тимофеев on 14.06.2022.
//

import UIKit

class ResidentsViewController: UIViewController {
    var mainView = ResidentsView()
    var myData: [ResidentModel] = []
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        initViewController()
    }
    
    func initViewController() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(ResidentTableViewCell.self, forCellReuseIdentifier: ResidentTableViewCell.id)
        
        mainView.backButton.addTarget(self, action: #selector(didShowChooseApartVC), for: .touchUpInside)
        mainView.addResidentsButton.addTarget(self, action: #selector(willShowAddResidentVC), for: .touchUpInside)
    }
    
    @objc private func didShowChooseApartVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func willShowAddResidentVC() {
        let addResidentsVC = AddResidentsViewController()
        addResidentsVC.modalPresentationStyle = .overCurrentContext
        addResidentsVC.modalTransitionStyle = .crossDissolve
        addResidentsVC.delegate = self
        present(addResidentsVC, animated: true)
    }
}

//MARK: - TableView delegate & data source
extension ResidentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResidentTableViewCell.id, for: indexPath) as? ResidentTableViewCell else { return UITableViewCell() }
        cell.serialNumberLabel.text = "\(indexPath.row + 1)"
        let data = myData[indexPath.row]
        cell.model = data
        cell.delegate = self
        return cell
    }
}
//MARK: - ResidentSavable delegate
extension ResidentsViewController: ResidentSavable {
    func save(_ data: ResidentModel) {
        self.myData.append(data)
        mainView.tableView.reloadData()
    }
}

//MARK: residentcell delegate
extension ResidentsViewController: ResidentTableViewCellDelegate {
    func didButtonsTapped(cell: ResidentTableViewCell) {
        if !cell.managerButton.isSelected {
                    cell.managerButton.isSelected = true
                } else {
                    cell.managerButton.isSelected = false
                }
    }
    
    func didRemoveButtonTapped(cell: ResidentTableViewCell) {
        guard let model = cell.model else {
            return
        }
        myData.removeAll(where: {$0.name == model.name})
        mainView.tableView.reloadData()
    }
    
    func didManagerButtonTapped(cell: ResidentTableViewCell) {
        if !cell.managerButton.isSelected {
            cell.managerButton.isSelected = true
        } else {
            cell.managerButton.isSelected = false
        }
    }
    
    func didHiddenButtonTapped(cell: ResidentTableViewCell) {
        if !cell.hiddenButton.isSelected {
            cell.hiddenButton.isSelected = true
        } else {
            cell.hiddenButton.isSelected = false
        }
    }

    func didHeardButtonTapped(cell: ResidentTableViewCell) {
        if !cell.heartButton.isSelected {
            cell.heartButton.isSelected = true
        } else {
            cell.heartButton.isSelected = false
        }
    }
}
