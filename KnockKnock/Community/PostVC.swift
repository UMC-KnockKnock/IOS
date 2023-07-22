//
//  PostVC.swift
//  KnockKnock
//
//  Created by 티모시 킴 on 2023/07/16.
//

import UIKit

class PostVC: UIViewController {
    
    var myPost: Bool = true // 자신 글 여부
    
    
    var categoryValue: Int! // 게시판 종류
    
    // 테이블 뷰 관련: post, comment, tableView
    // post(스트럭트 맨아래 있음)
    var post: Post = Post(profile: UIImage(named: "karim")!,
                          name: "카림",
                          title: "바다에 놀러왔어~!",
                          content: "안녕 친구들 바닷가에 왔는데 날이 너무 좋아! 여기 바다 정말 추천해",
                          images: [UIImage(named: "beach"), UIImage(named: "paris"), UIImage(named: "sanfrancisco")],
                          time: "07/08 22:17",
                          likes: 17, comments: 3)
    
    // comment(스트럭트 맨아래 있음)
    var comments: [Comment] = [
        Comment(profile: UIImage(named: "sergio")!,
                name: "세르히오",
                text: "짧은 문장 테스트: 우와",
                time: "07/08 23:17"),
        Comment(profile: UIImage(named: "toni")!,
                name: "토니",
                text: "나도 갈래",
                time: "07/08 22:19"),
        Comment(profile: UIImage(named: "mesut")!,
                name: "메수트",
                text: "긴 문장 테스트: 오 여기서 가깝다!@#$%@!#$@!#!@#!@$%!#@!#!#@!#@!#!@#!#@!#!@#!@#@#!@#!#!@#!#@!#!@#!@#@!#!#!",
                time: "07/09 02:14")
    ]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // 댓글 관련: commentContainerView1, commentContainerView2, commentTextField, anonymousImageButton, makeCommentImageButton
    let commentContainerView1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9656803012, green: 0.965680182, blue: 0.965680182, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentContainerView2: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 17
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "댓글을 입력하세요.")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var isAnonymousSelected = false // 댓글 익명 여부
    
    let anonymousImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "check_anony_no"), for: .normal)
        button.addTarget(self, action: #selector(anonymousImageButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let makeCommentImageButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "send"), for: .normal)
        button.addTarget(self, action: #selector(makeCommentImageButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func makeSubView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomPostCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(CustomCommentCell.self, forCellReuseIdentifier: "CommentCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        view.addSubview(commentContainerView1)
        commentContainerView1.addSubview(commentContainerView2)
        commentContainerView1.addSubview(makeCommentImageButton)
        commentContainerView2.addSubview(commentTextField)
        commentContainerView2.addSubview(anonymousImageButton)
    }
    
    func makeConstraint() {
        let horizontalMargin: CGFloat = 30
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: commentContainerView1.topAnchor),
            
            commentContainerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            commentContainerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            commentContainerView1.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            commentContainerView1.heightAnchor.constraint(equalToConstant: 65),
            
            commentContainerView2.leadingAnchor.constraint(equalTo: commentContainerView1.leadingAnchor, constant: horizontalMargin),
            commentContainerView2.trailingAnchor.constraint(equalTo: makeCommentImageButton.leadingAnchor, constant: -5),
            commentContainerView2.topAnchor.constraint(equalTo: commentContainerView1.topAnchor, constant: 15),
            commentContainerView2.bottomAnchor.constraint(equalTo: commentContainerView1.bottomAnchor, constant: -15),
            
            commentTextField.leadingAnchor.constraint(equalTo: commentContainerView2.leadingAnchor, constant: 10),
            commentTextField.trailingAnchor.constraint(equalTo: anonymousImageButton.leadingAnchor, constant: -10),
            commentTextField.topAnchor.constraint(equalTo: commentContainerView2.topAnchor, constant: 10),
            commentTextField.bottomAnchor.constraint(equalTo: commentContainerView2.bottomAnchor, constant: -10),
            
            anonymousImageButton.trailingAnchor.constraint(equalTo: commentContainerView2.trailingAnchor, constant: -10),
            anonymousImageButton.centerYAnchor.constraint(equalTo: commentContainerView2.centerYAnchor),
            anonymousImageButton.widthAnchor.constraint(equalToConstant: 45),
            anonymousImageButton.heightAnchor.constraint(equalToConstant: 20),
            
            makeCommentImageButton.trailingAnchor.constraint(equalTo: commentContainerView1.trailingAnchor, constant: -horizontalMargin),
            makeCommentImageButton.centerYAnchor.constraint(equalTo: commentContainerView1.centerYAnchor),
            makeCommentImageButton.widthAnchor.constraint(equalToConstant: 25),
            makeCommentImageButton.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = categoryValue == 0 ? "선 게시판" : "악 게시판"
        view.backgroundColor = .white
        var image = UIImage(named: "more_vert")?.resizeImageTo(size: CGSize(width: 30, height: 30))
        let rightBarButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(showActionSheet))
        navigationItem.rightBarButtonItem = rightBarButton
        
        makeSubView()
        makeConstraint()
    }
    
    @objc func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        if myPost {
            // 자신의 글일 때
            let action1 = UIAlertAction(title: "수정", style: .default) { _ in
                let writeVC = WriteVC()
                writeVC.index = self.categoryValue
                writeVC.modify = true
                writeVC.titleTextField.text = self.post.title
                writeVC.contentTextView.text = self.post.content
                writeVC.contentTextView.textColor = .label
                writeVC.originalImages = self.post.images
                writeVC.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(writeVC, animated: true)
            }
            let action2 = UIAlertAction(title: "삭제", style: .default) { _ in
                // Handle Action 2
            }
            actionSheet.addAction(action1)
            actionSheet.addAction(action2)
        } else {
            // 자신의 글이 아닐 때
            let action1 = UIAlertAction(title: "신고", style: .default) { _ in
                // Handle Action 1
            }
            actionSheet.addAction(action1)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(cancelAction)
        // On iPad, the action sheet should be presented as a popover.
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        present(actionSheet, animated: true)
    }
    
    
    @objc func anonymousImageButtonTapped(_ sender: UIButton) {
        isAnonymousSelected.toggle()
        let imageName = isAnonymousSelected ? "check_anony_yes" : "check_anony_no"
        anonymousImageButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    @objc func makeCommentImageButtonTapped(_ sender: UIButton) {
        print("댓글 작성 버튼 탭함.")
    }
}

extension PostVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // 섹션은 하나 (게시글 + 댓글)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 행 개수 리턴 (댓글 수 + 1(게시글))
        return comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // 행의 index가 0일 때는 게시글
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomPostCell
            cell.configureCell(with: post)
            if post.images != nil {
                cell.makeSubView1()
                cell.makeConstraint1()
            } else {
                cell.makeSubView2()
                cell.makeConstraint2()
            }
            cell.selectionStyle = .none
            return cell
        } else {
            // 나머지 index일 때는 댓글
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CustomCommentCell
            let comment = comments[indexPath.row - 1] // 댓글[행 인덱스 - 1] -> 해당 댓글
            cell.configureCell(with: comment)
            cell.makeSubView()
            cell.makeConstraint()
            cell.selectionStyle = .none
            return cell
        }
    }
}
