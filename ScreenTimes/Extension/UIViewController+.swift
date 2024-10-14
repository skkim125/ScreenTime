//
//  UIViewController+.swift
//  ScreenTimes
//
//  Created by 양승혜 on 10/11/24.
//

import UIKit
import RxSwift

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageToDocument(filename: String) -> UIImage? {
        
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return UIImage(systemName: "star.fill")
        }
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
            } catch {
                print("file remove error", error)
            }
            
        } else {
            print("file no exist")
        }
    }
    
    func networkError() {
        let alert = UIAlertController(title: "네트워크 에러", message: "와이파이 설정 필요", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "확인", style: .default) { _ in
            if let url = URL(string: "App-Prefs:root=WIFI"), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func showCustomAlert(message: String) -> Observable<Void> {
        let alertView = CustomAlertView(frame: self.view.bounds)
        self.view.addSubview(alertView)
        
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3) {
            alertView.alpha = 1
        }
        
        return alertView.configure(message: message)
        
    }
}
