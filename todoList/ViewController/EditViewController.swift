//
//  EditViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import UIKit

class EditViewController: UIViewController {

    var todoList: CoreData?
    
    
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
        if let vc = segue.destination.children.first as? NewViewController {
            vc.todoList = self.todoList
        }
    }
    

}

extension EditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DataManager.shared.sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DataManager.shared.sectionTitle[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch DataManager.shared.sectionTitle[indexPath.section] {
        case "사진":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UITableViewCell() }
            cell.photo.image = UIImage(data: (todoList?.photo)!)
            return cell
        case "알림 내용":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmContents", for: indexPath) as? AlarmContents else { return UITableViewCell() }
            cell.alarmContentsLabel.text = todoList?.title
            return cell
        case "시간":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTime", for: indexPath) as? AlarmTime else { return UITableViewCell() }
            cell.alarmTimeLabel.text = todoList?.title
            return cell
        default:
            fatalError()
        }
        
    }
    
    
}


// MARK: - 커스텀 셀
class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

class AlarmContents: UITableViewCell {
    
    @IBOutlet weak var alarmContentsLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
}

class AlarmTime: UITableViewCell {
    
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
}
