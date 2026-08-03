//
//  MainViewController.swift
//  fever_free_IOS
//
//  Created by Новий користувач on 03.08.2026.
//

import UIKit

class MainViewController: UIViewController {

    private let titleLabel = UILabel()
    let startButton = UIButton(type: .system)
    let loadingView = UIView()
    let butterflyImageView = UIImageView()
    let statusLogLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(red: 0.03, green: 0.08, blue: 0.18, alpha: 1.0)
        
        // Название сверху
        titleLabel.text = "fever"
        titleLabel.textColor = .cyan
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        // Кнопка Старт
        startButton.setTitle("СТАРТ", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        startButton.layer.cornerRadius = 16
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.addTarget(self, action: #selector(startTapped), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        // Настройка экрана загрузки (стиль TrollStore + Бабочка uicache)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        loadingView.isHidden = true
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingView)
        
        butterflyImageView.image = UIImage(systemName: "butterfly") // Симуляция иконки бабочки uicache
        butterflyImageView.tintColor = .cyan
        butterflyImageView.contentMode = .scaleAspectFit
        butterflyImageView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(butterflyImageView)
        
        statusLogLabel.textColor = .white
        statusLogLabel.textAlignment = .center
        statusLogLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        statusLogLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(statusLogLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            butterflyImageView.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            butterflyImageView.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor, constant: -40),
            butterflyImageView.widthAnchor.constraint(equalToConstant: 80),
            butterflyImageView.heightAnchor.constraint(equalToConstant: 80),
            
            statusLogLabel.topAnchor.constraint(equalTo: butterflyImageView.bottomAnchor, constant: 20),
            statusLogLabel.leadingAnchor.constraint(equalTo: loadingView.leadingAnchor, constant: 20),
            statusLogLabel.trailingAnchor.constraint(equalTo: loadingView.trailingAnchor, constant: -20)
        ])
    }

    @objc private func startTapped() {
        // 1. Проверка наличия Standoff 2
        let standoffURL = URL(string: "standoff2://")!
        if !UIApplication.shared.canOpenURL(standoffURL) {
            showAlert(title: "Ошибка", message: "Standoff 2 не найден на устройстве! Запуск заблокирован.")
            return
        }
        
        // 2. Запрос множества разрешений при первом запуске
        requestPermissionsSequence {
            self.showPasswordPrompt()
        }
    }

    private func requestPermissionsSequence(completion: @escaping () -> Void) {
        // Симуляция запроса разрешений
        let alert = UIAlertController(title: "Разрешения", message: "Приложению fever_free-IOS требуются системные права для инъекции Duilib/Dylib бандлов.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Разрешить всё", style: .default, handler: { _ in completion() }))
        present(alert, animated: true)
    }

    private func showPasswordPrompt() {
        let alert = UIAlertController(title: "Безопасность", message: "Введите пароль доступа (7777):", preferredStyle: .alert)
        alert.addTextField { tf in
            tf.isSecureTextEntry = true
            tf.keyboardType = .numberPad
        }
        alert.addAction(UIAlertAction(title: "Подтвердить", style: .default, handler: { [weak self] _ in
            guard let text = alert.textFields?.first?.text else { return }
            if text == "7777" {
                self?.startLoadingSequence()
            } else {
                exit(0) // Вылет при неверном пароле
            }
        }))
        present(alert, animated: true)
    }

    private func startLoadingSequence() {
        loadingView.isHidden = false
        
        // Анимация бабочки (вращение/пульсация в стиле TrollStore uicache)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.butterflyImageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        
        // Симуляция 20-секундной загрузки с логами винтиков/dylib
        let steps = [
            "Initializing Duilib Engine...",
            "Applying UIcache butterfly patches...",
            "Injecting Dylib into Standoff 2 process...",
            "Bypassing system hooks...",
            "Finalizing hooks configuration..."
        ]
        
        for (index, step) in steps.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index * 4)) {
                self.statusLogLabel.text = step
            }
        }
        
        // Результат через 20 секунд (рандомно: успех / ошибка)
        DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
            self.loadingView.isHidden = true
            self.butterflyImageView.layer.removeAllAnimations()
            
            let isSuccessful = Bool.random()
            if isSuccessful {
                self.showAlert(title: "Успех!", message: "Модификация успешно внедрена в игру!")
            } else {
                self.showAlert(title: "Ошибка", message: "Случайный сбой инициализации Dylib. Попробуйте снова.")
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
