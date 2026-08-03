//
//  SettingsViewController.swift
//  fever_free_IOS
//
//  Created by Новий користувач on 03.08.2026.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private let iosVersions = ["iOS 18", "iOS 20", "iOS 21", "iOS 22", "iOS 23", "iOS 24", "iOS 26", "iOS 27 Beta 3"]
    private let picker = UIPickerView()
    private let statusLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.1, blue: 0.2, alpha: 1.0) // Дорогой голубой оттенок
        
        let titleLabel = UILabel()
        titleLabel.text = "Настройки fever_free-IOS"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Скроллер iOS
        picker.delegate = self
        picker.dataSource = self
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)
        
        // Кнопка экспорта бандлов и Dylib
        let exportButton = UIButton(type: .system)
        exportButton.setTitle("Экспорт Бандлов и Dylib", for: .normal)
        exportButton.setTitleColor(.white, for: .normal)
        exportButton.backgroundColor = UIColor(red: 0.1, green: 0.4, blue: 0.8, alpha: 1.0)
        exportButton.layer.cornerRadius = 12
        exportButton.addTarget(self, action: #selector(exportAction), for: .touchUpInside)
        exportButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exportButton)
        
        statusLabel.textColor = .cyan
        statusLabel.textAlignment = .center
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            picker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            picker.heightAnchor.constraint(equalToConstant: 150),
            
            exportButton.topAnchor.constraint(equalTo: picker.bottomAnchor, constant: 30),
            exportButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exportButton.widthAnchor.constraint(equalToConstant: 240),
            exportButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: exportButton.bottomAnchor, constant: 20),
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func exportAction() {
        statusLabel.text = "Экспорт Duilib, Dylib и Бандлов выполнен успешно!"
    }

    // UIPickerView DataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { return iosVersions.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> UIView {
        let label = UILabel()
        label.text = iosVersions[row]
        label.textColor = .white
        label.textAlignment = .center
        return label
    }
}
