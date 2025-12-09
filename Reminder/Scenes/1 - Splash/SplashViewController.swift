//
//  ViewController.swift
//  Reminder
//
//  Created by NJ Development on 25/09/25.
//

import UIKit

protocol SplashFlowDelegate: AnyObject {
    func navigateToLogin()
    func navigateToHome()
}

final class SplashViewController: UIViewController {
    
    private let splashView: SplashView
    public weak var splashDelegate: SplashFlowDelegate?
        
    override func loadView() {
        view = splashView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupGesture()
        animateView()
    }
    
    init(view: SplashView, delegate: SplashFlowDelegate) {
        self.splashView = view
        self.splashDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }
    
    private func setup() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        splashView.addGestureRecognizer(tapGesture)
    }

    @objc private func showLoginBottomSheet() {
        animateLogoUp()
        self.splashDelegate?.navigateToLogin()
    }
    
    private func checkNavigationFlow() {
        if let user = UserDefaultsManager.shared.loadUser(), user.isUserLoggedIn {
            self.splashDelegate?.navigateToHome()
        } else {
            showLoginBottomSheet()
        }
    }
}

// MARK: - ANIMATION
extension SplashViewController {
    private func animateView() {
        UIView.animate(withDuration: 1.5, delay: 0.0, animations: {
            self.splashView.stackView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            self.checkNavigationFlow()
        }
    }
    
    private func animateLogoUp() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.splashView.stackView.transform = CGAffineTransform(translationX: 0, y: -100)
        }, completion: nil)
    }
}

//import UIKit
//
//final class AmountInputViewController: UIViewController {
//    
//    private let textField = UITextField()
//    private var bubblesAccessory: AmountAccessoryView!
//    private var doneAccessory: DoneAccessoryView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        
//        textField.borderStyle = .roundedRect
//        textField.placeholder = "Digite algo..."
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(textField)
//        
//        NSLayoutConstraint.activate([
//            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            textField.widthAnchor.constraint(equalToConstant: 250)
//        ])
//        
//        // Cria os dois accessory views
//        bubblesAccessory = AmountAccessoryView(bubbles: [50, 100, 150, 200])
//        bubblesAccessory.onBubbleTapped = { [weak self] value in
//            print("Selecionado \(value)")
//            self?.animateAccessoryTransition(showDone: true)
//        }
//        
//        doneAccessory = DoneAccessoryView()
//        doneAccessory.onDoneTapped = { [weak self] in
//            self?.animateAccessoryTransition(showDone: false)
//            self?.textField.resignFirstResponder()
//        }
//        
//        // Define o primeiro accessory view antes do teclado abrir
//        textField.inputAccessoryView = bubblesAccessory
//    }
//    
//    private func animateAccessoryTransition(showDone: Bool) {
//        guard let window = view.window else { return }
//        
//        let newAccessory = showDone ? doneAccessory! : bubblesAccessory!
//        let oldAccessory = showDone ? bubblesAccessory! : doneAccessory!
//        
//        // Pega o container real do teclado (janela especial)
//        if let accessoryContainer = textField.inputAccessoryView?.superview {
//            // Anima o "slide"
//            newAccessory.transform = CGAffineTransform(translationX: 0, y: 60)
//            newAccessory.alpha = 0
//            
//            textField.inputAccessoryView = newAccessory
//            textField.reloadInputViews()
//            
//            UIView.animate(withDuration: 0.25, animations: {
//                newAccessory.transform = .identity
//                newAccessory.alpha = 1
//                oldAccessory.transform = CGAffineTransform(translationX: 0, y: 60)
//                oldAccessory.alpha = 0
//            })
//        } else {
//            textField.inputAccessoryView = newAccessory
//            textField.reloadInputViews()
//        }
//    }
//}
//
//final class AmountAccessoryView: UIView {
//    var onBubbleTapped: ((UInt) -> Void)?
//    
//    init(bubbles: [UInt]) {
//        super.init(frame: .init(x: 0, y: 0, width: 0, height: 50))
//        backgroundColor = .secondarySystemBackground
//        setupStack(bubbles)
//    }
//    
//    required init?(coder: NSCoder) { fatalError() }
//    
//    private func setupStack(_ bubbles: [UInt]) {
//        let scroll = UIScrollView()
//        scroll.showsHorizontalScrollIndicator = false
//        
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 12
//        stack.alignment = .center
//        stack.distribution = .equalSpacing
//        
//        for value in bubbles {
//            let button = UIButton(type: .system)
//            button.setTitle("\(value)", for: .normal)
//            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
//            button.backgroundColor = .systemBlue.withAlphaComponent(0.1)
//            button.layer.cornerRadius = 8
//            button.contentEdgeInsets = .init(top: 6, left: 12, bottom: 6, right: 12)
//            button.addAction(UIAction { [weak self] _ in
//                self?.onBubbleTapped?(value)
//            }, for: .touchUpInside)
//            stack.addArrangedSubview(button)
//        }
//        
//        scroll.addSubview(stack)
//        addSubview(scroll)
//        
//        scroll.translatesAutoresizingMaskIntoConstraints = false
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            scroll.leadingAnchor.constraint(equalTo: leadingAnchor),
//            scroll.trailingAnchor.constraint(equalTo: trailingAnchor),
//            scroll.topAnchor.constraint(equalTo: topAnchor),
//            scroll.bottomAnchor.constraint(equalTo: bottomAnchor),
//            
//            stack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 12),
//            stack.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -12),
//            stack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 8),
//            stack.bottomAnchor.constraint(equalTo: scroll.bottomAnchor, constant: -8),
//            heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//}
//
//final class DoneAccessoryView: UIView {
//    var onDoneTapped: (() -> Void)?
//    
//    init() {
//        super.init(frame: .init(x: 0, y: 0, width: 0, height: 50))
//        backgroundColor = .secondarySystemBackground
//        
//        let button = UIButton(type: .system)
//        button.setTitle("Done", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
//        button.addAction(UIAction { [weak self] _ in
//            self?.onDoneTapped?()
//        }, for: .touchUpInside)
//        
//        addSubview(button)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: centerYAnchor),
//            heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//    
//    required init?(coder: NSCoder) { fatalError() }
//}
//
//import UIKit
//
//final class ViewController: UIViewController, UITextFieldDelegate {
//    
//    private let amountTextField: UITextField = {
//        let textField = UITextField()
//        textField.placeholder = "Digite um valor"
//        textField.borderStyle = .roundedRect
//        textField.keyboardType = .numberPad
//        return textField
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        
//        amountTextField.delegate = self
//        view.addSubview(amountTextField)
//        
//        amountTextField.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            amountTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            amountTextField.widthAnchor.constraint(equalToConstant: 200)
//        ])
//        
//        // ✅ Adiciona o botão Done acima do teclado
//        addDoneButtonToKeyboard()
//    }
//    
//    private func addDoneButtonToKeyboard() {
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//        
//        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
//        
//        toolbar.items = [flex, done]
//        amountTextField.inputAccessoryView = toolbar
//    }
//    
//    @objc private func doneTapped() {
//        view.endEditing(true)
//    }
//}
