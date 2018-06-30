//
//  Category.swift
//  Todoey
//
//  Created by Vanessa Flores on 6/30/18.
//  Copyright © 2018 Vanessa Flores. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
