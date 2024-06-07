//
//  UserModel.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import Foundation

struct User{
    var nickName:String
    var seletedType:Tamagotchi.TgType?
}

struct UserData{
    static var me = User(nickName: "대장", seletedType: nil)
}


