//
//  ToDo.swift
//  GuidedProject_todoList
//
//  Created by Tomonao Hashiguchi on 2022-05-12.
//

import Foundation

struct ToDo: Equatable, Codable{
    var id: UUID
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("toDos").appendingPathExtension("plist")
    
    init(title: String, isComplete: Bool, dueDate: Date, notes: String?){
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
        self.dueDate = dueDate
        self.notes = notes
    }
    
    static func == (lhs: ToDo, rls: ToDo) -> Bool{
        return lhs.id == rls.id
    }
    
    static func loadToDos() -> [ToDo]?{
        guard let codedToDos = try? Data(contentsOf: archiveURL) else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
    }
    
    static func saveToDos(_ toDos: [ToDo]){
        let propertyListEncoder = PropertyListEncoder()
        let codedToDos = try? propertyListEncoder.encode(toDos)
        try? codedToDos?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func sampleTodos() -> [ToDo]{
        let toDo1 = ToDo(title: "To Do one", isComplete: false, dueDate: Date(), notes: "Note one")
        let toDo2 = ToDo(title: "To Do two", isComplete: false, dueDate: Date(), notes: "Note two")
        let toDo3 = ToDo(title: "To Do three", isComplete: false, dueDate: Date(), notes: "Note three")
        
        return [toDo1, toDo2, toDo3]
    }
}
