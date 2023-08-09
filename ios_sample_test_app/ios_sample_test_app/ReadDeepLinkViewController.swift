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

        view.backgroundColor = .systemBackground
        
        // Checks if phone is in dark mode and modifies color of text for increased visibility
    
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                readDeepLinkPageDescription.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
                sessionParameterTitle.textColor = UIColor(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.00)
                sessionParameterText.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
                installParameterTitle.textColor = UIColor(red: 1.00, green: 0.84, blue: 0.00, alpha: 1.00)
                installParameterText.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)

            }
        }
        
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
            contentView.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 330),
            
            readDeepLinkPageDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            readDeepLinkPageDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            readDeepLinkPageDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),

            sessionParameterTitle.topAnchor.constraint(equalTo: readDeepLinkPageDescription.bottomAnchor, constant: 15),
            sessionParameterTitle.leadingAnchor.constraint(equalTo: readDeepLinkPageDescription.leadingAnchor, constant: 0),
            sessionParameterTitle.trailingAnchor.constraint(equalTo: readDeepLinkPageDescription.leadingAnchor, constant: 150),
            
            sessionParameterText.topAnchor.constraint(equalTo: sessionParameterTitle.bottomAnchor, constant: 5),
            sessionParameterText.leadingAnchor.constraint(equalTo: sessionParameterTitle.leadingAnchor, constant: 0),
            sessionParameterText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            
            installParameterTitle.topAnchor.constraint(equalTo: sessionParameterText.bottomAnchor, constant: 10),
            installParameterTitle.leadingAnchor.constraint(equalTo: sessionParameterText.leadingAnchor, constant: 0),
            installParameterTitle.trailingAnchor.constraint(equalTo: sessionParameterText.leadingAnchor, constant: 150),

            installParameterText.topAnchor.constraint(equalTo: installParameterTitle.bottomAnchor, constant: 5),
            installParameterText.leadingAnchor.constraint(equalTo: installParameterTitle.leadingAnchor, constant: 0),
            installParameterText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            installParameterText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0),
        ])
    
    }
    
    // ---------- UILabels for Page Text ----------

    private let readDeepLinkPageDescription: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters are determined each time the app is initialized.\n\nInstall Parameters are determined when the app is first installed."
        label.textColor = UIColor(red: 0.30, green: 0.33, blue: 0.47, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Italic", size: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sessionParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters"
        label.textColor = UIColor(red: 0.44, green: 0.11, blue: 0.96, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sessionParameterText: UILabel = {
        let label = UILabel()
        label.text = "-Session paremeters go here-"
        label.textColor = UIColor(red: 0.30, green: 0.33, blue: 0.47, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Light", size: 13)
        label.layer.borderColor = UIColor(red: 0.74, green: 0.75, blue: 0.83, alpha: 1.00).cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Install Parameters"
        label.textColor = UIColor(red: 0.44, green: 0.11, blue: 0.96, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let installParameterText: UILabel = {
        let label = UILabel()
        label.text = "Install Parameters Go Here"
        label.textColor = UIColor(red: 0.30, green: 0.33, blue: 0.47, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Light", size: 13)
        label.layer.borderColor = UIColor(red: 0.74, green: 0.75, blue: 0.83, alpha: 1.00).cgColor
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
