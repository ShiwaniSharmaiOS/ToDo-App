//
//  DetailViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 30/01/24.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteTextTextView: UITextView!
    @IBOutlet weak var noteDate: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!

    //MARK: Configuration
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let topicLabel = noteTitleLabel,
               let dateLabel = noteDate,
               let textView = noteTextTextView{
                topicLabel.text = detail.noteTitle
                dateLabel.text = NoteDateHelper.convertDate(date: Date.init(seconds: detail.noteTimeStamp))
                textView.text = detail.noteText
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    var detailItem: NoteModel? {
        didSet {
            configureView()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeNoteSegue" {
            let changeNoteViewController = segue.destination as! NoteCreateChangeViewController
            if let detail = detailItem {
                changeNoteViewController.setChangingReallySimpleNote(
                    changingReallySimpleNote: detail)
            }
        }
    }
}

