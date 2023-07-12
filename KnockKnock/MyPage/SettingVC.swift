//
//  SettingVC.swift
//  KnockKnock
//
//  Created by 다은 on 2023/07/10.
//

import UIKit

class SettingVC: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .white // 테이블뷰 뒷배경 컬러도 white로 수정
        tableView.separatorStyle = .none // 셀 사이 선 없애기
        return tableView
    }()
    
    func makeSubView(){
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func makeConstraint(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "설정"
        view.backgroundColor = .white
        makeSubView()
        makeConstraint()
        
        
    }
}

extension SettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "PUSH 알림"
            
            let switchView = UISwitch()
            switchView.isOn = false // 기본값 설정
            switchView.onTintColor = #colorLiteral(red: 1, green: 0.1719063818, blue: 0.4505617023, alpha: 1)
            switchView.addTarget(self, action: #selector(pushSwitchValueChanged(_:)), for: .valueChanged)
            
            cell.accessoryView = switchView
        case 1:
            cell.textLabel?.text = "주소록 불러오기"
            cell.accessoryType = .disclosureIndicator
        case 2:
            cell.textLabel?.text = "앱 사용법"
            cell.accessoryType = .disclosureIndicator
        case 3:
            cell.textLabel?.text = "데이터 초기화"
            cell.accessoryType = .disclosureIndicator
        case 4:
            cell.textLabel?.text = "개인정보 처리방침"
            cell.accessoryType = .disclosureIndicator
        case 5:
            cell.textLabel?.text = "이용약관"
            cell.accessoryType = .disclosureIndicator
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let getInfoVC = GetInformationVC()
            getInfoVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(getInfoVC, animated: true)
            
        case 2:
            let guideVC = GuideVC()
            guideVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(guideVC, animated: true)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc private func pushSwitchValueChanged(_ sender: UISwitch) {
        // 스위치 값 변경 시 수행할 작업을 여기에 구현하세요.
        if sender.isOn {
            // 스위치가 켜진 상태
        } else {
            // 스위치가 꺼진 상태
        }
    }
}
