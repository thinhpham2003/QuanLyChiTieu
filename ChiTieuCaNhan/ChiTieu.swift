//
//  ChiTieu.swift
//  ChiTieuCaNhan
//
//  Created by Phạm Quý Thịnh on 02/01/2024.
//

import Foundation
import RealmSwift

class ChiTieu: Object {
    @objc dynamic var id = UUID().uuidString // Khởi tạo ID với giá trị ngẫu nhiên
    @objc dynamic var date = Date()
    @objc dynamic var money = ""
    @objc dynamic var uses = ""
    @objc dynamic var property = ""
    @objc dynamic var note = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
