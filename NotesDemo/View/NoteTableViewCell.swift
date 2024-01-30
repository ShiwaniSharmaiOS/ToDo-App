//
//  NoteTableViewCell.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 30/01/24.
//


import UIKit

class NoteTableViewCell : UITableViewCell {
    private(set) var noteTitle : String = ""
    private(set) var noteText  : String = ""
    private(set) var noteDate  : String = ""
    private(set) var noteImage : Data = Data()
 
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
}
