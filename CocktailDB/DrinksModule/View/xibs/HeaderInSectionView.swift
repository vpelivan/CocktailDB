//
//  HeaderInSectionView.swift
//  CocktailDB
//
//  Created by Victor Pelivan on 19.06.2020.
//  Copyright © 2020 Viktor Pelivan. All rights reserved.
//

import UIKit

class HeaderInSectionView: UIView {

    @IBOutlet weak var headerLabel: UILabel!
    
    var view: UIView!
    var nibName: String = "HeaderInSectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    private func setup() {
        view = loadFromNib()
        view.frame = CGRect.zero
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
    
    

}
