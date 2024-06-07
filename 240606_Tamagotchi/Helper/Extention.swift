//
//  Extention.swift
//  240606_Tamagotchi
//
//  Created by 박다현 on 6/7/24.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(string: string, attributes: [.foregroundColor: color])
    }
    
    func setBorderBottom(){
        let border = CALayer()
        border.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.width, height: 1)
        border.backgroundColor = Colors.text.cgColor
        self.layer.addSublayer(border)
    }
    
}
