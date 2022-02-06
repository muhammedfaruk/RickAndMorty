//
//  FilterSettingsVC.swift
//  RickAndMorty
//
//  Created by Muhammed Faruk Söğüt on 3.02.2022.
//

import UIKit

protocol FilterSettingsVCDelegate {
    func didTapSearchButton(gender:String,status:String,species:String)
}


class FilterSettingsVC: UIViewController, UITextFieldDelegate {
   
    let stackView1  = MyCustomStackView()
    let stackView2  = MyCustomStackView()
    let stackView3  = MyCustomStackView()
        
    let genderLabel     = MyCustomLabel(textAlignment: .left, fontSize: 26, weight: .regular)
    let statusLabel     = MyCustomLabel(textAlignment: .left, fontSize: 26, weight: .regular)
    let speciesLabel    = MyCustomLabel(textAlignment: .left, fontSize: 26, weight: .regular)
    
    let genderTextField  = MyCustomTextField(placeholder_: "Female")
    let statusTextField  = MyCustomTextField(placeholder_: "Alive")
    let speciesTextField = MyCustomTextField(placeholder_: "Human")
    
    var activeArray     = [String]()
    var gender          : [String] = ["Female", "Male", "Genderless", "unknown"]
    var status          : [String] = ["Alive", "Dead","unknown"]
    var species         : [String] = ["Human", "Alien", "Humanoid"]
    
    var selectedfilter  : String = ""
    var activeTextField = UITextField()
    
    let toolBar         = UIToolbar()
    let picker          = UIPickerView()
    let searchButton    = MyCustomButton(title: "Search")
    
    var delegate : FilterSettingsVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureLayout()
        configurePickerView()
        configureToolBar()
        searchButton.addTarget(self, action: #selector(searchBtnTapped), for: .touchUpInside)
    }
    
    private func configurePickerView(){
        picker.delegate = self
        picker.dataSource = self
    }
    
    
    @objc private func searchBtnTapped(){
                                    
        let gender  = genderTextField.text!.isEmpty ? "Female" : genderTextField.text!
        let species = speciesTextField.text!.isEmpty ? "Human" : speciesTextField.text!
        let status  = statusTextField.text!.isEmpty ? "Alive" : statusTextField.text!

        dismiss(animated: true)
        delegate?.didTapSearchButton(gender: gender, status: status, species: species)
    }
    
    private func configureToolBar() {
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
        toolBar.setItems([spaceButton,doneButton], animated: true)
        
        genderTextField.delegate    = self
        statusTextField.delegate    = self
        speciesTextField.delegate   = self
    }
        
    // when user begin editing on textfield this method find which textfield tapped and set related items with text field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.inputAccessoryView = toolBar
        textField.inputView = picker
        
        self.activeTextField = textField
        let placeholder = textField.placeholder
        
        if placeholder == "Human" {
            activeArray = species
        }else if placeholder == "Female" {
            activeArray = gender
        }else if placeholder == "Alive" {
            activeArray = status
        }
        picker.reloadAllComponents()
    }
        
    @objc func didTapDoneButton() {
        activeTextField.text = selectedfilter
        view.endEditing(true)
    }

}

// MARK: PickerView Data Settings
extension FilterSettingsVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activeArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activeArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedfilter = activeArray[row]
    }
    
}

// MARK: Design
extension FilterSettingsVC {
    func configureLayout(){
        view.addSubview(stackView1)
        genderLabel.text = "Gender"
        stackView1.addArrangedSubview(genderLabel)
        stackView1.addArrangedSubview(genderTextField)
        
        view.addSubview(stackView2)
        statusLabel.text = "Status"
        stackView2.addArrangedSubview(statusLabel)
        stackView2.addArrangedSubview(statusTextField)
        
        view.addSubview(stackView3)
        speciesLabel.text = "Species"
        stackView3.addArrangedSubview(speciesLabel)
        stackView3.addArrangedSubview(speciesTextField)
        
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            
            stackView1.bottomAnchor.constraint(equalTo: stackView2.topAnchor, constant: -20),
            stackView1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView1.heightAnchor.constraint(equalToConstant: 50),
            
            stackView2.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView2.heightAnchor.constraint(equalToConstant: 50),
            
            stackView3.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 20),
            stackView3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            stackView3.heightAnchor.constraint(equalToConstant: 50),
            
            searchButton.topAnchor.constraint(equalTo: stackView3.bottomAnchor, constant: 20),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
