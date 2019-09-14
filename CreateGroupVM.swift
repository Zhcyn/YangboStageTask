//
//  CreateGroupVM.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/10/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class CreateGroupVM: NSObject {
    private var icons: [Icon] = []
    
    private var numberOfItemsPerRow: Int = 6
    var didSelectedIcon: ((String) -> Void)?
    
    override init() {
        super.init()
        setupData()
    }
    
    private func setupData() {
        let iconsList = ["ic-briefcase", "ic-user", "ic-heart", "ic-cake", "ic-baby-carriage", "ic-runner", "ic-phone", "ic-footprint", "ic-car", "ic-camera", "ic-threedots"]
        
        iconsList.forEach {
            let icon = Icon(iconUrl: $0, isSelected: false)
            icons.append(icon)
        }
        
        icons[0].isSelected = true
    }
    
    func createGroup(groupName: String) {
        var selectedIcon: String?
        
        icons.forEach {
            if $0.isSelected! {
                selectedIcon = $0.iconUrl
            }
        }
        
        let newGroup = Group(groupName: groupName, icon: selectedIcon)
        RealmService.shared.create(newGroup)
    }
}

extension CreateGroupVM: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: IconCell = collectionView.dequeueReusableCell(for: indexPath)
        let corRadius: CGFloat = ((collectionView.frame.width - CGFloat(max(0, numberOfItemsPerRow - 1) * 8)) / CGFloat(numberOfItemsPerRow)) / 2
        cell.configIconCell(icons[indexPath.row], cornerRadius: corRadius)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<icons.count {
            if i != indexPath.row {
                icons[i].isSelected = false
            } else {
                icons[i].isSelected = true
            }
        }
        didSelectedIcon?(icons[indexPath.row].iconUrl ?? "")
        
        let indexPaths = collectionView.indexPathsForVisibleItems
        collectionView.reloadItems(at: indexPaths)
    }
}

extension CreateGroupVM: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - CGFloat(max(0, numberOfItemsPerRow - 1) * 8)) / CGFloat(numberOfItemsPerRow)
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
