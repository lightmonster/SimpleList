//
//  ViewController.swift
//  A_Simple_List
//
//  Created by Derek Wu on 2016/12/31.
//  Copyright © 2016年 Xintong Wu. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications
import UserNotificationsUI



var dueList = [DueElement(dueName: "CS225 MP", dueDate: time(year: 2017, month: 1, date: 1, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 10, minute: 00)), DueElement(dueName: "ECON471 HW", dueDate: time(year: 2016, month: 12, date: 31, hour: 21, minute: 30), createdDate: time(year: 2016, month: 12, date: 29, hour: 12, minute: 30)), DueElement(dueName: "IOS Coding", dueDate: time(year: 2017, month: 1, date: 2, hour: 19, minute: 30), createdDate: time(year: 2016, month: 12, date: 30, hour: 21, minute: 30))]

//var refreshControl: UIRefreshControl!
//var customView: UIView!


class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var DueListView: UITableView!

    @IBAction func ListViewButton(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "AVC")
        secondViewController?.transitioningDelegate = self.viewTransitionManager
        //self.view.isHidden = true
        self.present(secondViewController!, animated: true, completion: nil)

    }
    @IBAction func ArchiveViewButton(_ sender: Any) {
            }
    @IBAction func PersonalInfoViewButton(_ sender: Any) {
    }
    
    var viewTransitionManager = ViewTransitionManager()
    
    let requestIdentifier = "SampleRequest"//request element
    
    //Shake detection
    //detect shake motion and send alert
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let alertController = UIAlertController(title: "Hey Nigga", message: "What do you want to do?", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    //notification setup
    func notify(){
        print("Change View button clicked")
        print("notification will be triggered in five seconds..Hold on tight")
        let content = UNMutableNotificationContent()
        content.title = "Intro to Notifications"
        content.subtitle = "Lets code,Talk is cheap"
        content.body = "Sample code from WWDC"
        content.sound = UNNotificationSound.default()
        
        //To Present image in notification
        if let path = Bundle.main.path(forResource: "monkey", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "sampleImage", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("attachment not found.")
            }
        }
        
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 5.0, repeats: false)
        let request = UNNotificationRequest(identifier:requestIdentifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        
        UNUserNotificationCenter.current().add(request){(error) in
            
            if (error != nil){
                
                print(error?.localizedDescription)
            }
        }
        
    }
    
    //Pan Gesture
    func createPanGestureRecognizer(targetView: UIView)
    {
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(self.handlePanGesture(panGesture:)))
        targetView.addGestureRecognizer(panGesture)
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIPanGestureRecognizer) -> Bool {
        let translation = gestureRecognizer.translation(in: view)
        let zero: CGPoint = CGPoint(x: 0, y: 0)
        gestureRecognizer.setTranslation(zero, in: view)
        let ref: CGFloat? = 30
        if (translation.y > ref!) { return true}
        else {return false}
    }
    
    func handlePanGesture(panGesture: UIPanGestureRecognizer) {
        
        //        get translation
        
        let translation = panGesture.translation(in: view)
//        if translation.dictionaryRepresentation = 
        let zero: CGPoint = CGPoint(x: 0, y: 0)
        panGesture.setTranslation(zero, in: view)
        //let x_loc:CGFloat? = translation.x
        let y_loc:CGFloat? = translation.y
        let ref : CGFloat? = 30
        print(translation.y)
        if (y_loc! > ref!)
        {
            print(">60")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            secondViewController?.transitioningDelegate = self.viewTransitionManager
            //self.view.isHidden = true
            self.present(secondViewController!, animated: true, completion: nil)
        }
        //create a new Label and give it the parameters of the old one
        //var label = panGesture.view as! UITableView
        //label.center = CGPoint(x: label.center.x+translation.x, y: label.center.y+translation.y)
        //label.isMultipleTouchEnabled = true
        //label.isUserInteractionEnabled = true
        
        if panGesture.state == UIGestureRecognizerState.began {
            
            //add something you want to happen when the Label Panning has started
            print("Begin")
        }
        
        if panGesture.state == UIGestureRecognizerState.ended {
            if (translation.y > 10) { print("?10")}
            //add something you want to happen when the Label Panning has ended
            
        }
        
        
        if panGesture.state == UIGestureRecognizerState.changed {
            
            //add something you want to happen when the Label Panning has been change ( during the moving/panning ) 
            
        }
            
        else {
            
            // or something when its not moving
        }
        
    }
    
//TODO: Try to use refreshcontent to triger IPV
    
