//
//  SettingViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit

struct SettingList{
    let icon:String
    let title:String
    let result:String?
}


class SettingViewController: UIViewController {
    
    let tableView = UITableView()
    
    let list:[SettingList] = [
        SettingList(icon: "pencil", title: "내 이름 설정하기", result: "대장"),
        SettingList(icon: "moon.fill", title: "다마고치 변경하기", result: nil),
        SettingList(icon: "arrow.clockwise", title: "데이터 초기화", result:  nil),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureTableView()
    }
    
    func configureHierarchy(){
        view.addSubview(tableView)
    }
    func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureUI(){
        view.backgroundColor = Colors.backgroud
        title = "설정"
    }
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
    }
}

// MARK: - UITableView
extension SettingViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as! SettingCell
        cell.configureData(data: list[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
//        if indexPath.row == 0{
//            let vc = SetNameCellViewController()
//            vc.nametextField.text = list[indexPath.row].result
//            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
}
