//
//  CurrentChartView.swift
//  Corona Tracker
//
//  Created by Mohammad on 3/7/20.
//  Copyright © 2020 Samabox. All rights reserved.
//

import UIKit

import Charts

class CurrentChartView: ChartView<PieChartView> {
	override func initializeView() {
		super.initializeView()

		chartView.usePercentValuesEnabled = true
		chartView.holeColor = nil
		chartView.holeRadiusPercent = 0.5
		chartView.transparentCircleRadiusPercent = 0.6
		chartView.maxAngle = 180
		chartView.rotationAngle = 180
		chartView.drawEntryLabelsEnabled = false
		chartView.setExtraOffsets(left: 0, top: 100, right: 0, bottom: -300)

		chartView.rotationEnabled = false

		chartView.marker = SimpleMarkerView(chartView: chartView)
	}

	override func update(region: Region?, animated: Bool) {
		super.update(region: region, animated: animated)

		guard let report = region?.report else {
			chartView.data = nil
			return
		}

		var dataEntries: [PieChartDataEntry] = []
		dataEntries.append(PieChartDataEntry(value: Double(report.stat.activeCount), label: L10n.Case.active))
		dataEntries.append(PieChartDataEntry(value: Double(report.stat.recoveredCount), label: L10n.Case.recovered))
		dataEntries.append(PieChartDataEntry(value: Double(report.stat.deathCount), label: L10n.Case.deaths))

		let dataSet = PieChartDataSet(entries: dataEntries, label: "")
		dataSet.colors = [.systemYellow, .systemGreen, .systemRed]
		dataSet.valueColors = [
			UIColor(hue: 0.13, saturation: 1.0, brightness: 0.4, alpha: 1.0),
			UIColor(hue: 0.3, saturation: 0.2, brightness: 1.0, alpha: 1.0),
			UIColor(hue: 0.03, saturation: 0.2, brightness: 1.0, alpha: 1.0)
		]
		dataSet.sliceSpace = 2
		dataSet.xValuePosition = .outsideSlice
		dataSet.yValuePosition = .insideSlice
		dataSet.entryLabelColor = .black
		dataSet.valueFont = .systemFont(ofSize: 14, weight: .bold)
		dataSet.valueFormatter = PercentValueFormatter()
		dataSet.selectionShift = 8

		chartView.data = PieChartData(dataSet: dataSet)

		if animated {
			chartView.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
		}
	}
}
