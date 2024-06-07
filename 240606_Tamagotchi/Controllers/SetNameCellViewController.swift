//
//  SetNameCellViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit
import SnapKit

final class SetNameCellViewController: UIViewController {

    let nametextField = {
        let tf = UITextField()
        tf.placeholder = "대장님 이름을 알려주세요!"
        tf.borderStyle = .none
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureNavigation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nametextField.setBorderBottom()
    }
    
    private func configureHierarchy(){
        view.addSubview(nametextField)
    }
    private func configureLayout(){
        nametextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    private func configureUI(){
        view.backgroundColor = Colors.background
        nametextField.delegate = self
    }
    private func configureNavigation(){
        title = "대장님 이름 정하기"
        let save = UIBarButtonItem(title:"저장", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = save
    }
    
    @objc func saveButtonTapped(){
        guard let text = nametextField.text else { return }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty && text.count >= 2 && text.count < 7{
            UserData.me.nickName = text
            navigationController?.popViewController(animated: true)
        }else{
            let alert = UIAlertController(title: "확인해주세요!", message: "2글자 이상, 6글자의 이름을 작성해주세요.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default){ _ in
                self.nametextField.text = ""
            }
            alert.addAction(confirm)
            present(alert, animated: true)
            return
        }
    }
}

// MARK: - UITextField
extension SetNameCellViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if !text.trimmingCharacters(in: .whitespaces).isEmpty && text.count >= 2 && text.count < 7{
            return true
        }else{
            let alert = UIAlertController(title: "확인해주세요!", message: "2글자 이상, 6글자의 이름을 작성해주세요.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default){ _ in
                textField.text = ""
            }
            alert.addAction(confirm)
            present(alert, animated: true)
            return false
        }
           
    }
}
