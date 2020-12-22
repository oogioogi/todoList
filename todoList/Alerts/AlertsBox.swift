//
//  AlertsBox.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import Foundation
import UIKit

class AlertsBox: UIViewController {
    
    func warringBox( Title title: String, Message message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let summit = UIAlertAction(title: title, style: .default, handler: nil)
        let canel = UIAlertAction(title: title, style: .cancel, handler: nil)
        
        alert.addAction(summit)
        alert.addAction(canel)
        
        present(alert, animated: true, completion: nil)
    }

}
