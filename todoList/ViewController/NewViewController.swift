//
//  NewViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import UIKit

class NewViewController: UIViewController {

    var todoList: CoreData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let source = todoList {
            navigationItem.title = "Edit to do List"
            // ??? = source.photo
            // ??? = source.title
        }else {
            navigationItem.title = "New to do List"
            // ??? = source.photo <- ""
            // ??? = source.title <- ""
        }
        // Do any additional setup after loading the view.
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
