//
//  ViewController.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

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
    
    let datas = DataManager.shared.getTamaList()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureUI()
        configureDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    func configureHierarchy(){
        view.addSubview(collectionView)
    }
    func configureLayout(){
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func configureUI(){
        view.backgroundColor = Colors.backgroud
        title = "다마고치 선택하기"
        collectionView.backgroundColor = .clear
    }
    func configureDelegate(){
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
        let vc = DatailPopViewController()
        vc.data = datas[indexPath.row]
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
}

