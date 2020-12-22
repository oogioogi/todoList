//
//  ToDoListViewController.swift
//  todoList
//
//  Created by 이용석 on 2020/12/20.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 델리게이트 데이트 소스 연결  [ 셀프: ToDoListViewController ]
        todoTableView.dataSource = self
        todoTableView.delegate = self
        // Do any additional setup after loading the view.
        guard let image = UIImage(named: "running-man")?.pngData() else {return}
        demo(Title: "Main Title", Photo: image)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.shared.fetchToDoList()
        todoTableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = todoTableView.indexPath(for: cell) {
            if let vc = segue.destination as? EditViewController {
                vc.todoList = DataManager.shared.toDoList[indexPath.row]
            }
        }
    }
}

// MARK: - ToDoListViewController DataSource
extension ToDoListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.shared.toDoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoListviewCell", for: indexPath) as? todoListviewCell else { return UITableViewCell() }
        
        let coredata = DataManager.shared.toDoList[indexPath.row]
        cell.todoTitle.text = coredata.title
        guard let photo = coredata.photo else { return UITableViewCell() }
        cell.todoPhoto.image = UIImage(data: photo)
        
        return cell
    }
    
    
}


// MARK: - ToDoListViewController Delegate
extension ToDoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension ToDoListViewController {
    
    func demo(Title title: String, Photo photo: Data){
        DataManager.shared.AddNewMemo(Title: title, Photo: photo)
    }
}

// MARK: - Custom todoListviewCell

class todoListviewCell: UITableViewCell {
    
    @IBOutlet weak var todoPhoto: UIImageView!
    @IBOutlet weak var todoTitle: UILabel!
    @IBOutlet weak var todoSubtitle: UILabel!
    
}


