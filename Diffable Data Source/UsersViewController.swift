import UIKit

fileprivate typealias UserDataSource = UITableViewDiffableDataSource<UsersViewController.Section, User>
fileprivate typealias UsersSnapshot = NSDiffableDataSourceSnapshot<UsersViewController.Section, User>


class UsersViewController: UITableViewController {

    private let alertService = AlertService()
    
    private var users = [User]()
    
    private var dataSource: UserDataSource!
    
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        
        NetworkServiceManager().makeServiceCall(req: RequestModel(endpoint: "/api/users")) { (result) in
            switch result {
            case .success(let successResponse):
                print(".........successResponse.....")
                print(successResponse)
            case .failure(let serviceError):
                print(serviceError.localizedDescription)
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UserDataSource(tableView: tableView) { (tableView, indexPath, user) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = user.name
            return cell
        }
    }



    @IBAction private func didTapAddButton() {
        let alert = alertService.createUserAlert { [weak self] name in
            self?.addNewUser(with: name)
        }
        present(alert, animated: true)
    }
    
    private func addNewUser(with name: String) {
        count = count + 1
        let user = User(name: name, count: count)
        users.append(user)
        
        createSnapshot(from: users)

    }
    
    private func createSnapshot(from users: [User]) {
        var snapshot = UsersSnapshot()

        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: true)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let user = dataSource.itemIdentifier(for: indexPath) else { return }
        print(user)
    }


}

extension UsersViewController {
    fileprivate enum Section {
        case main
    }
}

