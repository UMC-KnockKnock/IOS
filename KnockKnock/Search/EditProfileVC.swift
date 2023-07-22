//
//  EditProfileVC.swift
//  KnockKnock
//
//  Created by 다은 on 2023/07/17.
//

import UIKit
class EditProfileVC : UIViewController {
    
    var saveBtn : UIButton = UIButton()
    
    let editLabel : UILabel = {
        let label = UILabel()
        label.text = "프로필 사진 편집"
        label.textColor =  #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    
    let ProfileView : UIImageView = {
       var profileView = UIImageView()
        let config = UIImage.SymbolConfiguration(paletteColors: [ #colorLiteral(red: 0.9972829223, green: 0, blue: 0.4537630677, alpha: 1)])
        profileView.image = UIImage(systemName: "person.circle.fill", withConfiguration: config)
        profileView.layer.cornerRadius = 40
        
        return profileView
    }()
    
    let nameLabel : UILabel = {
       let namelabel = UILabel()
        namelabel.text = "이름(필수)"
        namelabel.font = UIFont.boldSystemFont(ofSize: 17)
        return namelabel
    }()
    
    let nameText : UITextField = {
       let nametext = UITextField()
        nametext.placeholder = "입력해주세요!"
        nametext.backgroundColor = .systemGray6
        nametext.layer.cornerRadius = 10
        nametext.addLeftPadding()
        return nametext
    }()
    
    let nicknameLabel : UILabel = {
        let label = UILabel()
         label.text = "닉네임(선택)"
         label.font = UIFont.boldSystemFont(ofSize: 17)
         return label
     }()

     let nicknameText : UITextField = {
        let text = UITextField()
         text.placeholder = "입력해주세요!"
         text.backgroundColor = .systemGray6
         text.layer.cornerRadius = 10
         text.addLeftPadding()
         return text
     }()
    let fre = Friends.shared
    let me = MyData.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setNavigationBar()
        self.title = "편집"
        makeSubView()
        makeConstraint()
        makeAddTarget()
    }
}

extension EditProfileVC {
    func makeSubView(){
        view.addSubview(ProfileView)
        view.addSubview(editLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameText)
        view.addSubview(nicknameLabel)
        view.addSubview(nicknameText)
        saveBtn = setNextBtn(view: self, title: "저장하기")
    }
    
    
    func makeConstraint(){
        ProfileView.translatesAutoresizingMaskIntoConstraints = false
        editLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        nicknameText.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            ProfileView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            ProfileView.widthAnchor.constraint(equalToConstant: 100),
            ProfileView.heightAnchor.constraint(equalToConstant: 100),
            editLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            editLabel.topAnchor.constraint(equalTo: ProfileView.bottomAnchor, constant: 5),
            
            nameLabel.topAnchor.constraint(equalTo: editLabel.bottomAnchor, constant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            nameText.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            nameText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nameText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            nameText.heightAnchor.constraint(equalToConstant: 45),
            
            nicknameLabel.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20),
            nicknameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nicknameLabel.heightAnchor.constraint(equalToConstant: 30),

            nicknameText.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 7),
            nicknameText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            nicknameText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            nicknameText.heightAnchor.constraint(equalToConstant: 45),
            
        ])
        
    }
    
    func makeAddTarget(){
        saveBtn.addTarget(self, action: #selector(saveFriendData(_:)), for: .touchUpInside)
    }
    @objc func saveFriendData(_:UIButton){
        var newName: String = ""
        var newNickName: String = ""
        var newNumber: String = ""
        if let name = nameText.text{
            newName = name
        }else{
            newName = fre.dic[fre.choiceNumber!]!.name
        }
        if let nickName = nicknameText.text{
            newNickName = nickName
        }else{
            newNickName = fre.dic[fre.choiceNumber!]!.nickName
        }
        // 번호 수정 만들어지면 적용할 곳
//        if let number = numberText.text{
//            newNumber = number
//        }else{
//            newNumber = fre.choiceNumber!
//        }
        newNumber = fre.choiceNumber!
        var info: Info = Info(
            name: newName,
            nickName: newNickName,
            bestFriend: fre.dic[newNumber]!.bestFriend,
            alram: fre.dic[newNumber]!.alram,
            time: fre.dic[newNumber]!.time
        )
        fre.dic.removeValue(forKey: fre.choiceNumber!)
        fre.dic[newNumber] = info
        self.navigationController?.popViewController(animated: true)
    }
}
