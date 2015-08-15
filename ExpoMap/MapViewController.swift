//
//  MapViewController.swift
//  ExpoMap
//
//  Created by Yuri Romanov on 15.08.15.
//  Copyright (c) 2015 yurirom. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, UIScrollViewDelegate
{
	
	@IBOutlet var scrollView: UIScrollView!
	
	@IBOutlet weak var ContentView: UIView!
	
	@IBOutlet weak var MapImageView: UIImageView!
	
	let pavilionsColor = UIColor(red: 1, green: 0.6, blue: 0.6, alpha: 0.6)
	let pavilionSelectedColor = UIColor(red: 1, green: 0.4, blue: 0.2, alpha: 0.8)
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		scrollView.contentSize = MapImageView.image!.size

		//	Добавим 2 GestureRecognizer: одиночное нажатие - для выбора
		//	объекта и двойного - для сброса масштаба и позиции карты
		//	к исходному положению
		
		var tapRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
		tapRecognizer.numberOfTapsRequired = 1
		tapRecognizer.numberOfTouchesRequired = 1
		scrollView.addGestureRecognizer(tapRecognizer)
		var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
		doubleTapRecognizer.numberOfTapsRequired = 2
		doubleTapRecognizer.numberOfTouchesRequired = 1
		scrollView.addGestureRecognizer(doubleTapRecognizer)
		
		//	Вычисляем поправочный коэффициент на координаты объектов, после того, как
		//	исходную карту вписали в экран девайса
		
		let pscale = min(self.view.frame.size.width / MapImageView.image!.size.width, self.view.frame.size.height / MapImageView.image!.size.height)
		
		//	Добавляем объекты на карту
		
		for i in 0..<pavilions.count
		{
			let W = pavilions[i].W * pscale
			let H = pavilions[i].H * pscale
			pavilions[i].PicV.frame.size = CGSize(width: W, height: H)
			pavilions[i].PicV.backgroundColor = pavilionsColor
			if selectedItem == i
			{
				pavilions[i].PicV.backgroundColor = pavilionSelectedColor
			}
			
			ContentView.addSubview(pavilions[i].PicV)
		}

		setPavilionsPositions(self.view.frame.size)	//	Позиционируем объекты на карте
	}
	
	// MARK: - Если решили повращать девайс - корректируем позиции объектов
	// MARK: -
	
	override func viewWillTransitionToSize(size: CGSize,
		withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
	{
		setPavilionsPositions(size)
	}
	
	// MARK: - Функции распознавания жестов
	// MARK: -

	func handleDoubleTap(recognizer: UITapGestureRecognizer)
	{
		scrollView.zoomScale = 1.0
	}
	
	func handleTap(recognizer: UITapGestureRecognizer)
	{
		let p = recognizer.locationInView(ContentView)
		
		for i in 0..<pavilions.count
		{
			pavilions[i].PicV.backgroundColor = pavilionsColor
			if CGRectContainsPoint(pavilions[i].PicV.frame, p)
			{
				selectedItem = i
			}
		}
		if selectedItem >= 0	//	Выделяем новый объект
		{
			pavilions[selectedItem].PicV.backgroundColor = pavilionSelectedColor
			self.navigationItem.title = pavilions[selectedItem].Name
			if scrollView.zoomScale > 1
			{
				let rect = CGRect(x: pavilions[selectedItem].PicV.frame.minX - pavilions[selectedItem].PicV.frame.width * 2, y: pavilions[selectedItem].PicV.frame.minY - pavilions[selectedItem].PicV.frame.height * 2, width: pavilions[selectedItem].PicV.frame.width * 5, height: pavilions[selectedItem].PicV.frame.height * 5)
				scrollView.zoomToRect(rect, animated: true)
			}
		}
	}
	
	// MARK: - Делегированные функции
	// MARK: -
	
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
	{
		return ContentView
	}
	
	func scrollViewDidZoom(scrollView: UIScrollView)
	{
//		centerScrollViewContents()
	}
	
	// MARK: - Прочие функции
	// MARK: -
	
	func setPavilionsPositions(size: CGSize)	//	Позиционируем объекты в зависимости от size
	{
		let pscale = min(size.width / MapImageView.image!.size.width, size.height / MapImageView.image!.size.height)
		
		let posMapX = (size.width - MapImageView.image!.size.width * pscale) / 2.0
		let posMapY = (size.height - MapImageView.image!.size.height * pscale) / 2.0

		for i in 0..<pavilions.count
		{
			let X = pavilions[i].X * pscale + posMapX
			let Y = pavilions[i].Y * pscale + posMapY
			pavilions[i].PicV.center = CGPointMake(X, Y)
		}
	}
}
