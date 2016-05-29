//
//  File.swift
//  SwiftyAccordionCells
//
//  Created by Sahil Dhankhar on 29/05/16.
//  Copyright © 2016 Justin M Fischer. All rights reserved.
//

import Foundation
import UIKit
class AccordianTable:NSObject,  UITableViewDelegate, UITableViewDataSource {
    
    var table: UITableView!
    
    init(table: UITableView, data: [SwiftyAccordionCells.Item]) {
        self.table = table
        self.data = data
        super.init()
        self.setup()
    }
    var data: [SwiftyAccordionCells.Item]
    var previouslySelectedHeaderIndex: Int?
    var previouslySelectedItemIndex: Int?
    
    
    var selectedHeaderIndex: Int?
    var selectedItemIndex: Int?
    var selectedSubItemIndex: Int?
    
    let cells = SwiftyAccordionCells()
    
    
    func setup() {
        for cell in self.data {
            self.cells.append(cell)
        }
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
            //        } else if (!item.isHidden && item is SwiftyAccordionCells.SubItem){
            //            return 44
        } else {
            return 44
        }
    }
    
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
            
            self.table.beginUpdates()
            self.table.endUpdates()
            
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
    }
}
