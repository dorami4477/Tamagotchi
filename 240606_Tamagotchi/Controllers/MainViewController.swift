//
//  MainViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import UIKit

class MainViewController: UIViewController {

    let bubbleBackView = {
        let view = UIView()
        return view
    }()
    let bubbleImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "bubble")
        img.contentMode = .scaleAspectFit
        return img
    }()
    let bubbleLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = Colors.text
        label.text = "온릉ㄴ 왠지 기분이 좋아요"
        return label
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
        label.backgroundColor = Colors.backgroud
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 5
        return label
    }()
    var levelLabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 13)
        label.textAlignment = .center
        label.text = "lv1 . 밥알 0개 , 물방울 0개"
        label.textColor = Colors.text
        return label
    }()
    var mealTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "밥주세용"
        tf.keyboardType = .numberPad
        return tf
    }()
    var feedButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "drop.circle"), for: .normal)
        button.setTitle("밥먹기", for: .normal)
        button.setTitleColor(Colors.text, for: .normal)
        button.layer.borderColor = Colors.text.cgColor
        button.tintColor = Colors.text
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(feedButtonTapped), for: .touchUpInside)
        return button
    }()
    var waterTextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.placeholder = "물주세용"
        tf.keyboardType = .numberPad
        return tf
    }()
    var wateredButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "leaf.circle"), for: .normal)
        button.setTitle("물먹기", for: .normal)
        button.setTitleColor(Colors.text, for: .normal)
        button.tintColor = Colors.text
        button.layer.borderColor = Colors.text.cgColor
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(wateredButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dataManager = DataManager.shared
    
    var data:TamagotchiModel?{
        didSet{
            nameLabel.text = data?.name
            mainImageView.image = UIImage(named: data!.imageName)
            levelLabel.text = "\(data!.level)+ 밥알 \(Int(meal))개 ∙ 물방울 \(Int(water))개"
        }
    }
    
    var meal:Double = 0
    var water:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    func configureHierarchy(){
        [bubbleBackView, mainImageView, nameLabel, levelLabel, mealTextField, feedButton, waterTextField, wateredButton].forEach { view.addSubview($0) }
        bubbleBackView.addSubview(bubbleImageView)
        bubbleBackView.addSubview(bubbleLabel)
    }
    func configureLayout(){
        bubbleBackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview().inset(80)
            make.height.equalTo(bubbleBackView.snp.width).multipliedBy(5.0/8.0)
        }
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bubbleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(bubbleBackView.snp.bottom)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(bubbleBackView.snp.width).inset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        mealTextField.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(24)
            make.height.equalTo(36)
            make.leading.equalTo(80)
        }
        feedButton.snp.makeConstraints { make in
            make.top.equalTo(levelLabel.snp.bottom).offset(24)
            make.width.equalTo(75)
            make.height.equalTo(mealTextField.snp.height)
            make.leading.equalTo(mealTextField.snp.trailing)
            make.trailing.equalTo(-80)
        }
        waterTextField.snp.makeConstraints { make in
            make.top.equalTo(mealTextField.snp.bottom).offset(12)
            make.height.equalTo(mealTextField.snp.height)
            make.leading.equalTo(80)
        }
        wateredButton.snp.makeConstraints { make in
            make.top.equalTo(feedButton.snp.bottom).offset(12)
            make.width.equalTo(75)
            make.height.equalTo(mealTextField.snp.height)
            make.leading.equalTo(waterTextField.snp.trailing)
            make.trailing.equalTo(-80)
        }
    }
    func configureUI(){
        view.backgroundColor = .white
        mealTextField.delegate = self
        waterTextField.delegate = self
    }
    func configureNavigation(){
            let setting = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(settingButtonClicked))
            title = "대장님의 다마고치"
            navigationItem.rightBarButtonItem = setting
    }
    
    @objc func feedButtonTapped(){
        guard let text = mealTextField.text else { return }
        if text == ""{
            //텍스트필드가 비었을때
            meal += 1
            levelLabel.text = "\(getLevel())+ 밥알 \(Int(meal))개 ∙ 물방울 \(Int(water))개"
            mealTextField.text = ""

           if var data{
                data.level = getLevel()
                dataManager.updateData(id: data.id, newTama: data)
            }
        }else if let num = Double(text), num < 100{
            //숫자가 100미만 일때
            meal += num
            levelLabel.text = "\(getLevel())+ 밥알 \(Int(meal))개 ∙ 물방울 \(Int(water))개"
            return
        }else if let num = Double(text), num > 100{
            //숫자가 100이상 일때
            let alert = UIAlertController(title: "100이하의 숫자만 입력해주세요.", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default){ _ in
                self.mealTextField.text = ""
            }
            alert.addAction(confirm)
            present(alert, animated: true)
        }
        
    }
    
    @objc func wateredButtonTapped(){
        guard let text = mealTextField.text else { return }
        if text == ""{
            //텍스트필드가 비었을때
            water += 1
            levelLabel.text = "\(getLevel())+ 밥알 \(Int(meal))개 ∙ 물방울 \(Int(water))개"
            waterTextField.text = ""
            
        }else if let num = Double(text), num < 50{
            //숫자가 50미만 일때
            water += num
            levelLabel.text = "\(getLevel())+ 밥알 \(Int(meal))개 ∙ 물방울 \(Int(water))개"
            return
        }else if let num = Double(text), num > 50{
            //숫자가 50이상 일때
            let alert = UIAlertController(title: "100이하의 숫자만 입력해주세요.", message: nil, preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default){ _ in
                self.waterTextField.text = ""
            }
            alert.addAction(confirm)
            present(alert, animated: true)
        }
    }
    
    @objc func settingButtonClicked(){
        print(#function)
    }
    
    func getLevel() -> Tamagotchi.Level{
        let grade = ( meal / 5 ) + ( water / 2 )
        guard let data else { return Tamagotchi.Level.LV1 }
        switch grade {
        case 0..<10:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-1")
            return Tamagotchi.Level.LV1
        case 10..<20:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-1")
            return Tamagotchi.Level.LV1
        case 20..<30:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-2")
            return Tamagotchi.Level.LV2
        case 30..<40:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-3")
            return Tamagotchi.Level.LV3
        case 40..<50:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-4")
            return Tamagotchi.Level.LV4
        case 50..<60:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-5")
            return Tamagotchi.Level.LV5
        case 60..<70:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-6")
            return Tamagotchi.Level.LV6
        case 70..<80:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-7")
            return Tamagotchi.Level.LV7
        case 80..<90:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-8")
            return Tamagotchi.Level.LV8
        case 90..<100:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-9")
            return Tamagotchi.Level.LV9
        case 100...:
            mainImageView.image = UIImage(named: "\(data.type.rawValue)-10")
            return Tamagotchi.Level.LV10
        default:
            return Tamagotchi.Level.LV1
        }
    }

}

// MARK: - TextFieldDelegate
extension MainViewController:UITextFieldDelegate{
    //숫자만 입력 가능하도록
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if Int(string) != nil || string == ""{
            return true
        }
        let alert = UIAlertController(title: "숫자만", message: "100이하의 숫자만 입력해주세요.", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default){ _ in
            textField.text = ""
        }
        alert.addAction(confirm)
        present(alert, animated: true)
        return false
    }
}


