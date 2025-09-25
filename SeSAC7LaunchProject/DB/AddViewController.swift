//
//  AddViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by Jack on 9/18/25.
//

import UIKit
import PhotosUI
import SnapKit
import RealmSwift

class AddViewController: UIViewController {
    
    var folder: MoneyFolder?
    let repository = AccountRepository()
     
    let moneyField = UITextField()
    let categoryField = UITextField()
    let memoField = UITextField()
    let photoImageView = UIImageView()
    let addButton = UIButton()
    
    let titleTextField = UITextField()
    let contentTextField = UITextField()
             
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
        view.addSubview(addButton)
        view.addSubview(titleTextField)
        view.addSubview(contentTextField)
    }
    
    @objc func addButtonClicked() {
        print(#function)
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)

    }
  
    @objc func saveButtonClicked() {
        print(#function)
        
        if titleTextField.text!.isEmpty {
            print("필수값입니다.")
        } else {
            
            repository.creatAccount(title: titleTextField.text!, folder: folder!.id)
            
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    private func configureView() {
        
        titleTextField.placeholder = "제목을 입력해보세요"
        contentTextField.placeholder = "내용을 입력해보세요"
        
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("이미지 추가", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        photoImageView.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        memoField.placeholder = "메모를 입력해보세요"
        moneyField.placeholder = "금액을 입력해보세요"
        categoryField.placeholder = "카테고리를 입력해보세요"
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
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(addButton.snp.bottom).offset(20)
        }
        
        contentTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
    }
}

extension AddViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image as? UIImage
                }
            }
        }
    }
}
