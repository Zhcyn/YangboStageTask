//
//  CreateGroupViewController.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/10/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


final class CreateGroupViewController: UIViewController, KeyboardHandler {
    @IBOutlet private weak var selectedIconImageView: UIImageView!
    @IBOutlet private weak var groupNameTextView: UITextView!
    @IBOutlet private weak var iconsCollectionView: UICollectionView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var bottomSaveButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var leadingSaveButtonConstraint: NSLayoutConstraint!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var viewModel: CreateGroupVM!
    private let placeHolderText: String = "Group's name"
    var didChangedWhenKeyboardShow: ((Bool, CGFloat) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
    }
    
    private func config() {
        viewModel = CreateGroupVM()
        iconsCollectionView.delegate = viewModel
        iconsCollectionView.dataSource = viewModel
        iconsCollectionView.register(UINib(nibName: "IconCell", bundle: nil), forCellWithReuseIdentifier: "IconCell")
        
        groupNameTextView.text = placeHolderText
        groupNameTextView.textColor = .lightGray
        
        saveButton.setGradientLayerHorizontal(color1: Colors.primaryGColor1.getColors(), color2: Colors.primaryGColor2.getColors(), color3: Colors.primaryGColor3.getColors())
        
        selectedIconImageView.image = UIImage(named: "ic-briefcase")?.withRenderingMode(.alwaysTemplate)
        selectedIconImageView.tintColor = UIColor(hexString: Colors.iconTintColorSelected.getColors())
        
        viewModel.didSelectedIcon = { [weak self] iconUrl in
            guard let self = self else { return }
            self.selectedIconImageView.image = UIImage(named: iconUrl)?.withRenderingMode(.alwaysTemplate)
        }
        
        scrollView.hideKeyboard()
        startObservingKeyboardChanges()
        
        didChangedWhenKeyboardShow = { [weak self] show, changeInHeight in
            guard let self = self else { return }
            self.bottomSaveButtonConstraint.constant = show ? changeInHeight : 32
            self.leadingSaveButtonConstraint.constant = show ? 0 : 32
            self.saveButton.cornerRadius = show ? 0 : 32
            UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear], animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopObservingKeyboardChanges()
    }
    
    @IBAction func handleCloseButtonTapped(_ sender: Any) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleSaveButtonTapped(_ sender: Any) {
        guard let groupName = groupNameTextView.text else { return }
        guard groupName.removeWhitespace() != "" && groupNameTextView.textColor != .lightGray else {
            showAlert(title: "Message", message: "Please fill your group's content")
            return
        }
        
        viewModel.createGroup(groupName: groupName)
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
}

extension CreateGroupViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView == groupNameTextView else { return }
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard textView == groupNameTextView else { return }
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = .lightGray
        }
    }
}

extension CreateGroupViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
