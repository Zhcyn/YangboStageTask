//
//  ViewController.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class HomeViewController: UIViewController {
    @IBOutlet private weak var groupCollectionView: UICollectionView!
    @IBOutlet private weak var dateTodayLabel: UILabel!
    
    private var viewModel: HomeViewModel!
    private var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        configRealm()
    }
    
    deinit {
        notificationToken?.invalidate()
        RealmService.shared.stopObservingErrors(in: self)
    }

    private func config() {
        viewModel = HomeViewModel()
        view.setGradientLayerVertical(color1: Colors.primaryGColor1.getColors(), color2: Colors.primaryGColor2.getColors(), color3: Colors.primaryGColor3.getColors())
        groupCollectionView.delegate = viewModel
        groupCollectionView.dataSource = viewModel
        groupCollectionView.register(UINib(nibName: "GroupCell", bundle: nil), forCellWithReuseIdentifier: "GroupCell")
        groupCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        groupCollectionView.allowsSelection = false
        
        viewModel.didShowCreateGroup = { [weak self] in
            guard let self = self else { return }
            let vc = CreateGroupViewController.instantiate()
            self.present(vc, animated: true, completion: nil)
        }
        
        viewModel.didMoveToCreateTaskVC = { [weak self] group in
            guard let self = self else { return }
            let vc = CreateTaskViewController.instantiate()
            vc.selectedGroup = group
            self.present(vc, animated: true, completion: nil)
        }
        
        dateTodayLabel.text = Date().dayOfWeek()
        
        setupCollectionViewFlowLayout()
    }
    
    private func setupCollectionViewFlowLayout() {
        let customCollectionViewLayout = CustomCollectionViewFlowLayout()
        customCollectionViewLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 64, height: UIScreen.main.bounds.height * 2/3)
        customCollectionViewLayout.minimumLineSpacing = 8
        customCollectionViewLayout.minimumInteritemSpacing = 0
        customCollectionViewLayout.scrollDirection = .horizontal
        
        groupCollectionView.collectionViewLayout = customCollectionViewLayout
        groupCollectionView.decelerationRate = .fast
    }
    
    private func configRealm() {
        notificationToken = RealmService.shared.realmDB?.observe({ [unowned self] (notification, realm) in
            UIView.transition(with: self.groupCollectionView,
                              duration: 0.35,
                              options: .transitionCrossDissolve,
                              animations: { self.groupCollectionView.reloadData() })
        })
        
        configRealmError()
    }
    
    @IBAction func handleSettingsButtonTapped(_ sender: Any) {
        let vc = SettingsViewController.instantiate()
        present(vc, animated: true)
    }
}
