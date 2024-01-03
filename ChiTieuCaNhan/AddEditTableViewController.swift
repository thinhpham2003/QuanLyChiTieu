//
//  AddEditTableViewController.swift
//  Quản Lý Chi Tiêu
//
//  Created by Phạm Quý Thịnh on 29/12/2023.
//

import UIKit
import RealmSwift
class AddEditTableViewController: UITableViewController {
    var chitieu: ChiTieu?
    var id: String?
    init?(coder: NSCoder, chitieu: ChiTieu?, id: String?) {
        self.chitieu = chitieu
        self.id = id
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    @IBOutlet var dateDTP: UIDatePicker!
    @IBOutlet var propertySM: UISegmentedControl!
    @IBOutlet var moneyTXT: UITextField!
    @IBOutlet var usesTXT: UITextField!
    @IBOutlet var noteTXT: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        if let chitieu = chitieu{
            dateDTP.date = chitieu.date
            if(chitieu.property == "-"){
                propertySM.selectedSegmentIndex = 1
            }
            else{
                propertySM.selectedSegmentIndex = 0
            }
            moneyTXT.text = chitieu.money
            usesTXT.text = chitieu.uses
            noteTXT.text = chitieu.note

            title = "Thông tin chi tiết"
        }
        else{
            title = "Thêm mới"
        }
    }

    func saveChiTieuToDatabase() {
        let dateValue = dateDTP.date
        var propertyValue: String = ""
        if (propertySM.selectedSegmentIndex) == 1 {
            propertyValue = "-"
        } else {
            propertyValue = "+"
        }
        let moneyValue = moneyTXT.text ?? ""
        let usesValue = usesTXT.text ?? ""
        let noteValue = noteTXT.text ?? ""

        do {
            let realm = try Realm()

            if let chiTieuToUpdate = realm.objects(ChiTieu.self).filter("id == %@", id).first {
                try realm.write {
                    chiTieuToUpdate.date = dateValue
                    chiTieuToUpdate.money = moneyValue
                    chiTieuToUpdate.uses = usesValue
                    chiTieuToUpdate.property = propertyValue
                    chiTieuToUpdate.note = noteValue
                }
            } else {
                let chiTieu = ChiTieu()
                chiTieu.date = dateValue
                chiTieu.money = moneyValue
                chiTieu.uses = usesValue
                chiTieu.property = propertyValue
                chiTieu.note = noteValue
                print(chiTieu.id)
                print(chiTieu.date)
                try realm.write {
                    realm.add(chiTieu)
                }
            }
        } catch {
            print("Error saving ChiTieu to database: \(error)")
        }
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        saveChiTieuToDatabase()
        tableView.reloadData()

    }

}
