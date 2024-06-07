//
//  ListCell.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import UIKit
import SnapKit

final class ListCell: UICollectionViewCell {

    
    var mainImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    var nameLabel = {
        let label = PaddingLabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = Colors.text
        label.layer.borderColor = Colors.text.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        return label
    }()
    
    var data:TamagotchiModel?{
        didSet{
            nameLabel.text = data?.name
            mainImageView.image = UIImage(named: data!.imageName)
        }
    }
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy(){
        contentView.addSubview(mainImageView)
        contentView.addSubview(nameLabel)
    }
    func configureLayout(){
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.horizontalEdges.equalToSuperview().inset(10)
            make.width.equalTo(mainImageView.snp.height)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
    }

    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
