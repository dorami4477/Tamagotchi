//
//  TamagotchiModel.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/6/24.
//

import Foundation

enum Tamagotchi {
    enum TgType:Int{
        case first = 1
        case second
        case third
        case notReady
    }
    enum Level:Int{
        case LV1 = 1, LV2, LV3, LV4,LV5, LV6, LV7, LV8, LV9, LV10
    }
}
struct TamagotchiModel{
    var id:Int
    let name:String
    let type:Tamagotchi.TgType
    var level:Tamagotchi.Level
    
    static var idNumber: Int = 0
    
    init(name: String, type: Tamagotchi.TgType) {
        self.id = TamagotchiModel.idNumber
        self.name = name
        self.type = type
        self.level = .LV1
        
        TamagotchiModel.idNumber += 1
    }
    var imageName:String{
        switch type {
        case .first, .second, .third:
            return "\(type.rawValue)-\(level.rawValue)"
        case .notReady:
            return "noImage"
            
        }
    }
}

final class DataManager{
    
    static let shared = DataManager()
    private init(){}
    
    private var tamaList:[TamagotchiModel] = [
        TamagotchiModel(name: "따끔따끔 다마고치", type: .first),
        TamagotchiModel(name: "방실방실 다마고치", type: .second),
        TamagotchiModel(name: "반짝반짝 다마고치", type: .third),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
        TamagotchiModel(name: "준비중이에요", type: .notReady),
    ]
    
    func getTamaList() -> [TamagotchiModel]{
        return tamaList
    }
    
    func updateData(id:Int, newTama:TamagotchiModel){
            var tama = tamaList.filter{ $0.id == id }.first
            tama = newTama
        print("\(tama!.level): \(tama!.imageName)")
        
    }
    
}
