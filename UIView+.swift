//
//  UIView+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    func setGradientLayerVertical(color1: String, color2: String, color3: String) {
        let gColor1 = UIColor(hexString: color1).cgColor
        let gColor2 = UIColor(hexString: color2).cgColor
        let gColor3 = UIColor(hexString: color3).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientLayer"
        gradientLayer.colors = [gColor1, gColor2, gColor3]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        removeAllGradientLayer()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setGradientLayerHorizontal(color1: String, color2: String, color3: String) {
        let gColor1 = UIColor(hexString: color1).cgColor
        let gColor2 = UIColor(hexString: color2).cgColor
        let gColor3 = UIColor(hexString: color3).cgColor

        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "gradientLayer"
        gradientLayer.colors = [gColor1, gColor2, gColor3]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        removeAllGradientLayer()
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func removeAllGradientLayer() {
        if let sublayers = self.layer.sublayers {
            for layer in sublayers {
                if layer.name == "gradientLayer" {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}
