//
//  ViewController.swift
//  ios_sample_test_app
//
//  Created by Brandon Boothe on 3/23/23.
//

import UIKit
import BranchSDK

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Raleway-Bold", size: 30.0)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Raleway-SemiBold", size: 18.0)!]
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(generatedBranchLink)
        contentView.addSubview(branchBadgeImageView)
        contentView.addSubview(changeBackgroundColorButton)
        contentView.addSubview(buyNowButton)
        contentView.addSubview(addToCartButton)
        contentView.addSubview(colorBlockPageButton)
        contentView.addSubview(readDeepLinkButton)
        view.addSubview(dimScreen)
        view.addSubview(qrCode)
        
        // Setup TapGestureRecognizer. The ACTION PARAMETER IS NIL since we do not need a
        // selector function. We'll let gestureRecognizer(_:shouldReceive:) do the work.
        // But we MUST at least register the gesture recognizer's delegate with the view!
        let viewTapGesture = UITapGestureRecognizer(target: self, action: nil)
        viewTapGesture.delegate = self
        view.addGestureRecognizer(viewTapGesture)
        
        createBranchLink()
    }
    
    // ---------- Branch SDK Functions ----------
    
    func createBranchUniversalObject() -> BranchUniversalObject {
        let buo = BranchUniversalObject(canonicalIdentifier: "context/23456")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["key1"] = "value1"
        return buo
    }
    
    func createBranchLinkProperties() -> BranchLinkProperties {
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "content 123 launch"
        lp.stage = "new user"
        lp.tags = ["one", "two", "three"]
        
        lp.addControlParam("custom_data", withValue: "Custom Data Here")
        lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
        lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
        
        // Routing to ColorBlockViewController or ReadDeepLinkViewController
        lp.addControlParam("nav_to", withValue: "color_block_page")
        // lp.addControlParam("nav_to", withValue: "read_deep_link_page")
        
        // "color_block_key" can be set to "red", "green", or "blue"
        lp.addControlParam("color_block_key", withValue: "green")
        
        return lp
    }
    
    func createBranchLink() {
        let buo = createBranchUniversalObject()
        let lp = createBranchLinkProperties()
        
        buo.getShortUrl(with: lp) { url, error in
            print(url ?? "")
            self.generatedBranchLink.text = url
        }
    }
    
    @objc func sendPurchaseEvent(_ sender: UIButton) {
        let event = BranchEvent.customEvent(withName: "Custom Purchase Event")
        event.currency = .USD
        event.revenue = 5
        event.eventDescription = "User clicked the puchase button to send a custom purchase event"
        event.customData = [
            "Custom_Event_Property_key1" : "Custom_Event_Property_val1",
            "App_Type" : "Ios_Sample_App"
        ]
        event.logEvent()
        
        self.showToast(message: "Purchase Event sent!", font: UIFont(name: "Raleway-Regular", size: 16)!)
    }
    
    @objc func sendAddToCartEvent(_ sender: UIButton) {
        let event = BranchEvent.standardEvent(.addToCart)
        event.currency = .USD
        event.revenue = 0
        event.eventDescription = "User clicked add to cart button to send the standard Add to Cart Branch Event"
        event.customData = [
            "Custom_Event_Property_key1" : "Custom_Event_Property_val1",
            "App_Type" : "Ios_Sample_App"
        ]
        event.logEvent()
        
        self.showToast(message: "Add to Cart event sent!", font: UIFont(name: "Raleway-Regular", size: 16)!)
    }
    
    @objc func shareBranchLink() {
        let buo = createBranchUniversalObject()
        let lp = createBranchLinkProperties()
        
        let message = "This link changes the color block"
        buo.showShareSheet(with: lp, andShareText: message, from: self) { (activityType, completed) in
            print(activityType ?? "")
        }
    }
    
    @objc func createQRCode() {
        let buo = createBranchUniversalObject()
        let lp = createBranchLinkProperties()
        
        let qrCode = BranchQRCode()
        qrCode.codeColor = UIColor.white
        qrCode.backgroundColor = UIColor.blue
        qrCode.centerLogo = "https://i.snipboard.io/nshJlY.jpg"
        qrCode.width = 350
        qrCode.margin = 0
        qrCode.imageFormat = .JPEG
        
        qrCode.getAsImage(buo, linkProperties: lp) { qrCodeImage, error in
            // Checking for error prior to initializing QR Code
            if (error != nil) {
                print(error as Any)
                return
            }
            
            // Do something with your QR code here...
            DispatchQueue.main.async {
                self.qrCode.backgroundColor = UIColor(patternImage: qrCodeImage!)
            }
        }
        
        // Displays QR Code UI View
        self.qrCode.layer.isHidden = false
        self.dimScreen.layer.isHidden = false

        // Or display the QR code directly in a share sheet
        // qrCode.showShareSheetWithQRCode(from: self, anchor: nil, universalObject: buo, linkProperties: lp) { error in
            // Showing a share sheet with the QR code
        //}
    }
    
    // Changes background color and sends Branch event
    @objc func changeBackgroundColor(_ sender: UIButton) {
        let event = BranchEvent.customEvent(withName: "Custom Change Background Color Event")
        event.eventDescription = "User clicked the puchase button to send a custom purchase event"
        event.customData = [
            "Custom_Event_Property_key1" : "Custom_Event_Property_val1",
            "App_Type" : "Ios_Sample_App"
        ]
        event.logEvent()
        
        self.showToast(message: "Change Background Color Event sent!", font: UIFont(name: "Raleway-Regular", size: 16)!)
        view.backgroundColor = colors.randomElement()
    }
    
    private let colors: [UIColor] = [
        .systemRed,
        .systemCyan,
        .systemMint,
        .systemYellow,
        .systemGreen,
        .systemPink,
        .systemOrange,
        .systemPurple
    ]
    
    // ---------- Setup Constraints and Navigation Bar ----------
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 60),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            generatedBranchLink.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -8),
            generatedBranchLink.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            generatedBranchLink.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.0),
            generatedBranchLink.heightAnchor.constraint(equalToConstant: 33),

            branchBadgeImageView.topAnchor.constraint(equalTo: generatedBranchLink.bottomAnchor, constant: 10),
            branchBadgeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            branchBadgeImageView.widthAnchor.constraint(equalToConstant: 300),
            branchBadgeImageView.heightAnchor.constraint(equalToConstant: 300),

            changeBackgroundColorButton.topAnchor.constraint(equalTo: branchBadgeImageView.bottomAnchor, constant: 5),
            changeBackgroundColorButton.leadingAnchor.constraint(equalTo: generatedBranchLink.leadingAnchor, constant: 0),
            changeBackgroundColorButton.trailingAnchor.constraint(equalTo: generatedBranchLink.trailingAnchor, constant: 0),
            changeBackgroundColorButton.heightAnchor.constraint(equalToConstant: 55),
            
            buyNowButton.topAnchor.constraint(equalTo: changeBackgroundColorButton.bottomAnchor, constant: 5),
            buyNowButton.leadingAnchor.constraint(equalTo: changeBackgroundColorButton.leadingAnchor, constant: 0),
            buyNowButton.trailingAnchor.constraint(equalTo: changeBackgroundColorButton.trailingAnchor, constant: 0),
            buyNowButton.heightAnchor.constraint(equalToConstant: 55),

            addToCartButton.topAnchor.constraint(equalTo: buyNowButton.bottomAnchor, constant: 5),
            addToCartButton.leadingAnchor.constraint(equalTo: buyNowButton.leadingAnchor, constant: 0),
            addToCartButton.trailingAnchor.constraint(equalTo: buyNowButton.trailingAnchor, constant: 0),
            addToCartButton.heightAnchor.constraint(equalToConstant: 55),

            colorBlockPageButton.topAnchor.constraint(equalTo: addToCartButton.bottomAnchor, constant: 5),
            colorBlockPageButton.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor, constant: 0),
            colorBlockPageButton.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor, constant: 0),
            colorBlockPageButton.heightAnchor.constraint(equalToConstant: 55),

            readDeepLinkButton.topAnchor.constraint(equalTo: colorBlockPageButton.bottomAnchor, constant: 5),
            readDeepLinkButton.leadingAnchor.constraint(equalTo: colorBlockPageButton.leadingAnchor, constant: 0),
            readDeepLinkButton.trailingAnchor.constraint(equalTo: colorBlockPageButton.trailingAnchor, constant: 0),
            readDeepLinkButton.heightAnchor.constraint(equalToConstant: 55),

            readDeepLinkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0.0)
        ])
        
        setupNavigationMenuButtons()
        
        let qrCodeVerticalConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let qrCodeLeadingConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 20)
        let qrCodeTrailingConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -20)
        let qrCodeHeightConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 350)
        self.view.addConstraints([qrCodeVerticalConstraint, qrCodeLeadingConstraint, qrCodeTrailingConstraint, qrCodeHeightConstraint])
        
        dimScreen.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // ---------- Setup Navigation Bar Items ----------
    
    func setupNavigationMenuButtons(){
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareBranchLink))
        
        let qrCodeButton = UIBarButtonItem(image: UIImage(systemName: "qrcode"), style: .plain, target: self, action: #selector(createQRCode))
        
        self.navigationItem.rightBarButtonItems = [shareButton, qrCodeButton]
    }
    
    // ---------- UILabels and UIImages ----------
    
    private let generatedBranchLink: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(red: 0.12, green: 0.16, blue: 0.32, alpha: 1.00)
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.lineFragmentPadding = 0;
        textView.textAlignment = .center
        textView.font = UIFont(name: "Raleway-Medium", size: 14)
        textView.layer.borderColor = UIColor(red: 0.74, green: 0.75, blue: 0.83, alpha: 1.00).cgColor
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let branchBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "BranchBadgeDark")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // ---------- Buttons on the bottom of the page ----------
    
    func createButton(buttonTitle: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.00, green: 0.45, blue: 0.87, alpha: 1.00)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
        
        switch buttonTitle {
        case "Change Background Color":
            button.setTitle("Change Background Color", for: .normal)
            button.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
            
        case "Buy Now":
            button.setTitle("Buy Now", for: .normal)
            button.addTarget(self, action: #selector(sendPurchaseEvent(_:)), for: .touchUpInside)
            
        case "Add To Cart":
            button.setTitle("Add To Cart", for: .normal)
            button.addTarget(self, action: #selector(sendAddToCartEvent(_:)), for: .touchUpInside)
            
        case "Color Block Page":
            button.setTitle("Color Block Page", for: .normal)
            button.addTarget(self, action: #selector(openColorBlockPage(_:)), for: .touchUpInside)
            
        case "Read Link Data":
            button.setTitle("Read Link Data", for: .normal)
            button.addTarget(self, action: #selector(openReadDeepLinkPage(_:)), for: .touchUpInside)
            
        default:
            print("Button not defined.")
        }
        
        return button
    }
    
    private lazy var changeBackgroundColorButton = createButton(buttonTitle: "Change Background Color")
    private lazy var buyNowButton = createButton(buttonTitle: "Buy Now")
    private lazy var addToCartButton = createButton(buttonTitle: "Add To Cart")
    private lazy var colorBlockPageButton = createButton(buttonTitle: "Color Block Page")
    private lazy var readDeepLinkButton = createButton(buttonTitle: "Read Link Data")
    
    // ---------- Navigation Functions ----------
    
    @objc func openColorBlockPage(_ sender: UIButton) {
        let colorBlockPageController = ColorBlockViewController()
        self.show(colorBlockPageController, sender: colorBlockPageButton)
    }
    
    @objc func openReadDeepLinkPage(_ sender: UIButton) {
        let readDeepLinkPageController = ReadDeepLinkViewController()
        self.show(readDeepLinkPageController, sender: readDeepLinkButton)
    }
    
    // ---------- QR Code Popup Views and Functions ----------
    
    // Dims screen around QR Code
    
    private let dimScreen: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Hides QR Code UIView on app initialization
    
    private let qrCode: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Removes QR Code and dimmed background when screen is touched
    
    @objc(gestureRecognizer:shouldReceiveTouch:) func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
            if !qrCode.isHidden {
                qrCode.isHidden = true
                dimScreen.isHidden = true
            }
            return false
    }
    
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

// Enables sending toast messages

extension UIViewController {

    func showToast(message : String, font: UIFont) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height - 450, width: 300, height: 65))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
