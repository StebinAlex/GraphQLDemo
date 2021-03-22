//
//  ViewController.swift
//  GraphQLDemo
//
//  Created by Stebin Alex on 19/03/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var titleLbl: UILabel!

    private var countryPicker = UIPickerView()
    private var viewModel = ViewModel()
    private var countryArray: [GetCountriesListQuery.Data.Country] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        countryPicker = UIPickerView(frame: CGRect(x: 0, y: self.view.frame.height - 300, width: self.view.frame.width, height: 200))
        countryPicker.delegate = self as UIPickerViewDelegate
        countryPicker.dataSource = self as UIPickerViewDataSource
        self.view.addSubview(countryPicker)

        viewModel.recievedCountries = { data in
            self.countryArray = data
            self.countryPicker.reloadAllComponents()
        }

        viewModel.gotDetails = { data in
            DispatchQueue.main.async {
                    self.titleLbl.text = "\(data.name)  \(data.emoji)"
                    self.subLabel.text = "Capital: \(data.capital ?? "") \n Currency: \(data.currency ?? "")"
            }
        }
    }
}


extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return countryArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = countryArray[row].name
       return row
    }

}

extension ViewController:  UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let code = countryArray[row].code
        viewModel.getCountryDetails(code: code)
    }
}
