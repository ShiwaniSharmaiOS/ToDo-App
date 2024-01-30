//
//  NoteStorage.swift
//  NotesDemo
//
//  Created by Shiwani sharma on 30/01/24.
//

import CoreData

class NoteStorage {
    static let storage : NoteStorage = NoteStorage()
    
    private var noteIndexToIdDict : [Int:UUID] = [:]
    private var currentIndex : Int = 0

    private(set) var managedObjectContext : NSManagedObjectContext
    private var managedContextHasBeenSet : Bool = false
    
    private init() {
        managedObjectContext = NSManagedObjectContext(
            concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
    }
    
    func setManagedContext(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        self.managedContextHasBeenSet = true
        let notes = NoteCoreDataHelper.readNotesFromCoreData(fromManagedObjectContext: self.managedObjectContext)
        currentIndex = NoteCoreDataHelper.count
        for (index, note) in notes.enumerated() {
            noteIndexToIdDict[index] = note.noteId
        }
    }
    
    func addNote(noteToBeAdded: NoteModel) {
        if managedContextHasBeenSet {
            noteIndexToIdDict[currentIndex] = noteToBeAdded.noteId
            NoteCoreDataHelper.createNoteInCoreData(noteToBeCreated: noteToBeAdded,intoManagedObjectContext: self.managedObjectContext)
            currentIndex += 1
        }
    }
    
    func removeNote(at: Int) {
        if managedContextHasBeenSet {
            if at < 0 || at > currentIndex-1 {
                return
            }
            let noteUUID = noteIndexToIdDict[at]
            NoteCoreDataHelper.deleteNoteFromCoreData(
                noteIdToBeDeleted:        noteUUID!,
                fromManagedObjectContext: self.managedObjectContext)
            if (at < currentIndex - 1) {
                for i in at ... currentIndex - 2 {
                    noteIndexToIdDict[i] = noteIndexToIdDict[i+1]
                }
            }
            noteIndexToIdDict.removeValue(forKey: currentIndex)
            currentIndex -= 1
        }
    }
    
    func readNote(at: Int) -> NoteModel? {
        if managedContextHasBeenSet {
            if at < 0 || at > currentIndex-1 {
                return nil
            }
            let noteUUID = noteIndexToIdDict[at]
            let noteReadFromCoreData: NoteModel?
            noteReadFromCoreData = NoteCoreDataHelper.readNoteFromCoreData(noteIdToBeRead: noteUUID!, fromManagedObjectContext: self.managedObjectContext)
            return noteReadFromCoreData
        }
        return nil
    }
    
    func changeNote(noteToBeChanged: NoteModel) {
        if managedContextHasBeenSet {
            var noteToBeChangedIndex : Int?
            noteIndexToIdDict.forEach { (index: Int, noteId: UUID) in
                if noteId == noteToBeChanged.noteId {
                    noteToBeChangedIndex = index
                    return
                }
            }
            if noteToBeChangedIndex != nil {
                NoteCoreDataHelper.changeNoteInCoreData(
                    noteToBeChanged: noteToBeChanged,
                    inManagedObjectContext: self.managedObjectContext)
            } else {
            }
        }
    }
    
    func count() -> Int {
        return NoteCoreDataHelper.count
    }
}
