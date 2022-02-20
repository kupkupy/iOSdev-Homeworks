//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Ilya on 14.02.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusChangeButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusTextField: UITextField!
    
    @IBOutlet weak var topStatusButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var spacingStatusButton: NSLayoutConstraint!
    
    private var isExpanded = true
    private var statusText = readLine()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as? UIView else { return UIView() }
        
        return view
    }
    
    private func setupProfileView() {
        let view = self.loadViewFromXib()
        view.frame = self.bounds
        view.backgroundColor = .lightGray
        self.addSubview(view)
        
        setupLabels()
        setupImageView()
        setupStatusChangeButton()
        setupStatusTextField()
    }
    
    private func setupLabels() {
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .black
        nameLabel.text = "Kup-kupy"
        nameLabel.font = UIFont(name: "Helvetica-Bold", size: 18)
        
        statusLabel.numberOfLines = 0
        statusLabel.textColor = .gray
        statusLabel.text = "Waiting for something..."
        statusLabel.font = UIFont(name: "Helvetica-Regular", size: 14)
    }
    
    private func setupImageView() {
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        photoImageView.clipsToBounds = true
        photoImageView.layer.borderWidth = 3
        photoImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupStatusChangeButton() {
        statusChangeButton.layer.cornerRadius = 14
        statusChangeButton.backgroundColor = .systemBlue
        statusChangeButton.setTitle("Show status", for: .normal)
        statusChangeButton.setTitleColor(.white, for: .normal)
        statusChangeButton.layer.shadowOffset = .init(width: 4, height: 4)
        statusChangeButton.layer.shadowRadius = 4
        statusChangeButton.layer.shadowColor = UIColor.black.cgColor
        statusChangeButton.layer.shadowOpacity = 0.7
        statusChangeButton.addTarget(self, action: #selector(statusChangeButtonPressed), for: .touchUpInside)
    }
    
    private func setupStatusTextField() {
        statusTextField.isHidden = true
        statusTextField.returnKeyType = .continue
        statusTextField.clearButtonMode = .always
        statusTextField.autocapitalizationType = .words
        statusTextField.autocorrectionType = .yes
        statusTextField.backgroundColor = .white
        statusTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.leftViewMode = .always
        statusTextField.layoutMargins.left = 20
        statusTextField.layer.cornerRadius = 12
        statusTextField.layer.borderWidth = 1
        statusTextField.layer.borderColor = UIColor.black.cgColor
        statusTextField.textColor = .black
        statusTextField.font = UIFont(name: "Helvetica-Regular", size: 15)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc private func statusChangeButtonPressed(sender: UIButton) {
        print(statusLabel.text ?? "No text")
        
        self.topStatusButtonConstraint.constant = self.isExpanded ? 66 : 16
        self.spacingStatusButton.constant = self.isExpanded ? 84 : 34
        
        
        if isExpanded {
            statusChangeButton.setTitle("Set status", for: .normal)
            self.statusTextField.isHidden = false
            
        } else {
            statusChangeButton.setTitle("Show status", for: .normal)
            self.statusTextField.isHidden = true
            statusLabel.text = statusText
        }
        
        UIView.animate(withDuration: 0.7) {
            self.layoutIfNeeded()
        } completion: { _ in
            self.isExpanded.toggle()
        }
        
        UITextField.animate(withDuration: 0.7, animations: { self.layoutIfNeeded() }, completion: nil)

        self.statusTextField.delegate = self
    }
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text
    }
}

extension ProfileHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        statusTextField.resignFirstResponder()
        return true
    }
}
