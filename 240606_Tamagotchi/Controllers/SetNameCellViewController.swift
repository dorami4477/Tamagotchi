//
//  SetNameCellViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit

class SetNameCellViewController: UIViewController {

    let nametextField = {
        let tf = UITextField()
        tf.placeholder = "대장님 이름을 알려주세요!"
        return tf
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    func configureHierarchy(){
        view.addSubview(nametextField)
    }
    func configureLayout(){
        nametextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
    func configureUI(){
        view.backgroundColor = Colors.backgroud
        title = "대장님 이름 정하기"
        nametextField.delegate = self
    }

}
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
