//
//  InsertTitleViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/25.
//

import UIKit

class InsertTitleViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    var insertTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Insert Title"
        textField.text = insertTitle
        // Do any additional setup after loading the view.
    }
    
    @IBAction func insertText(_ sender: Any) {
        let inserted: [AnyHashable: Any] = ["inserted" : textField.text!]
        NotificationCenter.default.post(name: InsertTitleViewController.notificationName, object: nil, userInfo: inserted)
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InsertTitleViewController {
    static let notificationName = Notification.Name("insertedfieldNotification")
}
