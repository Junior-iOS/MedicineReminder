//
//  NewPrescriptionView.swift
//  Reminder
//
//  Created by NJ Development on 21/10/25.
//

import UIKit
import Lottie

final class NewPrescriptionView: UIView {
    
    private(set) lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(icon: .arrowLeft), for: .normal)
        button.tintColor = Colors.gray100
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nova receita"
        label.textColor = Colors.primaryRedBase
        label.font = Typography.heading
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicione sua prescrição médica para receber lembretes quando necessário."
        label.textColor = Colors.gray200
        label.font = Typography.body
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var medicineInput: InputView = {
        return InputView(title: "Remédio", placeholder: "Nome do remédio")
    }()
    
    private(set) lazy var timeInput: InputView = {
        return InputView(title: "Horário", placeholder: "12:00")
    }()
    
    private(set) lazy var recurrenceInput: InputView = {
        return InputView(title: "Recorrência", placeholder: "Selecione")
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [medicineInput, timeInput, recurrenceInput])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private(set) lazy var timePickerView: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.datePickerMode = .time
        pickerView.preferredDatePickerStyle = .wheels
        return pickerView
    }()
    
    private lazy var recurrencePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var checkBox: CheckBoxView = {
        return CheckBoxView(title: "Tomar agora")
    }()
    
    private(set) lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("+ Adicionar", for: .normal)
        button.titleLabel?.font = Typography.subHeading
        button.backgroundColor = button.isEnabled ? Colors.primaryRedBase : Colors.gray500
        button.setTitleColor(Colors.gray800, for: .normal)
        button.layer.cornerRadius = 12
        return button
    }()
    
    private(set) lazy var lottieAnimation: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "lottie-success")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .playOnce
        animationView.isHidden = true
        return animationView
    }()
    
    private let recurrenceOptions: [RecurrenceOptions] = [
        .oneHour,
        .twoHours,
        .fourHours,
        .sixHours,
        .eightHours,
        .twelveHours,
        .onceADay
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { nil }

    private func setupView() {
        backgroundColor = Colors.gray800
        addSubviews(
            backButton,
            titleLabel,
            descriptionLabel,
            inputStackView,
            checkBox,
            addButton,
            lottieAnimation
        )
        setTimeInput()
        setRecurrenceInput()
        setupConstraints()
        setupObservers()
        validateInputs()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metrics.small),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Metrics.small),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metrics.small),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            inputStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metrics.medium),
            inputStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            inputStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            
            checkBox.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: Metrics.small),
            checkBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.medium),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.medium),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -Metrics.small),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            lottieAnimation.centerXAnchor.constraint(equalTo: centerXAnchor),
            lottieAnimation.centerYAnchor.constraint(equalTo: centerYAnchor),
            lottieAnimation.widthAnchor.constraint(equalToConstant: 120),
            lottieAnimation.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func makeToolbar(doneAction: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "done", style: .plain, target: self, action: doneAction)
        doneButton.tintColor = Colors.gray100
        
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flex, doneButton], animated: false)
        
        return toolbar
    }
    
    private func setTimeInput() {
        let doneAccessoryView = DoneAccessoryView()
        doneAccessoryView.onDoneTapped = { [weak self] in
            self?.didSelectTime()
        }
        timeInput.textField.inputView = timePickerView
        timeInput.textField.inputAccessoryView = doneAccessoryView
    }
    
    @objc private func didSelectTime() {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        timeInput.textField.text = formatter.string(from: timePickerView.date)
        timeInput.textField.resignFirstResponder()
        validateInputs()
    }
    
    private func setRecurrenceInput() {
        recurrencePickerView.delegate = self
        recurrencePickerView.dataSource = self
        
        let doneAccessoryView = DoneAccessoryView()
        doneAccessoryView.onDoneTapped = { [weak self] in
            self?.didSelectRecurrence()
        }

        recurrenceInput.textField.inputView = recurrencePickerView
        recurrenceInput.textField.inputAccessoryView = doneAccessoryView
    }
    
    @objc private func didSelectRecurrence() {
        let selectedRow = recurrencePickerView.selectedRow(inComponent: 0)
        recurrenceInput.textField.text = recurrenceOptions[selectedRow].rawValue
        recurrenceInput.textField.resignFirstResponder()
        validateInputs()
    }
    
    private func validateInputs() {
        let isMedicineEmpty = medicineInput.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        let isTimeEmpty = timeInput.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        let isRecurrenceEmpty = recurrenceInput.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
        
        addButton.isEnabled = !isMedicineEmpty && !isTimeEmpty && !isRecurrenceEmpty
        addButton.backgroundColor = addButton.isEnabled ? Colors.primaryRedBase : Colors.gray500
    }
    
    private func setupObservers() {
        medicineInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        timeInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        recurrenceInput.textField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }
    
    @objc private func inputDidChange() {
        validateInputs()
    }
    
    func clear() {
        medicineInput.clear()
        timeInput.clear()
        recurrenceInput.clear()
        validateInputs()
    }
}

extension NewPrescriptionView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        recurrenceOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        recurrenceOptions[row].rawValue
    }
}

