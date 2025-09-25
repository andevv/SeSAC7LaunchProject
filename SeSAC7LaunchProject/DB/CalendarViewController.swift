//
//  CalendarViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit
import RealmSwift

class CalendarViewController: UIViewController {
 
    var folder: MoneyFolder!
    
    let tableView = UITableView()
    let calendar = UIView()
     
    let realm = try! Realm()
      
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        navigationItem.title = folder?.name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        calendar.backgroundColor = .green
        
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        let search = UIImage(systemName: "magnifyingglass")
        let left = UIBarButtonItem(image: search, style: .plain, target: self, action: #selector(searchBarButtonItemClicked))
        
        navigationItem.rightBarButtonItems = [item, left]
    }
    
    private func configureConstraints() {
        
        calendar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(150)
        }
         
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        vc.folder = folder
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func searchBarButtonItemClicked() {
        print(#function)
    }

}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder.detail.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
         
        let data = folder.detail[indexPath.row]
        
        cell.titleLabel.text = data.money.formatted() + "원"
        cell.subTitleLabel.text = data.type ? "수입" : "지출"
        cell.overviewLabel.text = data.title
        cell.thumbnailImageView.image = loadImageToDocument(filename: "\(data.id)")
        
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        let data = folder.detail[indexPath.row]
        vc.account = data
        navigationController?.pushViewController(vc, animated: true)
        
    }
      
    
}
