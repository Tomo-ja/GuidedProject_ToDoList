//
//  ToDoDetailsTableViewController.swift
//  GuidedProject_todoList
//
//  Created by Tomonao Hashiguchi on 2022-05-12.
//

import UIKit

class ToDoDetailsTableViewController: UITableViewController {
    
    var toDo: ToDo?

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var dueDateLabel: UILabel!
    @IBOutlet var dueDatePicker: UIDatePicker!
    @IBOutlet var notesTextView: UITextView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var isDatePickerHidden = true
    let dateLableIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDueDate: Date
        if let toDo = toDo{
            navigationItem.title = "To-Do"
            titleTextField.text = toDo.title
            isCompleteButton.isSelected = toDo.isComplete
            currentDueDate = toDo.dueDate
            notesTextView.text = toDo.notes
        }else{
            currentDueDate = Date().addingTimeInterval(24*60*60)
        }
        
        dueDatePicker.date = currentDueDate
        updateDueDateLabel(date: currentDueDate)
        updateSaveButtonState()

    }

    func updateSaveButtonState(){
        let shouldEnableSaveButton = titleTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    func updateDueDateLabel(date: Date){
        dueDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
            case datePickerIndexPath where isDatePickerHidden == true: return 0
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath{
            case datePickerIndexPath:
                return 216
            case notesIndexPath:
                return 200
            default:
                return UITableView.automaticDimension
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLableIndexPath{
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: dueDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else {return}
        
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePicker.date
        let notes = notesTextView.text
        
        if toDo != nil {
            toDo?.title = title
            toDo?.isComplete = isComplete
            toDo?.dueDate = dueDate
            toDo?.notes = notes
        }else{
            toDo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes)
        }
    }
}
