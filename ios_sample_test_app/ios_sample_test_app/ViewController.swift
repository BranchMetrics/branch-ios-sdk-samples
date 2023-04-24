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
        view.backgroundColor = .white
        view.addSubview(generatedBranchLink)
        view.addSubview(branchBadgeImageView)
        view.addSubview(changeBackgroundColorButton)
        view.addSubview(buyNowButton)
        view.addSubview(addToCartButton)
        view.addSubview(colorBlockPageButton)
        view.addSubview(readDeepLinkButton)
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
    
    func createBranchLink() {
        let buo = BranchUniversalObject.init(canonicalIdentifier: "context/12345")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["key1"] = "value1"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "content 123 launch"
        lp.stage = "new user"
        lp.tags = ["one", "two", "three"]

        lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
        lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
        lp.addControlParam("$ipad_url", withValue: "http://example.com/ios")
        lp.addControlParam("$android_url", withValue: "http://example.com/android")
        lp.addControlParam("$match_duration", withValue: "2000")

        lp.addControlParam("custom_data", withValue: "yes")
        
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
        let buo = BranchUniversalObject.init(canonicalIdentifier: "context/23456")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["key1"] = "value1"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "content 123 launch"
        lp.stage = "new user"
        lp.tags = ["one", "two", "three"]

        lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
        lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
        lp.addControlParam("nav_to", withValue: "color_block_page")
        lp.addControlParam("color_block_key", withValue: "green")
        
        let message = "This link changes the color block"
        buo.showShareSheet(with: lp, andShareText: message, from: self) { (activityType, completed) in
            print(activityType ?? "")
        }
    }
    
    @objc func createQRCode() {
        let buo = BranchUniversalObject.init(canonicalIdentifier: "context/23456")
        buo.title = "My Content Title"
        buo.contentDescription = "My Content Description"
        buo.imageUrl = "https://lorempixel.com/400/400"
        buo.publiclyIndex = true
        buo.locallyIndex = true
        buo.contentMetadata.customMetadata["key1"] = "value1"
        
        let lp: BranchLinkProperties = BranchLinkProperties()
        lp.channel = "facebook"
        lp.feature = "sharing"
        lp.campaign = "content 123 launch"
        lp.stage = "new user"
        lp.tags = ["one", "two", "three"]

        lp.addControlParam("$desktop_url", withValue: "http://example.com/desktop")
        lp.addControlParam("$ios_url", withValue: "http://example.com/ios")
        
        let qrCode = BranchQRCode()
        qrCode.codeColor = UIColor.white
        qrCode.backgroundColor = UIColor.blue
        qrCode.centerLogo = "https://i.snipboard.io/nshJlY.jpg"
        qrCode.width = 350
        qrCode.margin = 0
        qrCode.imageFormat = .JPEG
        
        qrCode.getAsImage(buo, linkProperties: lp) { qrCodeImage, error in
            //Do something with your QR code here...
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
        .systemBlue,
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

        generatedBranchLink.translatesAutoresizingMaskIntoConstraints = false
        let generatedBranchLinkHorizontalConstraint = NSLayoutConstraint(item: generatedBranchLink, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let generatedBranchLinkVerticalConstraint = NSLayoutConstraint(item: generatedBranchLink, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: view.safeAreaInsets.top + 20)
        let generatedBranchLinkWidthConstraint = NSLayoutConstraint(item: generatedBranchLink, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let generatedBranchLinkHeightConstraint = NSLayoutConstraint(item: generatedBranchLink, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 40)
        
        branchBadgeImageView.translatesAutoresizingMaskIntoConstraints = false
        let branchBadgeImageViewHorizontalConstraint = NSLayoutConstraint(item: branchBadgeImageView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let branchBadgeImageViewVerticalConstraint = NSLayoutConstraint(item: branchBadgeImageView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: generatedBranchLink, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 20)
        let branchBadgeImageViewWidthConstraint = NSLayoutConstraint(item: branchBadgeImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 300)
        let branchBadgeImageViewHeightConstraint = NSLayoutConstraint(item: branchBadgeImageView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 300)
        
        changeBackgroundColorButton.translatesAutoresizingMaskIntoConstraints = false
        let changeBackgroundColorButtonHorizontalConstraint = NSLayoutConstraint(item: changeBackgroundColorButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let changeBackgroundColorButtonVerticalConstraint = NSLayoutConstraint(item: changeBackgroundColorButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: branchBadgeImageView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 20)
        let changeBackgroundColorButtonWidthConstraint = NSLayoutConstraint(item: changeBackgroundColorButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let changeBackgroundColorButtonHeightConstraint = NSLayoutConstraint(item: changeBackgroundColorButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 55)
        
        buyNowButton.translatesAutoresizingMaskIntoConstraints = false
        let buyNowButtonHorizontalConstraint = NSLayoutConstraint(item: buyNowButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let buyNowButtonVerticalConstraint = NSLayoutConstraint(item: buyNowButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: changeBackgroundColorButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let buyNowButtonWidthConstraint = NSLayoutConstraint(item: buyNowButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let buyNowButtonHeightConstraint = NSLayoutConstraint(item: buyNowButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 55)
        
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        let addToCartButtonHorizontalConstraint = NSLayoutConstraint(item: addToCartButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let addToCartButtonVerticalConstraint = NSLayoutConstraint(item: addToCartButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: buyNowButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let addToCartButtonWidthConstraint = NSLayoutConstraint(item: addToCartButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let addToCartButtonHeightConstraint = NSLayoutConstraint(item: addToCartButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 55)
        
        colorBlockPageButton.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockPageButtonHorizontalConstraint = NSLayoutConstraint(item: colorBlockPageButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let colorBlockPageButtonVerticalConstraint = NSLayoutConstraint(item: colorBlockPageButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: addToCartButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let colorBlockPageButtonWidthConstraint = NSLayoutConstraint(item: colorBlockPageButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let colorBlockPageButtonHeightConstraint = NSLayoutConstraint(item: colorBlockPageButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 55)
        
        readDeepLinkButton.translatesAutoresizingMaskIntoConstraints = false
        let readDeepLinkButtonHorizontalConstraint = NSLayoutConstraint(item: readDeepLinkButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let readDeepLinkButtonVerticalConstraint = NSLayoutConstraint(item: readDeepLinkButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: colorBlockPageButton, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 5)
        let readDeepLinkButtonWidthConstraint = NSLayoutConstraint(item: readDeepLinkButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: view.frame.size.width - 60)
        let readDeepLinkButtonHeightConstraint = NSLayoutConstraint(item: readDeepLinkButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 55)
        
        qrCode.translatesAutoresizingMaskIntoConstraints = false
        let qrCodeHorizontalConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let qrCodeVerticalConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let qrCodeWidthConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 350)
        let qrCodeHeightConstraint = NSLayoutConstraint(item: qrCode, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 350)
        
        self.view.addConstraints([generatedBranchLinkHorizontalConstraint, generatedBranchLinkVerticalConstraint, generatedBranchLinkWidthConstraint, generatedBranchLinkHeightConstraint, branchBadgeImageViewHorizontalConstraint, branchBadgeImageViewVerticalConstraint, branchBadgeImageViewWidthConstraint, branchBadgeImageViewHeightConstraint, changeBackgroundColorButtonHorizontalConstraint, changeBackgroundColorButtonVerticalConstraint, changeBackgroundColorButtonWidthConstraint, changeBackgroundColorButtonHeightConstraint, buyNowButtonHorizontalConstraint, buyNowButtonVerticalConstraint, buyNowButtonWidthConstraint, buyNowButtonHeightConstraint, addToCartButtonHorizontalConstraint, addToCartButtonVerticalConstraint, addToCartButtonWidthConstraint, addToCartButtonHeightConstraint, colorBlockPageButtonHorizontalConstraint, colorBlockPageButtonVerticalConstraint, colorBlockPageButtonWidthConstraint, colorBlockPageButtonHeightConstraint, readDeepLinkButtonHorizontalConstraint, readDeepLinkButtonVerticalConstraint, readDeepLinkButtonWidthConstraint, readDeepLinkButtonHeightConstraint, qrCodeHorizontalConstraint, qrCodeVerticalConstraint, qrCodeWidthConstraint, qrCodeHeightConstraint])
        
        setupNavigationMenuButtons()
        
        dimScreen.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    }
    
    // ---------- Setup Navigation Bar Items ----------
    
    func setupNavigationMenuButtons(){
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareBranchLink))
        
        let qrCodeButton = UIBarButtonItem(image: UIImage(systemName: "qrcode"), style: .plain, target: self, action: #selector(createQRCode))
        
        self.navigationItem.rightBarButtonItems = [shareButton, qrCodeButton]
    }
    
    // ---------- Buttons on the bottom of the page ----------
    
    private lazy var changeBackgroundColorButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x0074DF)
        button.setTitle("Change Background Color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(changeBackgroundColor), for: .touchUpInside)
        return button
    }()
    
    private lazy var buyNowButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x0074DF)
        button.setTitle("Buy Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(sendPurchaseEvent(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var addToCartButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x0074DF)
        button.setTitle("Add To Cart", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(sendAddToCartEvent(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var colorBlockPageButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x0074DF)
        button.setTitle("Color Block Page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(openColorBlockPage(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var readDeepLinkButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(rgb: 0x0074DF)
        button.setTitle("Read Link Data", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 20)
        button.layer.cornerRadius = 27.5
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(openReadDeepLinkPage(_:)), for: .touchUpInside)
        return button
    }()
    
    // ---------- Navigation Functions ----------
    
    @objc func openColorBlockPage(_ sender: UIButton) {
        let colorBlockPageController = ColorBlockViewController()
        self.show(colorBlockPageController, sender: colorBlockPageButton)
    }
    
    @objc func openReadDeepLinkPage(_ sender: UIButton) {
        let readDeepLinkPageController = ReadDeepLinkViewController()
        self.show(readDeepLinkPageController, sender: readDeepLinkButton)
    }
    
    // ---------- UILabels and UIImages ----------
    
    private let generatedBranchLink: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x1F2852)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont(name: "Raleway-Medium", size: 14)
        label.layer.borderColor = UIColor(rgb: 0xBCC0D4).cgColor
        label.layer.borderWidth = 1.5
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let branchBadgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.backgroundColor = .white

        //let url = URL(string: "https://www.branch.io/wp-content/uploads/2022/12/full-color-badge-1.svg")
        //let url = URL(string: "https://i.snipboard.io/5PW62T.jpg")

        //let data = try? Data(contentsOf: url!)
        //imageView.image = UIImage(data: data!)
        
        imageView.image = UIImage(named: "BranchBadgeDark")
    
        return imageView
    }()
    
    // ---------- QR Code Popup Views and Functions ----------
    
    // Dims screen around QR Code
    
    private let dimScreen: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()
    
    // Hides QR Code UIView on app initialization
    
    private let qrCode: UIView = {
        let view = UIView()
        view.isHidden = true
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
}

// Enables setting colors using hex codes

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
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
