//
//  ModifyPostViewController.swift
//  every-time-iOS
//
//  Created by 김민 on 2023/02/20.
//

import UIKit

import SnapKit
import Then

final class ModifyPostViewController: RegisterPostViewController {
    
    // MARK: - Properties
    
    var postModel: PostModel?
    private let modifyPostManager: ModifyPostManager = ModifyPostManager()

    // MARK: - Initializer

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setPost()
        setAddTarget()
    }
}

extension ModifyPostViewController {

    // MARK: - Methods

    private func setPost() {
        guard let postModel = postModel else {return}
        titleTextField.text = postModel.title
        contentTextView.text = postModel.contents
        contentTextView.textColor = .black
    }

    private func setAddTarget() {
        completeButton.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
    }

    private func patchPost() {
        guard let uuid = postModel?.uuid else { return }
        guard let title = titleTextField.text else { return }
        guard let contents = contentTextView.text else { return }
        let request = PostRequest(title: title, contents: contents)
        modifyPostManager.patchPost(request, uuid) { [weak self] response in
            self?.dismiss(animated: true)
        }
    }

    // MARK: - @objc Methods

    override func completeButtonDidTap() {
        patchPost()
    }
}
