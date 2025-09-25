//
//  DetailViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
     
    var account: Account?
    
    let moneyField = UILabel()
    let categoryField = UILabel()
    let memoField = UILabel()
    let photoImageView = UIImageView()
    
    let titleTextField = UILabel()
    let contentTextField = UILabel()
         
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .white
        view.addSubview(moneyField)
        view.addSubview(categoryField)
        view.addSubview(memoField)
        view.addSubview(photoImageView)
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
    }
     
    @objc func deleteButtonClicked() {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        
        titleTextField.text = account?.title
        contentTextField.text = account?.type == true ? "수입" : "지출"
        moneyField.text = account?.money.formatted()
        
        photoImageView.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(deleteButtonClicked))

    }
    
     func configureConstraints() {
         
         moneyField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
         categoryField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
             make.top.equalTo(moneyField.snp.bottom).offset(20)
        }
        
         memoField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
             make.top.equalTo(categoryField.snp.bottom).offset(20)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view)
            make.top.equalTo(memoField.snp.bottom).offset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
        
    }
    

}
