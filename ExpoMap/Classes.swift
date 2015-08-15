//
//  Classes.swift
//  ExpoMap
//
//  Created by Yuri Romanov on 15.08.15.
//  Copyright (c) 2015 yurirom. All rights reserved.
//

import UIKit

// MARK: - Глобальные переменные (доступны из любого места программы)
// MARK: -

var pavilions: [Pavilion] = []	//	Массив данных о павильонах
var selectedItem: Int = -1		//	Текущий павильон (если выбран)

// MARK: - Вспомогательные классы
// MARK: -

class Pavilion
{
	var Name: String = ""			//	Name
	var X: CGFloat = 0              //  X center in pixels
	var Y: CGFloat = 0              //  Y center in pixels
	var W: CGFloat = 0              //  Width in pixels
	var H: CGFloat = 0              //  Height in pixels
	var PicV: UIImageView = UIImageView()
}
