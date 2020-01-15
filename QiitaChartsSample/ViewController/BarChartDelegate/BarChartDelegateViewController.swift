//
//  BarChartDelegateViewController.swift
//  QiitaChartsSample
//
//  Created by Yamada Shunya on 2020/01/15.
//  Copyright © 2020 Shunya Yamada. All rights reserved.
//

import UIKit
import Charts

final class BarChartDelegateViewController: UIViewController {
    
    // MARK: IBOutlet
    
    @IBOutlet private weak var weekdayLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var barChartView: BarChartView!
    
    // MARK: Properties
    
    private var averageValue: Int = 0
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupBarChartView()
        setupBarChartData()
    }
}

// MARK: - Setup

extension BarChartDelegateViewController {
    
    private func setupNavigation() {
        navigationItem.title = "棒グラフ(デリゲートあり)"
    }
    
    private func setupBarChartView() {
        // デリゲートの設定
        barChartView.delegate = self
        // ピンチインでズームできるのを無効にする
        barChartView.scaleXEnabled = false
        barChartView.scaleYEnabled = false
        // noData (.dataがnilの時に表示されるラベルの設定)
        barChartView.noDataText = "グラフのデータがありません."
        barChartView.noDataFont = .systemFont(ofSize: 14, weight: .bold)
        barChartView.noDataTextColor = .lightGray
        // X axis (X座標軸の設定)
        barChartView.xAxis.labelPosition = .bottom
        barChartView.xAxis.labelTextColor = Colors.chartLabelColor
        barChartView.xAxis.axisLineColor = Colors.chartLineColor
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.valueFormatter = WeekdayAxisValueFormatter()
        // Right axis (右のY座標軸の設定)
        barChartView.rightAxis.enabled = false
        // Left axis (左のY座標軸の設定)
        barChartView.leftAxis.drawGridLinesEnabled = false
        barChartView.leftAxis.drawAxisLineEnabled = false
        barChartView.leftAxis.drawLabelsEnabled = false
        // Legend (凡例の設定)
        barChartView.legend.enabled = false
    }
    
    private func setupBarChartData() {
        // DataSet
        let rawData: [Int] = [200, 500, 700, 300, 600, 900, 400]
        let entries = rawData.enumerated().map { BarChartDataEntry(x: Double($0.offset), y: Double($0.element)) }
        let dataSet = BarChartDataSet(entries: entries)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [.systemBlue]
        let data = BarChartData(dataSet: dataSet)
        barChartView.data = data
        
        // Limit line
        let avg = rawData.reduce(0) { return $0 + $1 } / rawData.count
        let limitLine = ChartLimitLine(limit: Double(avg))
        limitLine.lineColor = .systemOrange
        limitLine.lineDashLengths = [4]
        barChartView.leftAxis.addLimitLine(limitLine)
        
        // Animation
        barChartView.animate(yAxisDuration: 1.4, easingOption: .easeInOutBack)
        
        // Labels
        averageValue = avg
        weekdayLabel.text = "Average"
        valueLabel.text = "\(averageValue)"
    }
}

// MARK: - ChartView delegate

extension BarChartDelegateViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        guard let weekday = WeekdayAxisValueFormatter.Weekday(rawValue: Int(entry.x))?.description else { return }
        weekdayLabel.text = weekday
        valueLabel.text = "\(Int(entry.y))"
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        weekdayLabel.text = "Average"
        valueLabel.text = "\(averageValue)"
    }
}
