//
//  ViewController.swift
//  NotDefteri
//
//  Created by ibrahim on 11.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var taskTableView: UITableView!
    
    @IBOutlet weak var newTaskOutletButton: UIButton!
    
    var indexPath = 0
    
    var taskList:[Task] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskTableView.dataSource = self
        taskTableView.delegate = self
    }
    
    @IBAction func unwindToNewTask(_ unwindSegue: UIStoryboardSegue) {
        if let vc = unwindSegue.source as? NewTaskViewController{
            let newTask = Task()
            newTask.title = vc.task.title
            newTask.content = vc.task.content
            newTask.priority = vc.task.priority
            newTask.coordinate = vc.task.coordinate
            
            taskList.append(newTask)
            
            self.taskTableView.beginUpdates()
            self.taskTableView.insertRows(at: [IndexPath(row: self.taskList.count-1, section: 0)], with: .automatic)
            self.taskTableView.endUpdates()
            
        }
    }
    
    @IBAction func newTaskCreateButton(_ sender: Any) {
        performSegue(withIdentifier: "newTaskSegue", sender: self)
    }
    
    @IBAction func holidayButton(_ sender: Any) {
        performSegue(withIdentifier: "holidaySegue", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "taskDetailSegue") {
            let taskDetailViewController = segue.destination as! TaskDetailViewController
            
            let newTask = Task()
            newTask.title = taskList[self.indexPath].title
            newTask.content = taskList[self.indexPath].content
            newTask.priority = taskList[self.indexPath].priority
            newTask.coordinate = taskList[self.indexPath].coordinate
            newTask.indexPath = self.indexPath
            
            taskDetailViewController.task = newTask
            taskDetailViewController.taskList = taskList
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskTableViewCell
        taskCell.tastCellTextLabel.text = self.taskList[indexPath.row].title
        taskCell.taskContentTextLabel.text = self.taskList[indexPath.row].content
        taskCell.taskColorTextLabel.backgroundColor = self.taskList[indexPath.row].priority
        return taskCell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteTitle = "Listeden sil"
        let deleteAction = UIContextualAction(style: .destructive, title: deleteTitle) { (action, view, completion) in

            tableView.beginUpdates()
            self.taskList.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .automatic)

            tableView.endUpdates()
            completion(true)
        }
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.backgroundColor = .systemRed
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editTitle = "Düzenle"
        let editAction = UIContextualAction(style: .normal, title: editTitle) { (action, view, completion) in
            _ = tableView.cellForRow(at: indexPath)
            completion(true)
        }
        editAction.image = UIImage(systemName: "heart.slash.fill")
        editAction.backgroundColor = .systemYellow
        
        
        
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
        self.performSegue(withIdentifier: "taskDetailSegue", sender: self)
    }
}

