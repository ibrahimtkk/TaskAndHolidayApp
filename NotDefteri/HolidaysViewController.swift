//
//  HolidaysViewController.swift
//  NotDefteri
//
//  Created by ibrahim on 13.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import UIKit

class HolidaysViewController: UIViewController {
    
    @IBOutlet weak var holidayTableView: UITableView!
    @IBOutlet weak var holidaySearchBar: UISearchBar!
    
    
    var listOfHolidays = [HolidayDetail]() {
        didSet {
            DispatchQueue.main.async {
                self.holidayTableView.reloadData()
                
                let message = "\(self.listOfHolidays.count) Holidays Found"
                let alert = UIAlertController(title:nil, message: message, preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                
                let when = DispatchTime.now() + 1
                DispatchQueue.main.asyncAfter(deadline: when){
                  // your code with delay
                  alert.dismiss(animated: true, completion: nil)
                }
                
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holidaySearchBar.delegate = self
        holidayTableView.dataSource = self
        holidayTableView.delegate = self
    }

}

extension HolidaysViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else {return}
        let holidayRequest = HolidayRequest(countryCode: searchBarText)
        holidayRequest.getHolidaysRequest { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let holidays):
                self?.listOfHolidays = holidays
            }
            
        }
    }
}

extension HolidaysViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let holidayCell = holidayTableView.dequeueReusableCell(withIdentifier: "holidaysCell", for: indexPath) as! HolidayTableViewCell
        
        let holiday = listOfHolidays[indexPath.row]
        
        holidayCell.holidayName.text = holiday.name
        holidayCell.holidayDetail.text = holiday.date.iso
        
        return holidayCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfHolidays.count
    }
}
