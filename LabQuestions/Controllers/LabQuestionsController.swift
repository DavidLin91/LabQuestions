//
//  ViewController.swift
//  LabQuestions
//
//  Created by Alex Paul on 12/10/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class LabQuestionsController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var refreshControl: UIRefreshControl!
    private var questions = [Question]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad() //super class = UIViewController itself
        tableView.dataSource = self
        loadQuestions()
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        
        // programmable target-action using objective-c runtime apo
        refreshControl.addTarget(self, action: #selector(loadQuestions), for: .valueChanged)
        
    }
    
    @objc  // allows func loadQuestions to objective c
    private func loadQuestions(){
        LabQuestionsAPIClient.fetchQuestions { [weak self] result in
            
            //stop refresh control and hide
            DispatchQueue.main.async {
            self?.refreshControl.endRefreshing()
            }
            
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                self?.showAlert(title: "App Error", message: "\(appError)")
                }
            case .success(let questions):
                // sorting by most recent Date
                // isoStringToDate() converts an ISO date string to a Date object
                // we need those Data objects so we can sort our lab questions
                // here we are sorting descdending a >z -> a
                self?.questions = questions.sorted{ $0.createdAt.isoStringToDate() > $1.createdAt.isoStringToDate()}
                DispatchQueue.main.async {
                    self?.navigationItem.title = "Lab Questions - \(questions.count)"
                }
            }
        }
    }
}

extension LabQuestionsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.title
        cell.detailTextLabel?.text = question.createdAt.convertISODate() + "- \(question.labName)"
        return cell
    }
}
