import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var shoppingItemsTVOutlet: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingItemsTVOutlet.dataSource = self
        shoppingItemsTVOutlet.delegate = self
        

    }
}

