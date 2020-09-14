//
//  EditTaskViewController.swift
//  NotDefteri
//
//  Created by ibrahim on 12.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit
import MapKit

class EditTaskViewController: UIViewController {
    
    @IBOutlet weak var editTaskTitleLabel: UITextField!
    @IBOutlet weak var editTaskContentLabel: UITextField!
    @IBOutlet weak var editTaskPriority: UISegmentedControl!
    @IBOutlet weak var editTaskMapView: MKMapView!
    
    
    var taskMapView = MKMapView()
    
    var task = Task()
    var taskList:[Task] = []
    var newTask = Task()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editTaskTitleLabel.text = task.title
        editTaskContentLabel.text = task.content
        editTaskPriority.selectedSegmentTintColor = task.priority
        editTaskPriority.selectedSegmentIndex = priorityToIndex(task.priority)
        editTaskMapView = taskMapView
        
        if (task.coordinate.latitude != 0 && task.coordinate.longitude != 0){
            let regionLocation = CLLocation(latitude: task.coordinate.latitude, longitude: task.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion(center: regionLocation.coordinate, latitudinalMeters: 7000, longitudinalMeters: 7000)
            taskMapView.setRegion(coordinateRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = task.coordinate
            taskMapView.addAnnotation(annotation)
        } else {
            taskMapView.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "returnEditToMainSegue"){
            newTask.title = editTaskTitleLabel.text!
            newTask.content = editTaskContentLabel.text!
            newTask.priority = editTaskPriority.selectedSegmentTintColor!
            
            let returnMainController = segue.destination as? ViewController
            
            taskList[task.indexPath] = newTask
            returnMainController?.taskList = taskList
        }
    }
    
    @IBAction func editDoneButton(_ sender: Any) {
        performSegue(withIdentifier: "returnEditToMainSegue", sender: self)
    }
    
    @IBAction func editSegmentButton(_ sender: Any) {
        print("index: ", editTaskPriority.selectedSegmentIndex)
        if (editTaskPriority.selectedSegmentIndex == 0){
            editTaskPriority.selectedSegmentTintColor = .systemGreen
        }
        else if (editTaskPriority.selectedSegmentIndex == 1){
            editTaskPriority.selectedSegmentTintColor = .systemYellow
        } else {
            editTaskPriority.selectedSegmentTintColor = .systemRed
        }
    }
    
    func priorityToIndex(_ priority:UIColor) -> Int {
        if (task.priority == .systemGreen){
            return 0
        }
        else if (task.priority == .systemYellow){
            return 1
        } else {
            return 2
        }
    }
}
