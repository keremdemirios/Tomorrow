
//  ViewController.swift
//  Tomorrow
//
//  Created by Kerem Demır on 10.05.2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: - UI Elements
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var models = [Items]()
    
    public let plansListTableView: UITableView = {
        let plansListTableView = UITableView()
        plansListTableView.translatesAutoresizingMaskIntoConstraints = false
        plansListTableView.register(PlansTableViewCell.self, forCellReuseIdentifier: PlansTableViewCell.cellIdentifier)
        return plansListTableView
    }()
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Goals"
        
        configure()
        getAllItem()
        print(models.count)
        
        let mainRight: () = navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        mainRight
        
        let mainLeft: () = navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        mainLeft
    }
    
    //MARK: - Functions
    private func configure(){
        plansListTableView.delegate = self
        plansListTableView.dataSource = self
        addConstraints()
    }
    
    private func addConstraints(){
        view.addSubview(plansListTableView)
        
        NSLayoutConstraint.activate([
            plansListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plansListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            plansListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            plansListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func getAllItem(){
        let fetchRequest: NSFetchRequest<Items> = Items.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "order", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            models = try context.fetch(fetchRequest)
            
            DispatchQueue.main.async {
                self.plansListTableView.reloadData()
            }
        } catch {
            print("Error at get all item.")
        }
    }
    //MARK: - Core Data Functions
    private func createItem(name:String){
        let newItem = Items(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        
        do{
            try context.save()
            getAllItem()
        }
        catch {
            
        }
    }
    
    private func deleteItem(item: Items){
        context.delete(item)
        
        do{
            try context.save()
            getAllItem()
        }
        catch {
            
        }
        
    }
    
    func updateItem(item: Items, newName: String ){
        item.name = newName
        
        do{
            try context.save()
            getAllItem()
        }
        catch {
         print("Error at update item.")
        }
    }
    
    private func updateItemOrders() {
        for (index, item) in models.enumerated() {
            item.order = Int16(index)
        }
        
        do {
            try context.save()
        } catch {
            print("Error at update item orders.")
        }
    }
    
    //MARK: - Actions
    
    @objc func didTapAdd(){
        
        let alert = UIAlertController(title: "New Item",
                                      message: "Enter New Item",
                                      preferredStyle: .alert
        )
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak self] _ in
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else {
                return
            }
            self?.createItem(name: text)
            print("New Item  : \(text)")
            print("New Count : \(self!.models.count)")
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
    @objc func didTapEdit(){
        if plansListTableView.isEditing { // Edit Off
            plansListTableView.isEditing = false
        }
        else { // Edit On
            plansListTableView.isEditing = true
            navigationItem.leftBarButtonItem?.isHidden = true // Edit Button is hidden
            navigationItem.rightBarButtonItem?.isHidden = true // Add Button is hidden
            let cancelButton: () = navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
            cancelButton
            
            // Save Button
            let saveButton: () = navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
            saveButton
        }
    }
    
    @objc func didTapCancel(){
        plansListTableView.isEditing = false
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = false
        
        let mainLeft: () = navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        mainLeft
        
        let mainRight: () = navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        mainRight
    }
    
    @objc func didTapSave(){
        plansListTableView.isEditing = false
        
        navigationItem.leftBarButtonItem?.isHidden = true
        navigationItem.rightBarButtonItem?.isHidden = true
        
        let mainLeft: () = navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEdit))
        mainLeft
        
        let mainRight: () = navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        mainRight
        
        updateItemOrders()
        
        print("Saved.")
    }
    
}

//MARK: - TableView Delegate Extensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlansTableViewCell.cellIdentifier, for: indexPath) as? PlansTableViewCell else {
            fatalError("Unsupported cell at cellForRowAt.")
        }
        
        cell.planLabel.text = model.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    //MARK: - Maddeye Tiklandiginda Edit ve Delete Kisimlari Cikmasi
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = models[indexPath.row]
        
        let sheet = UIAlertController(title: "Edit",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit Item",
                                          message: "Edit Your Item",
                                          preferredStyle: .alert)
            
            alert.addTextField(configurationHandler: nil)
            alert.textFields?.first?.text = item.name
            
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: { [weak self] _ in
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else {
                    return
                }
                self?.updateItem(item: item, newName: newName)
                
            }))
            self.present(alert, animated: true)
        }))
        
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        
        present(sheet, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = models[indexPath.row]
        
        if (editingStyle == .delete) {
            self.deleteItem(item: item)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedItem = models.remove(at: sourceIndexPath.row)
        models.insert(movedItem, at: destinationIndexPath.row)
    }
}
