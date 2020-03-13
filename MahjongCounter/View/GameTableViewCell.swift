//
//  GameTableViewCell.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/3/13.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    var createDate: Date? {
        didSet {
            if let date = createDate {
                DateFormatter.shared.dateFormat = "yyyy-MM-dd HH:mm"
                textLabel?.text = DateFormatter.shared.string(from: date)
            }
        }
    }
    
    var isPlaying: Bool = false {
        didSet {
            detailTextLabel?.text = isPlaying ? "进行中" : nil
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 60)
    }
}
