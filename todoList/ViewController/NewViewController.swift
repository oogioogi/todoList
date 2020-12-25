//
//  NewViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import UIKit

class NewViewController: UIViewController {

    var todoList: CoreData?
    var defalutPhoto: Data?
    var defalutTitle: String?
    var isNew: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if todoList != nil {
            navigationItem.title = "Edit to do List"
            self.isNew = false

        }else {
            navigationItem.title = "New to do List"
            self.isNew = true
            self.defalutPhoto = UIImage(named: "croupier.png")?.pngData()
            self.defalutTitle = "insert title"
            // ??? = source.title <- ""
        }
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

extension NewViewController: UITableViewDataSource  {
    
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewPhotoCell", for: indexPath) as? NewPhotoCell else { return UITableViewCell() }
            
            if let isnew = isNew, isnew == true {
                cell.targetPhoto.image = UIImage(data: self.defalutPhoto!)
                //isNew = false
            }else {
                cell.targetPhoto.image = UIImage(data: (todoList?.photo)!)
            }
            
            return cell
            
        case "알림 내용":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NEWAlarmContents", for: indexPath) as? NewAlarmContents else { return UITableViewCell() }
            
            if let isnew = isNew, isnew == true {
                cell.alarmContentsLabel.text = self.defalutTitle
            }else {
                cell.alarmContentsLabel.text = todoList?.title
            }
            
            return cell
            
        case "시간":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewAlarmTime", for: indexPath) as? NEWAlarmTime else { return UITableViewCell() }
            
            return cell
        default:
            fatalError()
        }
    }
    
    
}

class NewPhotoCell: UITableViewCell /*SourceDelegate*/ {
    
    @IBOutlet weak var targetPhoto: UIImageView!
    
    @IBAction func touchPhotoButton(_ sender: UIButton) {
        
    }
    
}

class NewAlarmContents: UITableViewCell {
    @IBOutlet weak var alarmContentsLabel: UILabel!
    
}

class NEWAlarmTime: UITableViewCell {
    @IBOutlet weak var alarmTimeLabel: UILabel!
    
}
