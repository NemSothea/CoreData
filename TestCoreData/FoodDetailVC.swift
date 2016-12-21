//
//  FoodDetailVC.swift
//  TestCoreData
//
//  Created by sok channy on 12/1/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit
import CoreData

class FoodDetailVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var foodCategory: UIPickerView!
    @IBOutlet weak var incredientTable:UITableView!
    
    var imagePicker:UIImagePickerController!
    
    var categories:[Category] = []
    var incredients:[Incredient] = []
    var foodIncredients:[Incredient] = []
    
    var foodToEdit:Food?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodCategory.dataSource = self
        foodCategory.delegate = self
        
        incredientTable.dataSource = self
        incredientTable.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if let topItem = self.navigationController?.navigationBar.topItem{
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        
//        let c:Category = Category(context: appContext)
//        c.name = "Dring"
//        let c1:Category = Category(context: appContext)
//        c1.name = "Snake"
//        let c2:Category = Category(context: appContext)
//        c2.name = "Dinner"
//        let c3:Category = Category(context: appContext)
//        c3.name = "Launch"
//        appDelegate.saveContext()
//        
//        let i1:Incredient = Incredient(context:appContext)
//        i1.name = "cafe"
//        let i2:Incredient = Incredient(context:appContext)
//        i2.name = "papaya"
//        let i3:Incredient = Incredient(context:appContext)
//        i3.name = "onion"
//        let i4:Incredient = Incredient(context:appContext)
//        i4.name = "chili"
//        let i5:Incredient = Incredient(context:appContext)
//        i5.name = "sugur"
//        appDelegate.saveContext()
        
        fetchCategory()
        fetchIncredient()
        
        if foodToEdit != nil {
            loadFoodData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categories[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func fetchCategory(){
        let fetchRequest:NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            self.categories = try appContext.fetch(fetchRequest)
            self.foodCategory.reloadAllComponents()
        } catch {
            let error = error as NSError
            print("**** ERROR *** \(error)")
        }
    }
    
    func fetchIncredient(){
        let fetchRequest:NSFetchRequest<Incredient> = Incredient.fetchRequest()
        do{
            self.incredients = try appContext.fetch(fetchRequest)
        } catch {
            let error = error as NSError
            print("*** ERROR *** \(error)")
        }
    }
    
    
    @IBAction func addFoodPress(_ sender:Any){
        let food:Food!
        let picture = Image(context: appContext)
        picture.image = foodImage.image
        
        if foodToEdit != nil {
            food = foodToEdit
        }else{
            food = Food(context : appContext)

        }
        food.toImage = picture
        
        
        if let name = self.name.text {
            food.name = name
        }
        if let price = self.price.text {
            food.price = (price as NSString).doubleValue
        }
        food.toCategory = categories[foodCategory.selectedRow(inComponent: 0)]
//        for incredient in foodIncredients{
//            print("Adding to incredient")
//            food.addToToIncredient(incredient)
//        }
        
        appDelegate.saveContext()
        _ = navigationController?.popViewController(animated: false)
    }
    @IBAction func deletePress(_ sender: Any) {
        if foodToEdit != nil {
            appContext.delete(foodToEdit!)
            appDelegate.saveContext()
        }
        _ = navigationController?.popViewController(animated: false)
    }

    func loadFoodData(){
        if let food = foodToEdit{
            name.text = food.name
            price.text = "\(food.price)"
            
            foodImage.image = food.toImage?.image as? UIImage
            
            if let category = food.toCategory {
                var index = 0
                repeat {
                    let c = categories[index]
                    if c.name == category.name {
                        foodCategory.selectRow(index, inComponent: 0, animated: true)
                        break
                    }
                    index += 1
                }while (index < categories.count)
            }
        }
    }
    
    @IBAction func addImage(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func openCameraPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
            foodImage.image = img
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // *************** Incredient table ************** // 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return incredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incredientCellID", for: indexPath) as! incredientCell
        print("CELL WORK \(indexPath.row)")
        cell.configureationCell(incredient : incredients[indexPath.row])
        if foodToEdit != nil {
            for incredient in (foodToEdit?.toIncredient)!{
                let incre = incredient as! Incredient
                if incre.name! == incredients[indexPath.row].name{
                    cell.isCheck = true
                    foodIncredients.append(incredients[indexPath.row])
                                    }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = incredientTable.cellForRow(at: indexPath) as! incredientCell
        cell.isCheck = !cell.isCheck
        if cell.isCheck {
            //foodIncredients.append(incredients[indexPath.row])
            foodToEdit?.addToToIncredient(incredients[indexPath.row])
        }else{
            var i = 0
            for incredient in foodIncredients{
                if incredient.name == cell.incredientLabel.text {
                    //foodIncredients.remove(at: i)
                    print("Remov")
                    foodToEdit?.removeFromToIncredient(incredients[indexPath.row])
                }
                i += 1
            }
        }
    }
    @IBAction func swictIncredient(_ sender: UISwitch) {
//        if sender.isOn {
//            if foodToEdit != nil {
//                tableView(incredientTable, didSelectRowAt: IndexPath.init(row: 1, section: 0))
//            }
//        }
    }
}
