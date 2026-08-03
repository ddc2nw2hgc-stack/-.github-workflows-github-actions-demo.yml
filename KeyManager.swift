//
//  Untitled 2.swift
//  fever_free_IOS
//
//  Created by Новий користувач on 03.08.2026.
//

import Foundation

class KeyManager {
    static let shared = KeyManager()
    
    private let activationKeyKey = "saved_activation_key"
    private let expirationTimeKey = "key_expiration_time"

    func validateKey(_ key: String) -> (success: Bool, message: String) {
        let trimmed = key.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmed == "fv_777" {
            saveKeyData(key: trimmed, duration: nil)
            return (true, "Ключ принят! Доступ навсегда.")
        } else if trimmed == "fv_123" {
            saveKeyData(key: trimmed, duration: 20 * 60) // 20 минут
            return (true, "Ключ активирован на 20 минут.")
        } else if trimmed == "fv_523" {
            saveKeyData(key: trimmed, duration: 30 * 60) // 30 минут
            return (true, "Ключ активирован на 30 минут.")
        } else {
            return (false, "Неверный ключ доступа!")
        }
    }
    
    private func saveKeyData(key: String, duration: TimeInterval?) {
        UserDefaults.standard.set(key, forKey: activationKeyKey)
        if let dur = duration {
            let expirationDate = Date().addingTimeInterval(dur)
            UserDefaults.standard.set(expirationDate.timeIntervalSince1970, forKey: expirationTimeKey)
        } else {
            UserDefaults.standard.set(0, forKey: expirationTimeKey) // Навсегда
        }
    }
    
    func isKeyValid() -> Bool {
        guard let savedKey = UserDefaults.standard.string(forKey: activationKeyKey) else { return false }
        if savedKey == "fv_777" { return true }
        
        let expTime = UserDefaults.standard.double(forKey: expirationTimeKey)
        if expTime == 0 { return true }
        
        return Date().timeIntervalSince1970 < expTime
    }
}
