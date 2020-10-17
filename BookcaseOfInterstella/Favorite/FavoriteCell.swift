//
//  FavoriteCell.swift
//  BookcaseOfInterstella
//
//  Created by 강인희 on 2020/10/10.
//  Copyright © 2020 Keunna Lee. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var writtenLabel: UILabel!
    @IBOutlet weak var writtenDate: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        writtenLabel.text = "작성일 : "
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
