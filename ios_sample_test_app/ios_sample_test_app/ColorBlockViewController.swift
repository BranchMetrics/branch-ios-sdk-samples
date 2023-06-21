//
//  ColorBlockViewController.swift
//  ios_sample_test_app
//
//  Created by Brandon Boothe on 4/2/23.
//

import UIKit
import BranchSDK

class ColorBlockViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get session parameters from Branch SDK
        
        guard let sessionParams = Branch.getInstance().getLatestReferringParams() else {return}
        
        // If session parameters contain a "color_block_key",
        // set the color of the block and set the description...
        // text to match the color.
        
        if let colorBlockKey = sessionParams["color_block_key"] as? String {
            colorBlockColorDescription.text = "Your color block is " + colorBlockKey + "."
            switch colorBlockKey {
            case "Red", "red":
                colorBlock.backgroundColor = .systemRed
            case "Green", "green":
                colorBlock.backgroundColor = .systemGreen
            case "Blue", "blue":
                colorBlock.backgroundColor = .systemBlue
            default:
                colorBlock.backgroundColor = .white
            }
        }
        
        self.title = "Color Block Routing"
        view.backgroundColor = .systemBackground
        
        // Checks if phone is in dark mode and modifies color of text for increased visibility
        
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                colorBlockPageDescription.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
                colorBlockColorDescription.textColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
            }
        }
        
        view.addSubview(colorBlockPageDescription)
        view.addSubview(colorBlock)
        view.addSubview(colorBlockColorDescription)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        colorBlockPageDescription.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockPageDescriptionVerticalConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 155)
        let colorBlockPageDescriptionLeadingConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 40)
        let colorBlockPageDescriptionTrailingConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -40)
        let colorBlockPageDescriptionHeightConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 100)
        
        colorBlock.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockVerticalConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 135)
        let colorBlockLeadingConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 100)
        let colorBlockTrailingConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -100)
        let colorBlockHeightConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 200)
        
        colorBlockColorDescription.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockColorDescriptionVerticalConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: colorBlock, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 100)
        let colorBlockColorDescriptionLeadingConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 100)
        let colorBlockColorDescriptionTrailingConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: -100)
        let colorBlockColorDescriptionHeightConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 25)
        
        self.view.addConstraints([colorBlockPageDescriptionVerticalConstraint, colorBlockPageDescriptionLeadingConstraint, colorBlockPageDescriptionTrailingConstraint, colorBlockPageDescriptionHeightConstraint, colorBlockVerticalConstraint, colorBlockLeadingConstraint, colorBlockTrailingConstraint, colorBlockHeightConstraint, colorBlockColorDescriptionVerticalConstraint, colorBlockColorDescriptionLeadingConstraint, colorBlockColorDescriptionTrailingConstraint, colorBlockColorDescriptionHeightConstraint])
    }
    
    // ---------- UILabels and UIViews for text and color block ----------
    
    private let colorBlockPageDescription: UILabel = {
        let label = UILabel()
        label.text = "The default color of the block is white. When this page opens via deep link with a specified \"blockColor\" parameter, the block changes to the specified color."
        label.textColor = UIColor(red: 0.30, green: 0.33, blue: 0.47, alpha: 1.00)
        label.font = UIFont(name: "Raleway-Italic", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let colorBlock: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor(red: 0.74, green: 0.75, blue: 0.83, alpha: 1.00).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let colorBlockColorDescription: UILabel = {
        let label = UILabel()
        label.text = "Your color block is White."
        label.textColor = UIColor(red: 0.30, green: 0.33, blue: 0.47, alpha: 1.00)
        label.font = UIFont(name: "Raleway-SemiBold", size: 16)
        label.textAlignment = .center
        return label
    }()
}
