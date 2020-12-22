//
//  EditViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import UIKit

class EditViewController: UIViewController {

    var todoList: CoreData?
    let sectionTitle: [String] = ["사진", "알림 내용", "시간"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressDelete(_ sender: UIBarButtonItem) {
        DataManager.shared.deleteToDoList(self.todoList)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewViewController {
            vc.todoList = todoList
        }
    }
    

}

extension EditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sectionTitle[indexPath.section] {
        case "사진":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UITableViewCell() }
            return cell
        case "알림 내용","시간":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as? TextCell else { return UITableViewCell() }
            return cell
        default:
            fatalError()
        }
        
    }
    
    
}

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
}

class TextCell: UITableViewCell {
    
    @IBOutlet weak var stringLabel: UILabel!
    
}
