//
//  IconCell.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/10/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class IconCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var iconButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconButton.isUserInteractionEnabled = false
    }
    
    func configIconCell(_ icon: Icon, cornerRadius: CGFloat) {
        guard let iconImage = icon.iconUrl,
            let isSelected = icon.isSelected else { return }
        
        let tintImage = UIImage(named: iconImage)?.withRenderingMode(.alwaysTemplate)
        iconButton.setImage(tintImage, for: .normal)
        iconButton.isSelected = isSelected
        iconButton.cornerRadius = cornerRadius
        
        if iconButton.isSelected == true {
            iconButton.backgroundColor = UIColor(hexString: Colors.iconBGColorSelected.getColors())
            iconButton.tintColor = UIColor(hexString: Colors.iconTintColorSelected.getColors())
        } else {
            iconButton.backgroundColor = UIColor(hexString: Colors.iconBGColorUnselected.getColors())
            iconButton.tintColor = UIColor(hexString: Colors.iconTintColorUnselected.getColors())
        }
    }
}
