//
//  SettingCell.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit

class SettingCell: UITableViewCell {
    
    let iconImageView = {
        let img = UIImageView()
        img.tintColor = Colors.text
        return img
    }()
    let titleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    let resultLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = Colors.text
        return label
    }()
    let arrowImageView = {
        let img = UIImageView()
        img.image = UIImage(systemName: "chevron.right")
        img.tintColor = Colors.text
        return img
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy(){
        [iconImageView, titleLabel, resultLabel, arrowImageView].forEach { contentView.addSubview($0) }
    }
    func configureLayout(){
        iconImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(iconImageView.snp.height)
        }
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
        }
        resultLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalTo(arrowImageView.snp.leading)
        }
        arrowImageView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    func configureData(data:SettingList){
        iconImageView.image = UIImage(systemName: data.icon)
        titleLabel.text = data.title
        resultLabel.text = data.result ?? ""
        
    }

    

}
