//
//  ViewController.swift
//  ExpoMap
//
//  Created by Yuri Romanov on 15.08.15.
//  Copyright (c) 2015 yurirom. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
	
	@IBOutlet var Table: UITableView!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		pavilions = loadData()	// Загружаем исходные данные
	}
	
	override func viewWillAppear(animated: Bool)
	{
		if selectedItem >= 0
		{
			let idx = NSIndexPath(forRow: selectedItem, inSection: 0)
			Table.selectRowAtIndexPath(idx, animated: false, scrollPosition: UITableViewScrollPosition.None)
		}
	}
	
	// MARK: - Делегированные функции Table View
	// MARK: -
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	{
		return pavilions.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
	{
		let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath:indexPath) as! UITableViewCell
		cell.textLabel!.text = pavilions[indexPath.row].Name
		println(cell.textLabel!.text)
		return cell
	}
	
	
//	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
//	{
//		selectedItem = indexPath.row
//		println("row: \(selectedItem)")
//	}
	
	// MARK: - Подготовка к переходу по Segue
	// MARK: -
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "ShowMap"
		{
			let row = Table.indexPathForSelectedRow()?.row
			selectedItem = (row == nil) ? -1 : row!
			
			if selectedItem >= 0
			{
				segue.destinationViewController.navigationItem.title = pavilions[selectedItem].Name
			}
			else
			{
				segue.destinationViewController.navigationItem.title = "План-схема"
			}
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