//    func loadCustomRefreshContents() {
//        let refreshContents = Bundle.main.loadNibNamed("InputViewController", owner: self, options: nil)
        //customView = refreshContents?[0] as! UIView
//        customView = DueListView.backgroundView
//        customView.frame = refreshControl.bounds
//        refreshControl.addSubview(customView)
//    }
    
    //Swipe Gestures
    func handleSwipes(_ sender : UISwipeGestureRecognizer){
        if(sender.direction == .down /*&& sender.location(ofTouch: <#T##Int#>, in: <#T##UIView?#>)*/){
            print("check!")
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "IVC")
            //secondViewController?.transitioningDelegate = self.viewTransitionManager
            self.present(secondViewController!, animated: false, completion: nil)
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //notify(); //called notify function
        let InputViewController = segue.destination as! InputViewController
        InputViewController.transitioningDelegate = self.viewTransitionManager
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        //let sourceController = segue.source as! InputViewController
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("called tableview!")
        return(dueList.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var progress: Float?
        //custom progress bar
        let cell: DueElementCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DueElementCell

        progress = 1-(Float(dueList[indexPath.row].timeLeft!)/Float(dueList[indexPath.row].timeInterval!))
        cell.ProgressBar?.progressTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.5)
        cell.ProgressBar?.trackTintColor = dueList[indexPath.row].color?.withAlphaComponent(0.1)
        cell.ProgressBar?.setProgress(progress!, animated: true)
        
        cell.DueNameLabel?.text = dueList[indexPath.row].dueName
        cell.DueDateLabel?.text = String(dueList[indexPath.row].timeLeft!) + "Hrs"
        
        //add Mclist functionalities
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.defaultColor = UIColor(netHex:0xfaf8f8, isLargerAlpha: 1)
        cell.firstTrigger = 0.25;
        cell.secondTrigger = 0.45;
        
        
        //add Listener
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .switch, state: .state1, completionBlock: { (cell, state, mode) -> Void in
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "check")!), color: UIColor(netHex:0x1ABC9C, isLargerAlpha: 0.7), mode: .exit, state: .state2, completionBlock: { (cell, state, mode) -> Void in
            //register finishDate
            let date = NSDate()
            let calender = NSCalendar.current
            let month = calender.component(.month, from: date as Date)
            let day = calender.component(.day, from: date as Date)
            dueList[indexPath.row].finsihDate = time(year: nil, month: month, date: day, hour: nil, minute: nil)
            //swipe right to insert into archiveList; sort through finishDate
            if archiveList.isEmpty{
                archiveList.insert(dueList[indexPath.row], at:0)
            }else{
                var insertEnd = true
                for i in 0...archiveList.count-1{
                    if(dueList[indexPath.row].isLessInFinishDate(element: archiveList[i])){
                        archiveList.insert(dueList[indexPath.row], at: i)
                        insertEnd = false
                        break
                    }
                }
                if(insertEnd){
                    archiveList.append(dueList[indexPath.row])
                }
            }
            print("insert secceed")
            
            dueList.remove(at: indexPath.row)//potential bug
            self.DueListView.reloadData()
            
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color:  UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .switch, state: .state3, completionBlock: { (cell, state, mode) -> Void in
            
            
        })
        
        cell.setSwipeGestureWith(UIImageView(image: UIImage(named: "cross")!), color: UIColor(netHex:0xEC644B, isLargerAlpha: 0.7), mode: .exit, state: .state4, completionBlock: { (cell, state, mode) -> Void in
            
            dueList.remove(at: indexPath.row)//potential bug
            self.DueListView.reloadData()
            
        })

        
        return(cell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        //DueListView.addGestureRecognizer(swipeDown)
        
        createPanGestureRecognizer(targetView: self.DueListView)
        
//        refreshControl = UIRefreshControl()
//        refreshControl.
//        DueListView.addSubview(refreshControl)
//        if (refreshControl.isRefreshing == true)
//        {
//            print("refresh")
//        }
//        loadCustomRefreshContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, isLargerAlpha: Float) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(isLargerAlpha))
        
    }
    
    convenience init(netHex:Int, isLargerAlpha: Float) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, isLargerAlpha: isLargerAlpha)
    }
}

extension ListViewController:UNUserNotificationCenterDelegate{
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("Tapped in notification")
    }
    
    //This is key callback to present notification while the app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("Notification being triggered")
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        if notification.request.identifier == requestIdentifier{
            
            completionHandler( [.alert,.sound,.badge])
            
        }
    }
}

