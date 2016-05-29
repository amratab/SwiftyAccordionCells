//
//  ViewController.swift
//  SwiftyAccordionCells
//
//  Created by Fischer, Justin on 9/24/15.
//  Copyright © 2015 Justin M Fischer. All rights reserved.
//

import UIKit

class ViewController:UIViewController,  UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var table: UITableView!

    
    override func viewDidLoad() {
//        super.viewDidLoad()
//        let data = [SwiftyAccordionCells.HeaderItem(value: "Title 1"),
//                SwiftyAccordionCells.Item(value: "Sub Item 1"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 1"),
//                SwiftyAccordionCells.Item(value: "Sub Item 2"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 2"),
//                SwiftyAccordionCells.HeaderItem(value: "Title 2"),
//                SwiftyAccordionCells.Item(value: "Sub Item 1"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 21"),
//                SwiftyAccordionCells.HeaderItem(value: "Title 3"),
//                SwiftyAccordionCells.Item(value: "Sub Item 1"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 31"),
//                SwiftyAccordionCells.Item(value: "Sub Item 2"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 32"),
//                SwiftyAccordionCells.Item(value: "Sub Item 3"),
//                SwiftyAccordionCells.SubItem(value: "Sub Sub Item 33")]
//        let accordianTable = AccordianTable(table: table, data: data)
//        table.dataSource = accordianTable
//        table.delegate = accordianTable
        self.setup()

        
    }
    
    var previouslySelectedHeaderIndex: Int?
    var previouslySelectedItemIndex: Int?
    
    
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    var selectedSubItemIndex: Int?
    
    let cells = SwiftyAccordionCells()
    
    
    func setup() {
//        for cell in self.data {
//            self.cells.append(cell)
//        }
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 2"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 21"))
        self.cells.append(SwiftyAccordionCells.HeaderItem(value: "Title 3"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 1"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 31"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 2"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 32"))
        self.cells.append(SwiftyAccordionCells.Item(value: "Sub Item 3"))
        self.cells.append(SwiftyAccordionCells.SubItem(value: "Sub Sub Item 33"))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cells.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = self.cells.items[indexPath.row]
        let value = item.value as? String
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("cell") {
            cell.textLabel?.text = value
            
            if item as? SwiftyAccordionCells.HeaderItem != nil {
                cell.backgroundColor = UIColor.greenColor()
                let expandButton = UIButton(type: UIButtonType.Custom) as UIButton
                expandButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                expandButton.setImage(UIImage(named: "expand.png"), forState: UIControlState.Normal)
                cell.accessoryView = expandButton as UIView
            }else if item as? SwiftyAccordionCells.SubItem != nil {
                cell.backgroundColor = UIColor.redColor()
                cell.accessoryType = UITableViewCellAccessoryType.None
            } else {
                let expandButton = UIButton(type: UIButtonType.Custom) as UIButton
                expandButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                expandButton.setImage(UIImage(named: "expand.png"), forState: UIControlState.Normal)
                cell.accessoryView = expandButton as UIView
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let item = self.cells.items[indexPath.row]
        
        if item is SwiftyAccordionCells.HeaderItem {
            return 60
        } else if (item.isHidden) {
            return 0
        } else {
            return 44
        }
    }
//    
//    func tableView(tableView: UITableView, accessoryTypeForRowWithIndexPath indexPath: NSIndexPath) -> UITableViewCellAccessoryType {
//        let item = self.cells.items[indexPath.row]
//
//        let expandButton = UIButton(type: UIButtonType.Custom) as UIButton
//        let collapseButton = UIButton(type: UIButtonType.Custom) as UIButton
//        expandButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        expandButton.setImage(UIImage(named: "expand.png"), forState: UIControlState.Normal)
//        collapseButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
//        collapseButton.setImage(UIImage(named: "collapse.png"), forState: UIControlState.Normal)
//        if item is SwiftyAccordionCells.SubItem {
//            return UITableViewCellAccessoryType.None
//        } else if (item.isExpanded) {
//            return collapseButton as UIView
//        }
//    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let item = self.cells.items[indexPath.row]
        let cell = self.table.cellForRowAtIndexPath(indexPath)
        let expandButton = UIButton(type: UIButtonType.Custom) as UIButton
        let collapseButton = UIButton(type: UIButtonType.Custom) as UIButton
        expandButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        expandButton.setImage(UIImage(named: "expand.png"), forState: UIControlState.Normal)
        collapseButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        collapseButton.setImage(UIImage(named: "collapse.png"), forState: UIControlState.Normal)
        //        var imageView : UIImageView
        //        imageView  = UIImageView(frame:CGRectMake(20, 20, 100, 320))
        //        imageView.image = UIImage(named:"expand.png")
        
        // then set it as cellAccessoryType
        //        cell.accessoryView = imageView
        if item is SwiftyAccordionCells.HeaderItem {
            if self.selectedHeaderIndex == nil {
                self.selectedHeaderIndex = indexPath.row
            } else {
                self.previouslySelectedHeaderIndex = self.selectedHeaderIndex
                self.selectedHeaderIndex = indexPath.row
            }
            
            if let previouslySelectedHeaderIndex = self.previouslySelectedHeaderIndex {
                let previousIndexPath = NSIndexPath(forItem: previouslySelectedHeaderIndex, inSection: 0)
                let previousCell = self.table.cellForRowAtIndexPath(previousIndexPath)
                previousCell?.accessoryView = expandButton as UIView
                self.cells.collapse(previouslySelectedHeaderIndex)
            }
            
            if self.previouslySelectedHeaderIndex != self.selectedHeaderIndex {
                self.cells.expand(self.selectedHeaderIndex!)
                cell?.accessoryView = collapseButton as UIView
            } else {
                cell?.accessoryView = expandButton as UIView
                self.selectedHeaderIndex = nil
                self.previouslySelectedHeaderIndex = nil
            }
            
            self.table.beginUpdates()
            self.table.endUpdates()
            
        } else if !(item is SwiftyAccordionCells.SubItem) {
            if self.selectedItemIndex == nil {
                self.selectedItemIndex = indexPath.row
            } else {
                self.previouslySelectedItemIndex = self.selectedItemIndex
                self.selectedItemIndex = indexPath.row
            }
            
            if let previouslySelectedItemIndex = self.previouslySelectedItemIndex {
                let previousIndexPath = NSIndexPath(forItem: previouslySelectedItemIndex, inSection: 0)
                let previousCell = self.table.cellForRowAtIndexPath(previousIndexPath)
                previousCell?.accessoryView = expandButton as UIView
                self.cells.collapse(previouslySelectedItemIndex)
            }
            
            if self.previouslySelectedItemIndex != self.selectedItemIndex {
                self.cells.expand(self.selectedItemIndex!)
                cell?.accessoryView = collapseButton as UIView
            } else {
                cell?.accessoryView = expandButton as UIView
                self.selectedItemIndex = nil
                self.previouslySelectedItemIndex = nil
            }
            
            //        } else {
            //            if indexPath.row != self.selectedSubItemIndex {
            //                if let selectedSubItemIndex = self.selectedSubItemIndex {
            //                    let previousCell = self.table.cellForRowAtIndexPath(NSIndexPath(forRow: selectedSubItemIndex, inSection: 0))
            //                    previousCell?.accessoryType = UITableViewCellAccessoryType.None
            //                }
            //
            //                self.selectedSubItemIndex = indexPath.row
            //            }
        }
        self.table.beginUpdates()
        self.table.endUpdates()
        self.updateHiddenItems()
    }
    
    func updateHiddenItems() {
        for (index, cell) in self.cells.items.enumerate() {
            if !(cell is SwiftyAccordionCells.SubItem) && cell.isHidden {
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                let hiddenCell = self.table.cellForRowAtIndexPath(indexPath)
                let expandButton = UIButton(type: UIButtonType.Custom) as UIButton
                expandButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                expandButton.setImage(UIImage(named: "expand.png"), forState: UIControlState.Normal)
                hiddenCell?.accessoryView = expandButton as UIView
            }
        }
    }

}
