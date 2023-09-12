//
//  CurrencyTCAViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 23/08/23.
//

import UIKit
import ComposableArchitecture
import Combine

final class CurrencyTCAViewController: UIViewController {
    typealias Currencies = [TableViewData]
    private var cancellables: Set<AnyCancellable> = []

    let store: StoreOf<CurrencyConverter>
    let viewStore: ViewStoreOf<CurrencyConverter>

    private var currenciesArray: Currencies?
    private var currenciesDict: [String: Currencies]?
    private var tempCurrenciesDict: [String: Currencies]?
    private var sectionTitles: [String] = [String]()
    private var dropDownView: DropDownView = DropDownView()
    private let child: SpinnerViewController = SpinnerViewController()
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
    override func viewDidLoad() {
        super.viewDidLoad()
        createSpinnerView()
        view.backgroundColor = .white
        self.viewStore.send(.onAppear)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [self] in
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            setupUI()
            self.viewStore.publisher.currencies
              .sink(receiveValue: { [weak self] _ in
                  self?.currencyTableView.reloadData()
              })
              .store(in: &self.cancellables)
            self.currencyTableView.reloadData()
        })
    }
    init(store: StoreOf<CurrencyConverter>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 })
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSpinnerView() {
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    private func setupUI() {
        view.addSubViews([textField, dropDownView, currencyTableView])
        updateConstraints()
        textField.text = "1"
        textField.delegate = self
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        dropDownView.delegate = self
        currencyTableView.sectionIndexColor = UIColor(red: 58/255, green: 131/255, blue: 247/255, alpha: 1.0)
        view.bringSubviewToFront(dropDownView)
    }
    private func updateConstraints() {
        textField.anchor(top: view.marginTop,
                         leading: view.marginLeading,
                         trailing: dropDownView.marginLeading,
                         inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        textField.anchorDimension(height: textField.marginHeight,
                                  inset: UIEdgeInsets(top: 0, left: 0, bottom: 40.0, right: 0))
        dropDownView.anchor(top: view.marginTop,
                            trailing: view.marginTrailing)
        dropDownView.anchorDimension(width: dropDownView.marginWidth,
                                     inset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 80.0))
        currencyTableView.anchor(top: textField.marginBottom,
                                 leading: view.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 trailing: view.safeAreaLayoutGuide.trailingAnchor,
                                 inset: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0))
    }
}
extension CurrencyTCAViewController: UITableViewDelegate {
}
extension CurrencyTCAViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        self.dropDownView.dataSource = self.viewStore.initialCurrencies.map {
            return $0.currencyCode
        }
        self.currenciesDict = Dictionary(grouping: self.viewStore.initialCurrencies, by: {String($0.currencyName.prefix(1))})
        self.sectionTitles = self.currenciesDict?.keys.sorted() ?? [String]()
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

//        return self.viewStore.currencies.count
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
extension CurrencyTCAViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text
        guard let stringRange = Range(range, in: currentText ?? "1") else {
            return false
        }
        guard let updatedText = currentText?.replacingCharacters(in: stringRange, with: string) else {
            return false
        }
        self.viewStore.send(.quantityTextFieldEntered(updatedText))
        currencyTableView.reloadData()
        return true
    }
}
extension CurrencyTCAViewController: DropDownDelegate {
    func didSelect(_ index: Int, _ base: String) {
        self.viewStore.send(.countryCodePickerSelected(base))
    }
}
