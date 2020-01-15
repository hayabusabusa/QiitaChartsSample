//
//  BarChartViewController.swift
//  QiitaChartsSample
//
//  Created by Yamada Shunya on 2020/01/15.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import Charts

final class BarChartViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet weak var barChartView: BarChartView!
    
    // MARK: Properties
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBarChartView()
        setupBarChartData()
    }
}

// MARK: - Setup

extension BarChartViewController {
    
    private func setupNavigation() {
        navigationItem.title = "棒グラフ"
    }
    
    private func setupBarChartView() {
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        // noData (.dataがnilの時に表示されるラベルの設定)
        barChartView.noDataText = "グラフのデータがありません."
        barChartView.noDataFont = .systemFont(ofSize: 14, weight: .bold)
        barChartView.noDataTextColor = .lightGray
        // X axis (X座標軸の設定)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = Colors.chartLabelColor
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawAxisLineEnabled = false
        barChartView.xAxis.valueFormatter = WeekdayAxisValueFormatter()
        // Right axis (右のY座標軸の設定)
        barChartView.rightAxis.enabled = false
        // Left axis (左のY座標軸の設定)
        barChartView.leftAxis.axisMinimum = 0.0
        barChartView.leftAxis.labelCount = 5
        barChartView.leftAxis.labelTextColor = Colors.chartLabelColor
        barChartView.leftAxis.gridColor = Colors.chartLineColor
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawZeroLineEnabled = true
        barChartView.leftAxis.zeroLineColor = Colors.chartLineColor
        // Legend (グラフ下に表示される項目の設定)
        barChartView.legend.enabled = false
    }
    
    private func setupBarChartData() {
        // DataSet
        let rawData: [Int] = [20, 50, 70, 30, 60, 90, 40]
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.systemBlue]
        let data = BarChartData(dataSet: dataSet)
        data.groupBars(fromX: 0, groupSpace: 1, barSpace: 24)
        barChartView.data = data
        // Limit line
        let avg = rawData.reduce(0) { return $0 + $1 } / rawData.count
        let limitLine = ChartLimitLine(limit: Double(avg))
        limitLine.lineColor = .systemOrange
        limitLine.lineDashLengths = [4]
        barChartView.leftAxis.addLimitLine(limitLine)
    }
}
