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
    var oldPhoto: Data?
    var defalutTitle: String?
    var oldTitle: String?
    var token: NSObjectProtocol!
    
    @IBOutlet weak var newTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        token = NotificationCenter.default.addObserver(forName: Notifications.insertedfieldNotification, object: nil, queue: OperationQueue.main, using: { [self] (noti) in
            guard let inserted = noti.userInfo?["inserted"] as? String else {return}
            self.defalutTitle = inserted
            self.newTableView.reloadData()
        })

    }
    
    deinit {
        if let Token = self.token {
            NotificationCenter.default.removeObserver(self, name: Notifications.insertedfieldNotification, object: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if todoList != nil {
            navigationItem.title = "Edit to do List"
            if self.defalutPhoto == oldPhoto {
                self.defalutPhoto = UIImage(data: (todoList?.photo)!)?.pngData()
                oldPhoto = self.defalutPhoto
            }
            
            if self.defalutTitle == oldTitle {
                self.defalutTitle = todoList?.title
                oldTitle = self.defalutTitle
            }
                
           
        }else {
            navigationItem.title = "New to do List"
            if self.defalutPhoto == nil {
                self.defalutPhoto = UIImage(named: "croupier.png")?.pngData()
            }
            if self.defalutTitle == nil {
                self.defalutTitle = "insert title"
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "InsertTitleViewSegue":
            guard let vc = segue.destination as? InsertTitleViewController else {return}
            //vc.insertTitle = self.todoList?.title
            vc.insertTitle = self.defalutTitle
            
        case "InsertTimeViewSegue":
            guard let vc = segue.destination as? InsertTimeViewController else {return}
            //
        default:
            return
        }
    }

    @IBAction func pressCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressSave(_ sender: UIBarButtonItem) {
        // 나중에 다시 클래스로 변수 집합을 만들어 본다
        // 투두 리스트가 닐이 되면 신규 아니면 편집
        if let edit = todoList {
            edit.photo = self.defalutPhoto
            edit.title = self.defalutTitle
            DataManager.shared.saveContext()
            NotificationCenter.default.post(name: Notifications.saveEditCore, object: nil, userInfo: nil)
        }else {
            guard let currentTitle = self.defalutTitle else {return}
            guard let currentPhoto = self.defalutPhoto else {return}
            DataManager.shared.AddNewCoreData(Title: currentTitle, Photo: currentPhoto)
            NotificationCenter.default.post(name: Notifications.saveNewCore, object: nil, userInfo: nil)
        }
        self.dismiss(animated: true, completion: nil)
    }
}



// MARK: - DataSource
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
            
            cell.targetPhoto.image = UIImage(data: self.defalutPhoto!)

            return cell
            
        case "알림 내용":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NEWAlarmContents", for: indexPath) as? NewAlarmContents else { return UITableViewCell() }

            cell.alarmContentsLabel.text = self.defalutTitle

            return cell
            
        case "시간":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewAlarmTime", for: indexPath) as? NEWAlarmTime else { return UITableViewCell() }
            
            return cell
        default:
            fatalError()
        }
    }

}

// MARK: - UITableViewDelegate
extension NewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch DataManager.shared.sectionTitle[indexPath.section] {
        
        case "사진":
            return
        case "알림 내용":
            return
        case "시간":
            return
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
