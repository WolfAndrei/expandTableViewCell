//
//  ViewController.swift
//  expandTableViewCell
//
//  Created by Andrei Volkau on 12.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeAllSectionsCompact()
        configureTableView()
//        listOfItems = fetchData()
    }
    
    //MARK: - Private vars
    
//    private var listOfItems = [List<Parent, Children>]()
    private var hiddenSections = Set<Int>()
    
    //MARK: - UI elements
    
    private let tableView: UITableView = {
       let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    //MARK: - Private
    
    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func makeAllSectionsCompact() {
        for i in 0..<listOfItems.count {
            hiddenSections.insert(i)
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .systemBackground
    }
    
    private func fetchData() -> [List<Parent, Children>] {
        var array = [List<Parent, Children>]()
        if let path = Bundle.main.url(forResource: "ModelJSON", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: path, options: [])
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let jsonResult = jsonResult as? [[String: Any]] {
                    for i in 0..<jsonResult.count {
                        if let title = jsonResult[i]["title"] as? String, let children = jsonResult[i]["children"] as? [[String: Any]] {
                            var childrenArray = [Children]()
                            children.forEach {
                                if let childrenTitle = $0["title"] as? String {
                                    childrenArray.append(Children(title: childrenTitle))
                                }
                            }
                            array.append(List(parent: Parent(title: title), children: childrenArray))
                        }
                    }
                }
            } catch {
                //handle error
            }
        }
        return array
    }
}

//MARK: - Extensions

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        listOfItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listOfItems[section].children.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId, for: indexPath) as? CustomCell {
            let childrenItem = listOfItems[indexPath.section].children[indexPath.row]
            if !self.hiddenSections.contains(indexPath.section) {
                cell.state = .expanded
            } else {
                cell.state = .compact
            }
            cell.configureCell(withData: childrenItem)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !self.hiddenSections.contains(indexPath.section) {
            return UITableView.automaticDimension
        }
        return 0
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if !self.hiddenSections.contains(indexPath.section) {
//            return UITableView.automaticDimension
//        }
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let state: HeaderView.HeaderState = self.hiddenSections.contains(section) ? .compact : .expanded
        let hv = HeaderView(state: state)
        hv.delegate = self
        hv.tag = section
        hv.configureCell(withData: listOfItems[section].parent)
        return hv
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
}

//MARK: - Protocol conformance

extension ViewController: ExpandDelegateProtocol {
    func expand(state: HeaderView.HeaderState, section: Int) {
        if state == .compact {
            hiddenSections.remove(section)
        } else {
            hiddenSections.insert(section)
        }
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
