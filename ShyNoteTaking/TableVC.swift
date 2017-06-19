//
//  TableVC.swift
//  ShyNoteTaking
//
//  Created by Andi on 2016-12-22.
//  Copyright © 2016 andiroot. All rights reserved.
//

import UIKit
import CoreData

class TableVC: UITableViewController,NSFetchedResultsControllerDelegate {
   // let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //let frc = NSFetchedResultsController = NSFetchedResultsController()
    
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    lazy var fetchedResultsController:NSFetchedResultsController<NSFetchRequestResult>={
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        var itemEntity=NSEntityDescription.entity(forEntityName: "NoteData", in:self.context)
        fetchRequest.entity=itemEntity
        let sortDescriptors=NSSortDescriptor(key: "note",ascending: true)
        fetchRequest.sortDescriptors=[sortDescriptors]
        let fetchedResultsController=NSFetchedResultsController(fetchRequest: fetchRequest,managedObjectContext: self.context,sectionNameKeyPath:nil,cacheName:nil)
        fetchedResultsController.delegate=self
        return fetchedResultsController
        
    }()
    
    
    
    
    
    
    
    
    
    var tasks: [NoteData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        do{
            try self.fetchedResultsController.performFetch()
            
        }catch{
        
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getData()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        cell.textLabel?.text = task.note!
        //var note = task.note!
       // var qty = task.qty!
        //cell.detailTextLabel?.text = "Qty: \(qty) - \(note)"
        // Configure the cell...
        
        return cell
    }
    func getData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            tasks = try context.fetch(NoteData.fetchRequest())
        }catch{
            print("Fetching failed.")
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
   // =================================================
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        
        //code for deleting row
        
        if editingStyle == .delete{
            let task = tasks[indexPath.row]
            context.delete(task)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do{
            try tasks = context.fetch(NoteData.fetchRequest())
            }
            catch{
            
            }
            tableView.reloadData()
        }
        //code for edit
        /*
        else{
        let managedObject : NSManagedObject = fetchedResultsController.object(at: indexPath) as! NSManagedObject
        context.delete(managedObject)
        do{
            try context.save()
         }
        catch  let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        }*/
    }
        
   // =================================================
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       //==============================
        /*
        if segue.identifier == "edit"
        {
            
    let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let itemController : MainVC = segue.destination as! MainVC
            let nItem : NoteData = fetchedResultsController.object(at: indexPath!) as! NoteData
            itemController.nItem = nItem
        
        }
        */
        //=======================================
        
        
        if segue.identifier == "edit"{
            let path = tableView.indexPathForSelectedRow
            let cell = tableView.cellForRow(at: path!)
            let indexPath = tableView.indexPath(for: cell!)
            let itemController :MainVC = segue.destination as! MainVC
            let itemdata: NoteData = fetchedResultsController.object(at: indexPath!) as! NoteData
            itemController.nItem = itemdata
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
    
    

}
