//
//  TaskDetailViewController.swift
//  NotDefteri
//
//  Created by ibrahim on 12.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit
import MapKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var taskDetailNavigationBar: UINavigationBar!
    @IBOutlet weak var taskDetailContentTexlLabel: UILabel!
    @IBOutlet weak var taskDetailDateTextLabel: UILabel!
    @IBOutlet weak var taskDetailPriorityLabel: UILabel!
    @IBOutlet weak var taskDetailDateMapView: MKMapView!
    
    var task = Task()
    var taskList:[Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskDetailNavigationBar.topItem?.title = task.title
        taskDetailNavigationBar.backgroundColor = task.priority
        taskDetailContentTexlLabel.text = task.content
        
        
        if (task.coordinate.latitude != 0 && task.coordinate.longitude != 0){
            let regionLocation = CLLocation(latitude: task.coordinate.latitude, longitude: task.coordinate.longitude)
            let coordinateRegion = MKCoordinateRegion(center: regionLocation.coordinate, latitudinalMeters: 7000, longitudinalMeters: 7000)
            taskDetailDateMapView.setRegion(coordinateRegion, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = task.coordinate
            taskDetailDateMapView.addAnnotation(annotation)
        } else {
            taskDetailDateMapView.isHidden = true
        }
    }
    
    @IBAction func backToAllTasksButton(_ sender: Any) {
        self.performSegue(withIdentifier: "addNewTaskUnwindSegue", sender: nil)
    }
    
    @IBAction func editTaskButton(_ sender: Any) {
        self.performSegue(withIdentifier: "editTaskSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editTaskSegue") {
            let editTaskController = segue.destination as? EditTaskViewController
            editTaskController?.task = task
            editTaskController?.taskList = taskList
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
