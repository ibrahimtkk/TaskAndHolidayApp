//
//  HolidayJSON.swift
//  NotDefteri
//
//  Created by ibrahim on 13.09.2020.
//  Copyright © 2020 ibrahim. All rights reserved.
//

import Foundation

struct HolidayResponse:Decodable {
    var response:Holidays
}

struct Holidays:Decodable {
    var holidays:[HolidayDetail]
}

struct HolidayDetail:Decodable {
    var name:String
    var date:DateInfo
}

struct DateInfo:Decodable {
    var iso:String
}
