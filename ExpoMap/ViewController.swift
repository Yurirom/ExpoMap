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
		
//		self.performSegueWithIdentifier("ShowMap", sender: self)	//	Можно сразу перейти к карте, если снять комментарий
	}
	
	override func viewWillAppear(animated: Bool)
	{
		if selectedItem >= 0	//	При возврате из карты приводим выбранную строку таблицы в соответствие с картой
		{
			let idx = NSIndexPath(forRow: selectedItem, inSection: 0)
			Table.selectRowAtIndexPath(idx, animated: false, scrollPosition: .Middle)
			Table.scrollToRowAtIndexPath(
				idx, atScrollPosition: .Middle, animated: false)
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
		return cell
	}
	
	// MARK: - Подготовка к переходу по Segue
	// MARK: -
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
	{
		if segue.identifier == "ShowMap"
		{
			let row = Table.indexPathForSelectedRow()?.row
			selectedItem = (row == nil) ? -1 : row!

			// Готовим заголовок для navigationBar карты
			
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

