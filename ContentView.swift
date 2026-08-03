import SwiftUI

struct ContentView: View {
    @State private var isAuthorized = KeyManager.shared.isKeyValid()
    @State private var inputKey = ""
    @State private var errorMessage = ""

    var body: some View {
        if isAuthorized {
            // Главный интерфейс с вкладками после успешной авторизации ключа
            TabView {
                MainContainerViewControllerRepresentable()
                    .tabItem {
                        Image(systemName: "flame.fill")
                        Text("Fever")
                    }
                
                SettingsViewControllerRepresentable()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Настройки")
                    }
            }
            .accentColor(.cyan)
        } else {
            // Экран ввода ключа при первом запуске
            ZStack {
                Color(red: 0.03, green: 0.08, blue: 0.18)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text("fever_free-IOS")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.cyan)
                    
                    Text("Введите ключ для активации доступа")
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                    
                    SecureField("Введите ключ (например: fv_777)", text: $inputKey)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 40)
                        .autocapitalization(.none)
                    
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.system(size: 13))
                    }
                    
                    Button(action: {
                        let result = KeyManager.shared.validateKey(inputKey)
                        if result.success {
                            isAuthorized = true
                        } else {
                            errorMessage = result.message
                        }
                    }) {
                        Text("Активировать")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    .padding(.top, 10)
                }
            }
        }
    }
}

// Мосты для интеграции UIKit контроллеров в SwiftUI TabView
struct MainContainerViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {}
}

struct SettingsViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> SettingsViewController {
        return SettingsViewController()
    }
    func updateUIViewController(_ uiViewController: SettingsViewController, context: Context) {}
}
