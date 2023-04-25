//
//  ReadDeepLinkViewController.swift
//  ios_sample_test_app
//
//  Created by Brandon Boothe on 4/2/23.
//

import UIKit
import BranchSDK

class ReadDeepLinkViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------- Branch SDK Functions: Grab Install & Session Parameters

        guard let sessionParams = Branch.getInstance().getLatestReferringParams() else {return}
        self.sessionParameterText.text = String(format: "%@", sessionParams)

        guard let installParams = Branch.getInstance().getFirstReferringParams() else {return}
        self.installParameterText.text = String(format: "%@", installParams)
        
        
        // ---------- UI Elements ----------
        
        self.title = "Read Deep Link Data"

        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(readDeepLinkPageDescription)
        contentView.addSubview(sessionParameterTitle)
        contentView.addSubview(sessionParameterText)
        contentView.addSubview(installParameterTitle)
        contentView.addSubview(installParameterText)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            
            readDeepLinkPageDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            readDeepLinkPageDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            readDeepLinkPageDescription.widthAnchor.constraint(equalToConstant: 330),

            sessionParameterTitle.topAnchor.constraint(equalTo: readDeepLinkPageDescription.bottomAnchor, constant: 15),
            sessionParameterTitle.leadingAnchor.constraint(equalTo: readDeepLinkPageDescription.leadingAnchor, constant: 0),
            
            sessionParameterText.topAnchor.constraint(equalTo: sessionParameterTitle.bottomAnchor, constant: 5),
            sessionParameterText.leadingAnchor.constraint(equalTo: sessionParameterTitle.leadingAnchor, constant: 0),
            sessionParameterText.widthAnchor.constraint(equalToConstant: 330),
            
            installParameterTitle.topAnchor.constraint(equalTo: sessionParameterText.bottomAnchor, constant: 10),
            installParameterTitle.leadingAnchor.constraint(equalTo: sessionParameterText.leadingAnchor, constant: 0),

            installParameterText.topAnchor.constraint(equalTo: installParameterTitle.bottomAnchor, constant: 5),
            installParameterText.leadingAnchor.constraint(equalTo: installParameterTitle.leadingAnchor, constant: 0),
            installParameterText.widthAnchor.constraint(equalToConstant: 330),
            installParameterText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
            installParameterText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
        ])
    
    }
    
    // ---------- UILabels for Page Text ----------

    private let readDeepLinkPageDescription: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters are determined each time the app is initialized.\n\nInstall Parameters are determined when the app is first installed."
        label.textColor = UIColor(rgb: 0x04C5478)
        label.font = UIFont(name: "Raleway-Italic", size: 13)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sessionParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters"
        label.textColor = UIColor(rgb: 0x711DF4)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sessionParameterText: UILabel = {
        let label = UILabel()
        label.text = "-Session paremeters go here-"
        label.textColor = UIColor(rgb: 0x4C5478)
        label.font = UIFont(name: "Raleway-Light", size: 13)
        label.layer.borderColor = UIColor(rgb: 0xBCC0D4).cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Install Parameters"
        label.textColor = UIColor(rgb: 0x711DF4)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installParameterText: UILabel = {
        let label = UILabel()
        label.text = "Install Parameters Go Here"
        label.textColor = UIColor(rgb: 0x4C5478)
        label.font = UIFont(name: "Raleway-Light", size: 13)
        label.layer.borderColor = UIColor(rgb: 0xBCC0D4).cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // ---------- ScrollView ----------
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
}