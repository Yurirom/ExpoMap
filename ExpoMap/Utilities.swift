//
//  Utilities.swift
//  ExpoMap
//
//  Created by Yuri Romanov on 15.08.15.
//  Copyright (c) 2015 yurirom. All rights reserved.
//

import UIKit

func loadData() -> [Pavilion]	//	Загрузка исходных данных в массив объектов класса Pavilion
{
	var pav:[Pavilion] = []

	let path = NSBundle.mainBundle().pathForResource("Config", ofType: "txt")
	var content = String(contentsOfFile: path!, encoding: NSUTF16StringEncoding, error: nil)
	
	if content != nil
	{
		let EndSet: NSCharacterSet = NSCharacterSet(charactersInString: "\n")
		let CRSet: NSCharacterSet = NSCharacterSet(charactersInString: "\r")
		let TabSet: NSCharacterSet = NSCharacterSet(charactersInString: "\t")
		
		//	Парсируем файл исх. данных на строки, а строки на поля
		var str: [String] = content!.componentsSeparatedByCharactersInSet(EndSet)
		var ss: [String]
		
		if str[str.count - 1].isEmpty
		{
			str.removeLast()
		}
		
		for s in str
		{
			ss = s.componentsSeparatedByCharactersInSet(CRSet)
			ss = ss[0].componentsSeparatedByCharactersInSet(TabSet)
			
			if ss[0].isEmpty
			{
				continue
			}
			if ss.count == 5	//	Если строка "норм." - добавляем в массив исх. данных
			{
				var p = Pavilion()
				p.Name = ss[0]
				p.X = CGFloat(ss[1].toInt()!)
				p.Y = CGFloat(ss[2].toInt()!)
				p.W = CGFloat(ss[3].toInt()!)
				p.H = CGFloat(ss[4].toInt()!)
				let rect = CGRect(x: p.X, y: p.Y, width: p.W, height: p.H)
				p.PicV = UIImageView(frame: rect)
				p.PicV.layer.zPosition = 10
				p.PicV.layer.borderColor = UIColor(white: 0.3, alpha: 0.5).CGColor
				p.PicV.layer.borderWidth = 0.3
				pav.append(p)
			}
		}
	}
	return pav
}
