//
//  AddPlanScreenViewController.swift
//  Tomorrow
//
//  Created by Kerem Demır on 10.05.2023.
//

import UIKit

class AddPlanScreenViewController: UIViewController {

    //MARK: - UI Elements
    
    private let planLabel:UILabel = {
        let planLabel = UILabel()
        planLabel.translatesAutoresizingMaskIntoConstraints = false
        planLabel.text = "Goal"
        planLabel.textColor = .lightGray
        planLabel.font = .systemFont(ofSize: 18, weight: .medium)
        return planLabel
    }()
    
    private let orderImportantLabel:UILabel = {
        let orderImportantLabel = UILabel()
        orderImportantLabel.translatesAutoresizingMaskIntoConstraints = false
        orderImportantLabel.textColor = .lightGray
        orderImportantLabel.text = "Order of Importance"
        orderImportantLabel.font = .systemFont(ofSize: 18, weight: .medium)
        return orderImportantLabel
    }()
    
    private let planTextField: UITextField = {
        let planTextField = UITextField()
        planTextField.translatesAutoresizingMaskIntoConstraints = false
        planTextField.textColor = .label
        planTextField.layer.borderWidth = 1
        planTextField.layer.borderColor = UIColor.lightGray.cgColor
        planTextField.layer.cornerRadius = 8
        planTextField.textAlignment = .center
        planTextField.placeholder = "Write Your Goal"
        return planTextField
    }()
    
    private let orderImportantTextField: UITextField = {
        let orderImportantTextField = UITextField()
        orderImportantTextField.translatesAutoresizingMaskIntoConstraints = false
        orderImportantTextField.textColor = .label
        orderImportantTextField.layer.borderWidth = 1
        orderImportantTextField.layer.borderColor = UIColor.lightGray.cgColor
        orderImportantTextField.layer.cornerRadius = 8
        orderImportantTextField.textAlignment = .center
        orderImportantTextField.placeholder = "Order of Important"
        return orderImportantTextField
    }()
    
    //MARK: - Properties
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Add"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done" , style: .done, target: self, action: #selector(doneClicked))
        configure()
        
    }

    
    //MARK: - Functions
    
    private func configure(){
        addConstraints()
    }
    
    private func addConstraints(){
        view.addSubview(planLabel)
        view.addSubview(orderImportantLabel)
        view.addSubview(planTextField)
        view.addSubview(orderImportantTextField)
        
        NSLayoutConstraint.activate([
            planLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            planLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            planLabel.widthAnchor.constraint(equalToConstant: 50),
            planLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            planTextField.topAnchor.constraint(equalTo: planLabel.safeAreaLayoutGuide.topAnchor, constant: 40),
            planTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            planTextField.heightAnchor.constraint(equalToConstant: 40),
            planTextField.widthAnchor.constraint(equalToConstant: 350),
            
            
            orderImportantLabel.topAnchor.constraint(equalTo: planTextField.safeAreaLayoutGuide.topAnchor, constant: 100),
            orderImportantLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            orderImportantLabel.widthAnchor.constraint(equalToConstant: 200),
            orderImportantLabel.heightAnchor.constraint(equalToConstant: 30),
            
            
            orderImportantTextField.topAnchor.constraint(equalTo: orderImportantLabel.safeAreaLayoutGuide.topAnchor, constant: 40),
            orderImportantTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            orderImportantTextField.heightAnchor.constraint(equalToConstant: 40),
            orderImportantTextField.widthAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    //MARK: - Actions
    @objc func doneClicked(){
        print("Add plans and back to home page.")
        
        let homeVC = ViewController()
        navigationController?.pushViewController(homeVC, animated: true)
        
        // Anasayfaya gittikten sonra back tusu kaldirilacak. Veya sadece uste cikmali sekme acilcak.
        
        print("Kaydedildi.")
    }
}

