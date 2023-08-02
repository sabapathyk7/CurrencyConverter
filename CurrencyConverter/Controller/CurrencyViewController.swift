//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 26/06/23.
//

import UIKit

class CurrencyViewController: UIViewController {

  private let currencyViewModel: CurrencyViewModel = CurrencyViewModel()
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

  private var currencyData: CurrencyData?

  override func viewDidLoad() {
    super.viewDidLoad()

    let displayWidth: CGFloat = self.view.frame.width
    let displayHeight: CGFloat = self.view.frame.height
    currencyTableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
    currencyTableView.register(CurrencyCell.self, forCellReuseIdentifier: "CurrencyCell")
//    view.addSubview(currencyTableView)
//    currencyTableView.delegate = self
//    currencyTableView.dataSource = self

    view.addSubview(currencyCollectionView)
    currencyCollectionView.delegate = self
    currencyCollectionView.dataSource = self
    currencyCollectionView.pinToLayoutGuide(layoutGuide: view.layoutMarginsGuide, constant: 20)

//    if let flowLayout = currencyCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//        flowLayout.scrollDirection = .horizontal
//    }
    currencyViewModel.callFetchCurrencyData { currencyData in
      self.currencyData = currencyData
      DispatchQueue.main.async {
        self.currencyTableView.reloadData()
      }
    }
  }
}

extension CurrencyViewController: UITableViewDelegate {

}

extension CurrencyViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyData?.rates.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as? CurrencyCell else {
      return UITableViewCell()
    }
    guard let currencies = currencyData?.rates else {
      return UITableViewCell()
    }
    let key = Array(currencies)[indexPath.row].key
    let value = String(format: "%f", Array(currencies)[indexPath.row].value)
    cell.update(with: key, value: value)
    return cell
  }
}

extension CurrencyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return currencyData?.rates.count ?? 0
  }

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyCollectionViewCell", for: indexPath)
            as? CurrencyCollectionViewCell else {
      return UICollectionViewCell()
    }
    guard let currencies = currencyData?.rates else {
      return UICollectionViewCell()
    }
    let key = Array(currencies)[indexPath.row].key
    let value = String(format: "%f", Array(currencies)[indexPath.row].value)
    cell.update(with: key, value: value)
    return cell
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let widthDiv = 1.0
    let heightDiv = 4.0
    print("Width ", collectionView.frame.size.width, " Height ", collectionView.frame.size.height)
    print(widthDiv, collectionView.frame.size.width/widthDiv, heightDiv, collectionView.frame.size.height/heightDiv)
    return CGSize(width: collectionView.frame.size.width/widthDiv, height: collectionView.frame.size.height/heightDiv)
  }
}
