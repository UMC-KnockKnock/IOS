//
//  AddGroupVC.swift
//  KnockKnock
//
//  Created by 다은 on 2023/07/17.
//

import UIKit
class AddGroupVC : UIViewController {
    //스크롤뷰
    let scrollView : UIScrollView! = UIScrollView()
    
    var addBtn : UIButton = UIButton()
    var addGroupView : AddGroupView = {
        let view = AddGroupView()
       return view
    }()
    
    let group = Group.shared
    
    var groupName: String = ""
    var groupMember: [Int] = []
    var groupPlace: String = ""
    var groupTime: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        handleEditFunc()
        self.title = "모임 추가하기"
        self.addGroupView.memberTableview.rowHeight = UITableView.automaticDimension
        setScrollView()
        
        makeSubView()
        makeConstraint()
        makeAddTarget()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addGroupView.getData()
        addGroupView.sortData()
        addGroupView.memberTableview.reloadData()
        self.scrollView.layoutIfNeeded()
    }
  
    
}

extension AddGroupVC {
    private func setScrollView(){
        //scrollView 설정
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
     
    }

    private func makeSubView(){
        scrollView.addSubview(addGroupView)
        addBtn = setNextBtn(view: self, title: "추가하기")
    }
    private func makeConstraint(){
        addGroupView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addGroupView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            addGroupView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            addGroupView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            addGroupView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            addGroupView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            addGroupView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        //수직 스크롤을 위해 height 조정
//        let contentViewHeight = addGroupView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
//        contentViewHeight.priority = .defaultLow
//        contentViewHeight.isActive = true
      
    }
    
    private func makeAddTarget(){
        self.addGroupView.addmemberBtn.addTarget(self, action: #selector(addmemberFunc(_:)), for: .touchUpInside)
        self.addBtn.addTarget(self, action: #selector(addBtnFunc(_:)) , for: .touchUpInside)
    }
    @objc func addmemberFunc(_: UIButton){
        //그룹 구성원 추가하기
        let memberVC = GroupMemberVC()
        navigationController?.pushViewController(memberVC, animated: true)
    }

    @objc func addBtnFunc(_: UIButton){
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        groupTime = formatter.string(from: Date())
        if let name = addGroupView.nametext.text{
            groupName = name
        }
        for key in group.groupMember{
            groupMember.append(key)
        }
        if let gPlace = addGroupView.placetext.text{
            groupPlace = gPlace
        }
        if groupName == ""{
            // 팝업이나 표시
            return
        }
        if groupMember.count == 0{
            // 팝업이나 표시
            return
        }
        if groupPlace == ""{
            //팝업이나 표시
            return
        }
        setGroupData()
        group.groupMember = []
        self.navigationController?.popViewController(animated: true)
    }
    func setGroupData(){
        let groupInfo: GroupInfo = GroupInfo(
            name: groupName,
            user: groupMember,
            place: groupPlace,
            time: groupTime
        )
        print("groupInfo : \(groupInfo)")
        groupRequest(group:groupInfo)
    }
    func groupRequest(group:GroupInfo){
        let groupURLString = "http://\(Server.url)/gathering/create"
        guard let url = URL(string: groupURLString) else {
            print("서버 URL을 만들 수 없습니다.")
            return
        }
        
        let groupData = PostGroupRequest(
            title: group.name,
            gatheringMemberIds: group.user,
            location: group.place
        )
        
        print(groupData)
        
        let accessToken = UserDefaults.standard.string(forKey: "Authorization")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json", "Authorization": accessToken!]
        do {
            let jsonData = try JSONEncoder().encode(groupData)
            request.httpBody = jsonData
        } catch {
            print("JSON 인코딩에 실패하였습니다.")
            return
        }
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                print("올바른 HTTP 응답이 아닙니다.")
                return
            }
            
            let statusCode = httpResponse.statusCode
            print("HTTP 상태 코드: \(statusCode)")
            
            guard let data = data else {
                print("그룹 정보를 받아오지 못했습니다.")
                return
            }
            do {
                let user = try JSONDecoder().decode(PostGroupResponse.self, from: data)
                print("그룹 정보: \(user)")
            } catch {
                print("그룹 정보 디코딩에 실패하였습니다.")
            }
        }.resume()
    }
}
