//
//  GroupCell.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/9/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

protocol GroupCellProtocol {
    func moveToCreateTaskVC(group: Group)
}

final class GroupCell: UICollectionViewCell, NibReusable {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var groupNameLabel: UILabel!
    @IBOutlet private weak var numberOfTasksLabel: UILabel!
    @IBOutlet private weak var taskTableView: UITableView!

    fileprivate var group: Group!
    fileprivate var tasks: [Task]?
    var delegate: GroupCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableView()
    }
    
    private func setupTableView() {
        taskTableView.tableFooterView = UIView(frame: .zero)
        taskTableView.dataSource = self
        taskTableView.delegate = self
        taskTableView.rowHeight = UITableView.automaticDimension
        taskTableView.estimatedRowHeight = 100
        taskTableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
    }
    
    func configGroupCell(_ group: Group){
        let numOfTasks = group.tasks.count
        
        iconImageView.image = UIImage(named: group.icon ?? "")?.withRenderingMode(.alwaysTemplate)
        iconImageView.tintColor = UIColor(hexString: Colors.iconTintColorSelected.getColors())
        groupNameLabel.text = group.groupName
        numberOfTasksLabel.text = String(numOfTasks) + " tasks"
        tasks = group.tasks.toArray(ofType: Task.self)
        self.group = group
        taskTableView.reloadData()
    }

    @IBAction func handleAddTaskButtonTapped(_ sender: Any) {
        delegate.moveToCreateTaskVC(group: group)
    }
    
    @IBAction func handleDeleteButtonTapped(_ sender: Any) {
        AlertMessage.showMessage(title: "Message", msg: "Are you sure to delete this category?") { result in
            if result {
                RealmService.shared.delete(self.group)
            }
        }
    }
}

extension GroupCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TaskCell = tableView.dequeueReusableCell(for: indexPath)
        guard let taskData = tasks?[indexPath.row] else { return UITableViewCell() }
        cell.configTaskCell(taskData)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedTask = tasks?[indexPath.row] else { return }
        
        let isChecked = !selectedTask.isChecked
        let dictTask: [String: Any] = ["isChecked": isChecked]
        RealmService.shared.update(selectedTask, with: dictTask)
    }
}
