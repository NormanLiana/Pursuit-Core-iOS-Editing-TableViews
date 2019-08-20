import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var shoppingList = [ShoppingItem]()
    
    @IBOutlet weak var shoppingItemsTVOutlet: UITableView!
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
        //suppose the source is an AddItemVC
        guard let addItemVC = segue.source as? AddItemsViewController else {
            fatalError()
        }
        guard let textFromName = addItemVC.nameTextField.text else {
            fatalError()
        }
        guard let textFromPrice = addItemVC.itemTextField.text else {
            fatalError()
        }
        guard let priceAsDouble = Double(textFromPrice) else {
            fatalError()
            
        }
        let newItem = ShoppingItem(name: textFromName, price: priceAsDouble)
        shoppingList.append(newItem)
        let lastIndex = shoppingItemsTVOutlet.numberOfRows(inSection: 0)
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        shoppingItemsTVOutlet.insertRows(at: [lastIndexPath], with: .automatic)
        
    }
    
   
    @IBAction func editButton(_ sender: UIButton) {
        if shoppingItemsTVOutlet.isEditing {
            shoppingItemsTVOutlet.setEditing(false, animated: true)
            sender.setTitle("Edit", for: .normal)
        } else {
            shoppingItemsTVOutlet.setEditing(true, animated: true)
            sender.setTitle("Done", for: .normal)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath)
        let selectedItem = shoppingList[indexPath.row]
        cell.textLabel?.text = selectedItem.price.description
        cell.detailTextLabel?.text = selectedItem.name
        return cell
    }
    
    private func loadShoppingItems() {
        let allItems = ShoppingItemFetchingClient.getShoppingItems()
        shoppingList = allItems
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingItemsTVOutlet.dataSource = self
        shoppingItemsTVOutlet.delegate = self
        loadShoppingItems()
        shoppingItemsTVOutlet.isEditing = false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("we hit delete")
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .middle)
        default:
            print("we did something")
        }
    }
   
}

