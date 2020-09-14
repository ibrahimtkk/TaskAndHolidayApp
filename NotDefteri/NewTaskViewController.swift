//
//  NewTaskViewController.swift
//  NotDefteri
//
//  Created by ibrahim on 11.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit
import MapKit

class NewTaskViewController: UIViewController, UIGestureRecognizerDelegate, MKMapViewDelegate {

    @IBOutlet weak var englishTextField: UITextField!
    @IBOutlet weak var turkishTextField: UITextField!
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var taskContent: UITextField!
    @IBOutlet weak var newTaskNavigationBar: UINavigationBar!
    @IBOutlet weak var taskSegmentedControl: UISegmentedControl!
    @IBOutlet weak var newTaskMKMapView: MKMapView!
    @IBOutlet weak var newTaskMapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let annotation = MKPointAnnotation()
    
    var task = Task()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskSegmentedControl.selectedSegmentIndex = 1
        taskSegmentedControl.selectedSegmentTintColor = .systemYellow
        let location = CLLocation(latitude: 41.042058, longitude: 28.996780)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 7000, longitudinalMeters: 7000)
        newTaskMKMapView.setRegion(coordinateRegion, animated: true)
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        gestureRecognizer.delegate = self
        newTaskMKMapView.addGestureRecognizer(gestureRecognizer)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        task.title = taskTitle.text!
        task.content = taskTitle.text!
        task.priority = taskSegmentedControl.selectedSegmentTintColor ?? .systemYellow
    }
    
    @objc func handleTap(gestureRecognizer: UILongPressGestureRecognizer) {
        let location = gestureRecognizer.location(in: newTaskMKMapView)
        let coordinate = newTaskMKMapView.convert(location, toCoordinateFrom: newTaskMKMapView)
        self.task.coordinate = coordinate
        
        // Add annotation:
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        newTaskMapView.removeAnnotations(newTaskMapView.annotations)
        newTaskMKMapView.addAnnotation(annotation)
    }
    
    @IBAction func addNewTaskDoneButton(_ sender: Any) {
        if (taskTitle.text != "" && taskContent.text != ""){
            self.performSegue(withIdentifier: "addNewTaskUnwindSegue", sender: nil)
        } else {
            let alert = UIAlertController(title: nil, message: "Boş alan kalamaz", preferredStyle:  .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
    }
    
    @IBAction func backToAllTasksButton(_ sender: Any) {
        self.performSegue(withIdentifier: "addNewTaskUnwindSegue", sender: nil)
    }
    
    @IBAction func taskColorSegmentedControl(_ sender: Any) {
        taskSegmentedControl.selectedSegmentTintColorNew(taskSegmentedControl.selectedSegmentIndex)
    }
}

extension UISegmentedControl {
    func selectedSegmentTintColorNew(_ index: Int) {
        if (index == 0){
            self.selectedSegmentTintColor = .systemGreen
        }
        else if (index == 1){
            self.selectedSegmentTintColor = .systemYellow
        } else {
            self.selectedSegmentTintColor = .systemRed
        }
    }
}
