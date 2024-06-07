//
//  SettingViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit
import SnapKit

struct SettingList{
    let icon:String
    let title:String
    var result:String?
}


final class SettingViewController: UIViewController {
    
    private let dataManager = DataManager.shared
    let tableView = UITableView()
    
    var list:[SettingList] = [
        SettingList(icon: "pencil", title: "내 이름 설정하기", result: UserData.me.nickName),
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
    
    override func viewWillAppear(_ animated: Bool) {
        list[0].result = UserData.me.nickName
        tableView.reloadData()
    }
    
    private func configureHierarchy(){
        view.addSubview(tableView)
    }
    private func configureLayout(){
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureUI(){
        view.backgroundColor = Colors.background
        title = "설정"
    }
    private func configureTableView(){
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
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listVC = ViewController()
        //이름 변경
        if indexPath.row == 0{
            let vc = SetNameCellViewController()
            vc.nametextField.text = list[indexPath.row].result
            navigationController?.pushViewController(vc, animated: true)
        //다마고치 변경
        }else if indexPath.row == 1{
            navigationController?.pushViewController(listVC, animated: true)
            
        //데이터 초기화
        }else if indexPath.row == 2{
            let alert = UIAlertController(title: "데이터 초기화", message: "정말 다시 처음부터 시작하실 건가요?", preferredStyle: .alert)

            let delete = UIAlertAction(title: "네", style: .destructive){ _ in
                    print("초기화를 해야지")
                self.dataManager.resetData()
                self.navigationController?.pushViewController(listVC, animated: true)
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(cancel)
            alert.addAction(delete)
            present(alert, animated: true)
        }
    }
    
}
