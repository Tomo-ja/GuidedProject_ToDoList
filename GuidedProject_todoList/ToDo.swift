//
//  ToDo.swift
//  GuidedProject_todoList
//
//  Created by Tomonao Hashiguchi on 2022-05-12.
//

import Foundation

struct ToDo: Equatable{
    var id = UUID()
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func == (lhs: ToDo, rls: ToDo) -> Bool{
        return lhs.id == rls.id
    }
    
    static func loadToDos() -> [ToDo]?{
        return nil
    }
    
    static func sampleTodos() -> [ToDo]{
        let toDo1 = ToDo(title: "To Do one", isComplete: false, dueDate: Date(), notes: "Note one")
        let toDo2 = ToDo(title: "To Do two", isComplete: false, dueDate: Date(), notes: "Note two")
        let toDo3 = ToDo(title: "To Do three", isComplete: false, dueDate: Date(), notes: "Note three")
        
        return [toDo1, toDo2, toDo3]
    }
}
