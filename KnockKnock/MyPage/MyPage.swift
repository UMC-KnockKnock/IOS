//
//  MyPage.swift
//  KnockKnock
//
//  Created by 다은 on 2023/06/24.
//

import UIKit
class MyPage : UIView{

    let textScroll : UIScrollView = UIScrollView()
    
    let Name : UILabel = {
        let name = UILabel()
        name.text = MyData.shared.name
        name.textAlignment = .center
        name.font = .systemFont(ofSize: 16)
        name.backgroundColor = .white
        name.textColor = .black
        return name
    }()
    
    
    let ProfileView : UIImageView = {
       var profileView = UIImageView()
        let config = UIImage.SymbolConfiguration(paletteColors: [#colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)])
        profileView.image = UIImage(systemName: "person.circle.fill", withConfiguration: config)
        profileView.layer.cornerRadius = 40
        return profileView
    }()
    
    let editBtn : UIButton = {
       let btn = UIButton()
        btn.setTitle("편집 >", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return btn
    }()
    
    let textTitle : UILabel = {
       let texttitle =  UILabel()
        texttitle.text = "내 문자 글"
        texttitle.font = UIFont.boldSystemFont(ofSize: 17)
        return texttitle
    }()
    
    let myText : UITextView = {
       let mytext = UITextView()
        mytext.text = " 남기고 싶은 메모를 작성해주세요!"
        mytext.addLeftPadding()
        mytext.layer.cornerRadius = 5
        mytext.backgroundColor = .systemGray6
        mytext.layer.cornerRadius = 5
        mytext.font = UIFont.systemFont(ofSize: 15)
      
        return mytext
    }()
    
    let copyBtn : UIButton = {
       let copybtn = UIButton()
        copybtn.backgroundColor = #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)
        copybtn.tintColor = .white
        copybtn.setTitle("글 전체 복사", for: .normal)
        copybtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        copybtn.layer.cornerRadius = 15
        return copybtn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeSubView()
        makeConstraint()
        makeAddTarget()
      
    }
    
    required init?(coder _: NSCoder) {
        fatalError("Error")
    }
    
}

extension MyPage {
    func makeConstraint(){
        textScroll.translatesAutoresizingMaskIntoConstraints = false
        Name.translatesAutoresizingMaskIntoConstraints = false
        ProfileView.translatesAutoresizingMaskIntoConstraints = false
        editBtn.translatesAutoresizingMaskIntoConstraints = false
        textTitle.translatesAutoresizingMaskIntoConstraints = false
        myText.translatesAutoresizingMaskIntoConstraints = false
        copyBtn.translatesAutoresizingMaskIntoConstraints = false
      
        
        NSLayoutConstraint.activate([
        ProfileView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        ProfileView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
        ProfileView.widthAnchor.constraint(equalToConstant: 100),
        ProfileView.heightAnchor.constraint(equalToConstant: 100),
        Name.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
        Name.topAnchor.constraint(equalTo: ProfileView.bottomAnchor, constant: 7),
        editBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        editBtn.topAnchor.constraint(equalTo: Name.bottomAnchor, constant: 2),
        
        textTitle.topAnchor.constraint(equalTo: editBtn.bottomAnchor, constant: 40),
        textTitle.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
        
        copyBtn.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 210),
        copyBtn.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
        copyBtn.widthAnchor.constraint(equalToConstant: 120),
        copyBtn.heightAnchor.constraint(equalToConstant: 30),
        
        textScroll.topAnchor.constraint(equalTo: textTitle.bottomAnchor, constant: 8),
        textScroll.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
        textScroll.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30),
        textScroll.bottomAnchor.constraint(equalTo: copyBtn.topAnchor, constant: -10),
        myText.topAnchor.constraint(equalTo: textScroll.topAnchor),
        myText.leadingAnchor.constraint(equalTo: textScroll.leadingAnchor),
        myText.trailingAnchor.constraint(equalTo: textScroll.trailingAnchor),
        myText.bottomAnchor.constraint(equalTo: textScroll.bottomAnchor),
        myText.widthAnchor.constraint(equalTo: textScroll.widthAnchor),
        
        ])
        
        let contentViewHeight = myText.heightAnchor.constraint(greaterThanOrEqualTo: textScroll.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }
    
    
    func makeSubView(){
        
        self.addSubview(Name)
        self.addSubview(ProfileView)
        self.addSubview(editBtn)
        self.addSubview(textTitle)
        self.addSubview(copyBtn)
        self.addSubview(textScroll)
        textScroll.addSubview(myText)
        
        textScroll.isScrollEnabled = true
        textScroll.alwaysBounceVertical = true
    }
    
    func makeAddTarget(){
        self.copyBtn.addTarget(self, action: #selector(pasteText(_:)), for: .touchUpInside)
    }
    
    @objc func pasteText(_ sender: Any) {
              UIPasteboard.general.string = myText.text
          }
}
