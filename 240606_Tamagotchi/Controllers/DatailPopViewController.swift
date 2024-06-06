//
//  DatailPopViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import UIKit

class DatailPopViewController: UIViewController {

    var data:TamagotchiModel?{
        didSet{
            guard let data else { return  }
            nameLabel.text = data.name
            mainImageView.image = UIImage(named: data.imageName)
            captionLabel.text = setCaption(type: data.type)
        }
    }
    
    var backView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    var mainImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    var nameLabel = {
        let label = PaddingLabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Colors.text
        label.layer.borderColor = Colors.text.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        return label
    }()
    var lineView = {
        let view = UIView()
        view.backgroundColor = Colors.text
        return view
    }()
    var captionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .center
        label.textColor = Colors.text
        label.numberOfLines = 0
        return label
    }()
    var cancelButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(Colors.text, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = Colors.backgroud
        button.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        return button
    }()
    var startButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(Colors.text, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    func configureHierarchy(){
        view.addSubview(backView)
        backView.addSubview(mainImageView)
        backView.addSubview(nameLabel)
        backView.addSubview(lineView)
        backView.addSubview(captionLabel)
        backView.addSubview(cancelButton)
        backView.addSubview(startButton)
    }
    func configureLayout(){
        backView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(35)
            make.height.equalTo(380)
        }
        mainImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(24)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        cancelButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(40)
            make.bottom.leading.equalToSuperview()
        }
        startButton.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(50)
            make.leading.equalTo(cancelButton.snp.trailing)
            make.bottom.trailing.equalToSuperview()
        }
        
    }
    func configureUI(){
        view.backgroundColor = .black.withAlphaComponent(0.3)
    }
    func setCaption(type:Tamagotchi.TgType) -> String{
        switch type {
        case .first:
            return "저는 선인장 다마고치입니다.\n키는 2cm, 몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!"
        case .second:
            return "저는 방실방실 다마고치입니다.\n키는 100km, 몸무게는 150톤이에요.\n성격은 화끈하고 날라다닙니다.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n방실방실"
        case .third:
            return "저는 반짝반짝 다마고치입니다.\n키는 150cm, 몸무게는 80kg이에요.\n저는 어디서는 반짝반짝 눈에 띄어요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반짝반짝!"
        case .notReady:
            return "noImage"
            
        }
    }

    @objc func cancelButtonClicked(){
        dismiss(animated: true)
    }
    @objc func startButtonClicked(){
        let vc = MainViewController()
        vc.data = self.data
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .fullScreen
        navVC.modalTransitionStyle = .partialCurl
        UserDefaults.standard.setValue(data?.id, forKey: UserDefault.selectedTama)
        present(navVC, animated: true)
    }

}
