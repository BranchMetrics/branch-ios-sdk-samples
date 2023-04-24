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
        view.backgroundColor = .white
        view.addSubview(colorBlockPageDescription)
        view.addSubview(colorBlock)
        view.addSubview(colorBlockColorDescription)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        colorBlockPageDescription.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockPageDescriptionHorizontalConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let colorBlockPageDescriptionVerticalConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 135)
        let colorBlockPageDescriptionWidthConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 300)
        let colorBlockPageDescriptionHeightConstraint = NSLayoutConstraint(item: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 100)
        
        colorBlock.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockHorizontalConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let colorBlockVerticalConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: colorBlockPageDescription, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 135)
        let colorBlockWidthConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 200)
        let colorBlockHeightConstraint = NSLayoutConstraint(item: colorBlock, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 200)
        
        colorBlockColorDescription.translatesAutoresizingMaskIntoConstraints = false
        let colorBlockColorDescriptionHorizontalConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let colorBlockColorDescriptionVerticalConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: colorBlock, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 100)
        let colorBlockColorDescriptionWidthConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 250)
        let colorBlockColorDescriptionHeightConstraint = NSLayoutConstraint(item: colorBlockColorDescription, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 25)
        
        self.view.addConstraints([colorBlockHorizontalConstraint, colorBlockVerticalConstraint, colorBlockWidthConstraint, colorBlockHeightConstraint, colorBlockPageDescriptionHorizontalConstraint, colorBlockPageDescriptionVerticalConstraint, colorBlockPageDescriptionWidthConstraint, colorBlockPageDescriptionHeightConstraint, colorBlockColorDescriptionHorizontalConstraint, colorBlockColorDescriptionVerticalConstraint, colorBlockColorDescriptionWidthConstraint, colorBlockColorDescriptionHeightConstraint])
    }
    
    // ---------- UILabels and UIViews for text and color block ----------
    
    private let colorBlockPageDescription: UILabel = {
        let label = UILabel()
        label.text = "The default color of the block is white. When this page opens via deep link with a specified \"blockColor\" parameter, the block changes to the specified color."
        label.textColor = UIColor(rgb: 0x04C5478)
        label.font = UIFont(name: "Raleway-Italic", size: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let colorBlock: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2.0
        view.layer.borderColor = UIColor(rgb: 0xBCC0D4).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let colorBlockColorDescription: UILabel = {
        let label = UILabel()
        label.text = "Your color block is White."
        label.textColor = UIColor(rgb: 0x04C5478)
        label.font = UIFont(name: "Raleway-SemiBold", size: 16)
        label.textAlignment = .center
        return label
    }()
}
