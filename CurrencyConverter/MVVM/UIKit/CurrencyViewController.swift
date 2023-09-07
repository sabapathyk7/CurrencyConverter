//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController {

    private let currencyViewModel: CurrencyViewModel = CurrencyViewModel()
    private var currenciesArray: [TableViewData]?
    private var currenciesDict: [String: [TableViewData]]?
    private var tempCurrenciesDict: [String: [TableViewData]]?
    private var isSearching: Bool = false
    private var sectionTitles: [String] = [String]()
    private var dropDownView: DropDownView = DropDownView()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.keyboardType = .numberPad
        searchBar.sizeToFit()
        return searchBar
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter value"
        textField.borderStyle = .roundedRect
        textField.tintColor = .blue
        return textField
    }()

    private lazy var currencyTableView: UITableView = {
        var tableView = UITableView()
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
        return tableView
    }()

    private lazy var currencyCollectionView: UICollectionView = {
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        var collectionView = UICollectionView(frame:
                                                CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight),
                                              collectionViewLayout: layout)
        collectionView.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "CurrencyCollectionViewCell")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchDataFromVM()
    }
    func fetchDataFromVM() {
        currencyViewModel.callFetchCurrencyData { currencyData   in
            self.currenciesArray = currencyData
            self.currenciesDict = Dictionary(grouping: currencyData, by: {String($0.currencyName.prefix(1))})
            self.sectionTitles = self.currenciesDict?.keys.sorted() ?? [String]()
            self.dropDownView.dataSource = currencyData.map { return $0.currencyCode }
            self.tempCurrenciesDict = self.currenciesDict
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
                self.currencyCollectionView.reloadData()
            }
        }
    }
    func setupUI() {
        view.backgroundColor = .white
        textField.delegate = self
        view.addSubViews([textField, dropDownView, currencyTableView])
        textField.anchor(top: view.margingTop,
                         leading: view.marginLeading,
                         trailing: dropDownView.marginLeading,
                         inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        textField.anchorDimension(height: textField.marginHeight,
                                  inset: UIEdgeInsets(top: 0, left: 0, bottom: 40.0, right: 0))
        textField.text = "1"
        dropDownView.anchor(top: view.margingTop,
                            trailing: view.marginTrailing)
        dropDownView.anchorDimension(width: dropDownView.marginWidth,
                                     inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 80.0))
        currencyTableView.anchor(top: textField.marginBottom,
                                 leading: view.marginLeading,
                                 bottom: view.marginBottom,
                                 trailing: view.marginTrailing,
                                 inset: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencyTableView.sectionIndexColor = .black
        currencyTableView.sectionIndexBackgroundColor = .lightGray
        view.bringSubviewToFront(dropDownView)
        /* // Adding CollectionView to VC's view subviews hierarchy
         view.addSubview(currencyCollectionView)
         currencyCollectionView.pinToLayoutGuide(layoutGuide: view.layoutMarginsGuide, constant: 20)
         currencyCollectionView.delegate = self
         currencyCollectionView.dataSource = self
         */
    }
}

extension CurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: view.frame.origin.x, y: view.frame.origin.y, width: view.frame.width, height: view.frame.height))
        returnedView.backgroundColor = .blue
        let label = UILabel(frame: CGRect(x: view.frame.origin.x+10, y: view.frame.origin.y+5, width: view.frame.width/3, height: 20))
        label.textAlignment = .natural
        label.text = sectionTitles[section]

        returnedView.addSubview(label)
        return returnedView
    }
}

extension CurrencyViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sectionTitles[section]
    }
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sectionTitles
    }
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        index
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesDict?[sectionTitles[section]]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        guard let model = currenciesDict?[sectionTitles[indexPath.section]]?.sorted(by: { tableViewData1, tableViewData2 in
            tableViewData1.currencyName.localizedCaseInsensitiveCompare(tableViewData2.currencyName) == .orderedAscending
        })[indexPath.row] else {
            return UITableViewCell()
        }
        cell.update(with: model)
        return cell
    }

}

extension CurrencyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currenciesArray?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath)
                as? CurrencyCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let model = currenciesArray?[indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.update(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthDiv = 1.0
        let heightDiv = 4.0
        return CGSize(width: collectionView.frame.size.width/widthDiv, height: collectionView.frame.size.height/heightDiv)
    }
}

extension CurrencyViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.currenciesDict = self.tempCurrenciesDict
        } else {
            currenciesDict = tempCurrenciesDict
            currenciesDict = currencyViewModel.convertCurrency(by: searchText, currenciesDict: currenciesDict)
        }
        isSearching = true
        currencyTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        currencyTableView.reloadData()
    }
}

extension CurrencyViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text
        guard let stringRange = Range(range, in: currentText ?? "1") else {
            return false
        }
        guard let updatedText = currentText?.replacingCharacters(in: stringRange, with: string) else {
            return false
        }
        if updatedText.isEmpty {
            self.currenciesDict = self.tempCurrenciesDict
        } else {
            currenciesDict = tempCurrenciesDict
            currenciesDict = currencyViewModel.convertCurrency(by: updatedText, currenciesDict: currenciesDict)
            //      currenciesDict?.values.forEach({ TVD in
            //        TVD.forEach { tableViewData in
            //          var tvd = tableViewData
            //          tvd.currencyValue.advance(by: Double(updatedText) ?? 1.0)
            //        }
            //      })
        }
        isSearching = true
        currencyTableView.reloadData()
        return true
    }
}

extension Double {
    mutating func advance(by value: Double) {
        self *= value
    }
}
