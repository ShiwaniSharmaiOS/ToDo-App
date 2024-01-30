//
//  NoteCreateChangeViewController.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 30/01/24.
//

import UIKit

class NoteCreateChangeViewController : UIViewController, UITextViewDelegate, UINavigationControllerDelegate {

    //MARK: IBOutlets
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextTextView: UITextView!
    @IBOutlet weak var noteDoneButton: UIButton!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteImageView: UIImageView!

    //MARK: Variables
    private let noteCreationTimeStamp : Int64 = Date().toSeconds()
    private(set) var changingNote : NoteModel?

    //MARK: IBACtions
    @IBAction func noteTitleChanged(_ sender: UITextField, forEvent event: UIEvent) {
        if self.changingNote != nil {
            noteDoneButton.isEnabled = true
        } else {
            if ( sender.text?.isEmpty ?? true ) || ( noteTextTextView.text?.isEmpty ?? true ) {
                noteDoneButton.isEnabled = false
            } else {
                noteDoneButton.isEnabled = true
            }
        }
    }
    
    @IBAction func imageButtonClicked(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = false
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)

    }

    @IBAction func doneButtonClicked(_ sender: UIButton, forEvent event: UIEvent) {
        if self.changingNote != nil {
            changeItem()
        } else {
            addItem()
        }
    }
    
    //MARK: Helper Functions
    func setChangingReallySimpleNote(changingReallySimpleNote : NoteModel) {
        self.changingNote = changingReallySimpleNote
    }
    
    private func addItem() -> Void {
        let note = NoteModel(
            noteTitle:     noteTitleTextField.text!,
            noteText:      noteTextTextView.text,
            noteTimeStamp: noteCreationTimeStamp)

        NoteStorage.storage.addNote(noteToBeAdded: note)
        
        performSegue(
            withIdentifier: "backToMasterView",
            sender: self)
    }

    private func changeItem() -> Void {
        if let changingReallySimpleNote = self.changingNote {
            NoteStorage.storage.changeNote(noteToBeChanged: NoteModel(
                    noteId: changingReallySimpleNote.noteId,
                    noteTitle: noteTitleTextField.text!,
                    noteText: noteTextTextView.text,
                    noteTimeStamp: noteCreationTimeStamp)
            )
            performSegue(withIdentifier: "backToMasterView",sender: self)
        } else {
            let alert = UIAlertController(title: "Unexpected error",message: "Cannot change the note, unexpected error occurred. Try again later.",preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",style: .default ) { (_) in self.performSegue(withIdentifier: "backToMasterView",sender: self)})
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextTextView.delegate = self
        if let changingNote = self.changingNote {
            noteDateLabel.text = NoteDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTextTextView.text = changingNote.noteText
            noteTitleTextField.text = changingNote.noteTitle
            noteDoneButton.isEnabled = true
        } else {
            noteDateLabel.text = NoteDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
        noteTextTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        noteTextTextView.layer.borderWidth = 1.0
        noteTextTextView.layer.cornerRadius = 5
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    func textViewDidChange(_ textView: UITextView) {
        if self.changingNote != nil {
            noteDoneButton.isEnabled = true
        } else {
            if ( noteTitleTextField.text?.isEmpty ?? true ) || (noteImageView.image == nil) || ( textView.text?.isEmpty ?? true ) {
                noteDoneButton.isEnabled = false
            } else {
                noteDoneButton.isEnabled = true
            }
        }
    }

}

extension NoteCreateChangeViewController: UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        noteImageView.image  = tempImage
        self.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
