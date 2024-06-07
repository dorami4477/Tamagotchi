//
//  ViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cellSpacing:CGFloat = 20
        let cellCounts:CGFloat = 3
        let collectionCellWidth = (UIScreen.main.bounds.width - cellSpacing * (cellCounts - 1) - 40) / cellCounts
        
        flowLayout.itemSize = CGSize(width: collectionCellWidth, height: collectionCellWidth + 15)
        flowLayout.minimumLineSpacing = cellSpacing
        flowLayout.minimumInteritemSpacing = cellSpacing

        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.contentInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        return cv
    }()
    
    private let dataMagnager = DataManager.shared
    private var datas:[TamagotchiModel] = []
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureDelegate()
        datas = dataMagnager.getTamaList()
    }

    
    private func configureHierarchy(){
        view.addSubview(collectionView)
    }
    private func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    private func configureUI(){
        view.backgroundColor = Colors.background
        title = "다마고치 선택하기"
        collectionView.backgroundColor = .clear
    }
    private func configureDelegate(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: ListCell.identifier)
    }

}

// MARK: - UICollectionView
extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.data = datas[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataMagnager.getTamaList()[indexPath.row].type == .notReady{
            //준비중인 다마고치를 고른다면
            let alert = UIAlertController(title: "준비 중", message: "다마고치가 준비 중입니다.\n다른 다마고치를 골라주세요.", preferredStyle: .alert)
            let confirm = UIAlertAction(title: "확인", style: .default)
            alert.addAction(confirm)
            present(alert, animated: true)
            
        }else{
            let vc = DatailPopViewController()
            vc.data = datas[indexPath.row]
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true)
        }
    }
    
}

