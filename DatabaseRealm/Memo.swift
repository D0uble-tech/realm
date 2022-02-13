//
//  Memo.swift
//  DatabaseRealm
//
//  Created by Motonari Sakuma on 2022/02/13.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
