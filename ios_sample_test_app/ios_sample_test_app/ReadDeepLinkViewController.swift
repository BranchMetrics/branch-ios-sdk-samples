//
//  ReadDeepLinkViewController.swift
//  ios_sample_test_app
//
//  Created by Brandon Boothe on 4/2/23.
//

import UIKit
import BranchSDK

class ReadDeepLinkViewController: UIViewController, UIScrollViewDelegate {
   
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
                
        readDeepLinkPageDescription.translatesAutoresizingMaskIntoConstraints = false
        let readDeepLinkPageDescriptionHorizontalConstraint = NSLayoutConstraint(item: readDeepLinkPageDescription, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let readDeepLinkPageDescriptionVerticalConstraint = NSLayoutConstraint(item: readDeepLinkPageDescription, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        let readDeepLinkPageDescriptionWidthConstraint = NSLayoutConstraint(item: readDeepLinkPageDescription, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 300)
        let readDeepLinkPageDescriptionHeightConstraint = NSLayoutConstraint(item: readDeepLinkPageDescription, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 100)
        
        sessionParameterTitle.translatesAutoresizingMaskIntoConstraints = false
        let sessionParameterTitleHorizontalConstraint = NSLayoutConstraint(item: sessionParameterTitle, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 20)
        let sessionParameterTitleVerticalConstraint = NSLayoutConstraint(item: sessionParameterTitle, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: readDeepLinkPageDescription, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let sessionParameterTitleWidthConstraint = NSLayoutConstraint(item: sessionParameterTitle, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 200)
        let sessionParameterTitleHeightConstraint = NSLayoutConstraint(item: sessionParameterTitle, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 25)
        
        sessionParameterText.translatesAutoresizingMaskIntoConstraints = false
        let sessionParameterTextHorizontalConstraint = NSLayoutConstraint(item: sessionParameterText, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 20)
        let sessionParameterTextVerticalConstraint = NSLayoutConstraint(item: sessionParameterText, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sessionParameterTitle, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10)
        let sessionParameterTextWidthConstraint = NSLayoutConstraint(item: sessionParameterText, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 350)
        let sessionParameterTextHeightConstraint = NSLayoutConstraint(item: sessionParameterText, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sessionParameterText, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: sessionParameterText.frame.size.height)
        
        installParameterTitle.translatesAutoresizingMaskIntoConstraints = false
        let installParameterTitleHorizontalConstraint = NSLayoutConstraint(item: installParameterTitle, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 20)
        let installParameterTitleVerticalConstraint = NSLayoutConstraint(item: installParameterTitle, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: sessionParameterText, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let installParameterTitleWidthConstraint = NSLayoutConstraint(item: installParameterTitle, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 200)
        let installParameterTitleHeightConstraint = NSLayoutConstraint(item: installParameterTitle, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 25)
        
        installParameterText.translatesAutoresizingMaskIntoConstraints = false
        let installParameterTextHorizontalConstraint = NSLayoutConstraint(item: installParameterText, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 20)
        let installParameterTextVerticalConstraint = NSLayoutConstraint(item: installParameterText, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: installParameterTitle, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 10)
        let installParameterTextWidthConstraint = NSLayoutConstraint(item: installParameterText, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 350)
        let installParameterTextHeightConstraint = NSLayoutConstraint(item: installParameterText, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: installParameterText, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: installParameterText.frame.size.height)
        
        self.view.addConstraints([readDeepLinkPageDescriptionHorizontalConstraint, readDeepLinkPageDescriptionVerticalConstraint, readDeepLinkPageDescriptionWidthConstraint, readDeepLinkPageDescriptionHeightConstraint, sessionParameterTitleHorizontalConstraint, sessionParameterTitleVerticalConstraint, sessionParameterTitleWidthConstraint, sessionParameterTitleHeightConstraint, sessionParameterTextHorizontalConstraint, sessionParameterTextVerticalConstraint, sessionParameterTextWidthConstraint, sessionParameterTextHeightConstraint, installParameterTitleHorizontalConstraint, installParameterTitleVerticalConstraint, installParameterTitleWidthConstraint, installParameterTitleHeightConstraint, installParameterTextHorizontalConstraint, installParameterTextVerticalConstraint, installParameterTextWidthConstraint, installParameterTextHeightConstraint])
        
        let layout = view.safeAreaLayoutGuide
        scrollView.centerXAnchor.constraint(equalTo: layout.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: layout.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: layout.widthAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: layout.heightAnchor).isActive = true
    }
    
    // ---------- UILabels for Page Text ----------

    private let readDeepLinkPageDescription: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters are determined each time the app is initialized.\n\nInstall Parameters are determined when the app is first installed."
        label.textColor = UIColor(rgb: 0x04C5478)
        label.font = UIFont(name: "Raleway-Italic", size: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let sessionParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Session Parameters"
        label.textColor = UIColor(rgb: 0x711DF4)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
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
        return label
    }()
    
    private let installParameterTitle: UILabel = {
        let label = UILabel()
        label.text = "Install Parameters"
        label.textColor = UIColor(rgb: 0x711DF4)
        label.font = UIFont(name: "Raleway-Medium", size: 15)
        label.numberOfLines = 0
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
        return label
    }()
    
    // ---------- ScrollView ----------
    
    lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: 1250)
        return scroll
    }()
    
    lazy var contentView: UIView = {
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()
}
