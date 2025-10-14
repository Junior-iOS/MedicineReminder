//
//  HomeViewController.swift
//  Reminder
//
//  Created by NJ Development on 26/09/25.
//

import UIKit

protocol HomeFlowDelegate: AnyObject {
    func logout()
}

final class HomeViewController: UIViewController {
    
    private let homeView: HomeView
    private weak var homeDelegate: HomeFlowDelegate?
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        checkForExistingData()
    }
    
    init(view: HomeView, delegate: HomeFlowDelegate) {
        self.homeView = view
        self.homeDelegate = delegate
        super.init(nibName: nil, bundle: nil)
        self.homeView.delegate = self
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
        let exitButton = UIBarButtonItem(
            image: UIImage(icon: .rectanglePortraitAndArrowRight),
            style: .plain,
            target: self,
            action: #selector(exitButtonTapped)
        )
        exitButton.tintColor = Colors.primaryRedBase
        navigationItem.rightBarButtonItem = exitButton
    }
    
    @objc private func exitButtonTapped() {
        UserDefaultsManager.shared.removeUser()
        homeDelegate?.logout()
    }
    
    private func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func checkForExistingData() {
        if let user = UserDefaultsManager.shared.loadUser() {
            homeView.updateView(
                with: UserDefaultsManager.shared.loadUserName() ?? "",
                and: UserDefaultsManager.shared.loadProfileImage()
            )
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapProfileImage() {
        presentImagePicker()
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            homeView.profileImageView.image = editedImage
            UserDefaultsManager.shared.saveProfileImage(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            homeView.profileImageView.image = originalImage
            UserDefaultsManager.shared.saveProfileImage(originalImage)
        }
    
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}
