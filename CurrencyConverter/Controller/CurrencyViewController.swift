//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController {

  private let currencyViewModel: CurrencyViewModel = CurrencyViewModel()
  private var currencyView: CurrencyView = CurrencyView()
  private var currenciesArray: [TableViewData]?
  private var tempCurrenciesArray: [TableViewData]?
  private var currenciesDict: [String: [TableViewData]]?
  private var tempCurrenciesDict: [String: [TableViewData]]?
  private var isSearching: Bool = false
  private var sectionTitles: [String] = [String]()
  private var dropDownView: DropDownView = DropDownView()

  private lazy var searchBar: UISearchBar = {
    let searchBar = UISearchBar()
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    return searchBar
  }()

  private lazy var currencyTableView: UITableView = {
    var tableView = UITableView()
    let displayWidth: CGFloat = self.view.frame.width
    let displayHeight: CGFloat = self.view.frame.height
    tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
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
    currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.addSubViews([searchBar, dropDownView, currencyTableView])
    
    searchBar.anchor(top: view.margingTop, leading: view.marginLeading,
                     bottom: nil,
                     trailing: view.marginTrailing,
                     inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    dropDownView.anchor(top: searchBar.marginBottom, leading: view.marginLeading,
                          bottom: currencyTableView.topAnchor,
                          trailing: view.marginTrailing,
                          inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    currencyTableView.anchor(top: dropDownView.marginBottom, leading: view.marginLeading,
                             bottom: view.marginBottom, trailing: view.marginTrailing,
                             inset: UIEdgeInsets(top: 10.0, left: 0, bottom: 0, right: 0))
    searchBar.keyboardType = .numberPad

    dropDownView.dataSource = ["EUR", "INR", "USD"]
    searchBar.sizeToFit()

    currencyTableView.delegate = self
    currencyTableView.dataSource = self
    currencyTableView.sectionIndexColor = .black
    currencyTableView.sectionIndexBackgroundColor = .lightGray
    currencyTableView.sectionIndexTrackingBackgroundColor = .gray

    /* // Adding CollectionView to VC's view subviews hierarchy
//    view.addSubview(currencyCollectionView)
//    currencyCollectionView.pinToLayoutGuide(layoutGuide: view.layoutMarginsGuide, constant: 20)
//    currencyCollectionView.delegate = self
//    currencyCollectionView.dataSource = self
     */

    searchBar.delegate = self
    
    currencyViewModel.callFetchCurrencyData { currencyData in
      self.currenciesArray = currencyData.sorted { tableViewData1, tableViewData2 in
        let currencyName1 = tableViewData1.currencyName
        let currencyName2 = tableViewData2.currencyName
        return (currencyName1.localizedCaseInsensitiveCompare(currencyName2) == .orderedAscending)
      }
      self.tempCurrenciesArray = currencyData
      self.currenciesDict = Dictionary(grouping: currencyData, by: {String($0.currencyName.prefix(1))})
      self.sectionTitles = self.currenciesDict?.keys.sorted() ?? [String]()
      self.tempCurrenciesDict = self.currenciesDict
      DispatchQueue.main.async {
        self.currencyTableView.reloadData()
        self.currencyCollectionView.reloadData()
      }
    }
  }
}

extension CurrencyViewController: UITableViewDelegate {

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
      let currencyName1 = tableViewData1.currencyName
      let currencyName2 = tableViewData2.currencyName
      return (currencyName1.localizedCaseInsensitiveCompare(currencyName2) == .orderedAscending)
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
      currenciesDict = currenciesDict.map({ aTableViewData in
        var dict = aTableViewData
        var tableViewDatas: [TableViewData] = [TableViewData]()
        _ = aTableViewData.map { (key: String, value: [TableViewData]) in
          _ = value.map { tableViewData in
            let modifiedValue = tableViewData.currencyValue * (Double(searchText) ?? 1)
            tableViewDatas.append(TableViewData(currencyName: tableViewData.currencyName, currencyValue: modifiedValue))
          }
          dict.updateValue(tableViewDatas, forKey: key)
          tableViewDatas.removeAll()
        }
        return dict
      })
    }
    isSearching = true
    currencyTableView.reloadData()
  }
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    currencyTableView.reloadData()
  }
}
