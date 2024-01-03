//
//  ChiTieuTableViewController.swift
//  Quản Lý Chi Tiêu
//
//  Created by Phạm Quý Thịnh on 28/12/2023.
//

import UIKit
import Foundation
import RealmSwift
class ChiTieuTableViewController: UITableViewController {
//    let realm = try! Realm()
//
//    let chitieus = realm.objects(ChiTieu.self)
    var chitieus : [ChiTieu] = []
    @IBOutlet var addBT: UIBarButtonItem!
    @IBOutlet var editBT: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.reloadData()
        let realm = try! Realm()
        chitieus = Array(realm.objects(ChiTieu.self))
    }

    @IBSegueAction func addEdit(_ coder: NSCoder, sender: Any?) -> AddEditTableViewController? {

        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Editing ChiTieu
            let chiTieuToEdit = chitieus[indexPath.row]
            return AddEditTableViewController(coder: coder, chitieu: chiTieuToEdit, id: chiTieuToEdit.id)
        } else {
            // Adding Emoji
            return AddEditTableViewController(coder: coder, chitieu: nil, id: "")
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chitieus.count
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChiTieuCell", for: indexPath) as! ChiTieuTableViewCell
        let chitieu = chitieus[indexPath.row]
        cell.update(with: chitieu)
        cell.showsReorderControl = true
        return cell
    }


    //Xoá
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            do {
                let realm = try Realm()
                if let chiTieuToDelete = realm.objects(ChiTieu.self).filter("id == %@", chitieus[indexPath.row].id).first {
                    try realm.write {
                        realm.delete(chiTieuToDelete)
                    }
                }
            } catch {
                print("Error deleting ChiTieu from database: \(error)")
            }
            chitieus.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    //Chỉnh sửa
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let move = chitieus.remove(at: fromIndexPath.row)
        chitieus.insert(move, at: to.row)
    }


    @IBAction func editBtnClick(_ sender: Any) {
        let tableviewEditingMode = tableView.isEditing
        tableView.setEditing(!tableviewEditingMode, animated: true)

    }


    @IBAction func unwindToChiTieuView(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }

        do {
            let realm = try Realm()
            chitieus = Array(realm.objects(ChiTieu.self))
            tableView.reloadData()
        } catch {
            print("Error loading ChiTieu from database: \(error)")
        }
    }


}
