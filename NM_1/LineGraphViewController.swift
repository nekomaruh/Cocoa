//
//  LineGraphViewController.swift
//  NM_1
//
//  Created by Johan Esteban Ordenes Galleguillos on 07-11-19.
//  Copyright © 2019 Johan Esteban Ordenes Galleguillos. All rights reserved.
//

import Cocoa
import Charts
import SwiftUI

class LineGraphViewController: NSViewController {
    
    @IBOutlet var lineChartView: LineChartView!
    
    @IBAction func reloadBtn(_ sender: NSButton) {
        reloadData()
    }
    
    @objc public func willWork() {
      reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadData(){
        let bridge = GraphBridge.sharedSingleton()
        
        if(bridge.isFileLoaded){
            var entry = [ChartDataEntry]();
            for i in 0..<bridge.n{
                let value = ChartDataEntry(x: Double(bridge.dataX[Int(i)]), y:Double(bridge.dataY[Int(i)]));
                entry.append(value);
            }
            let ds = LineChartDataSet(entries: entry, label: "")
            ds.colors = [NSUIColor.clear]
            // y = m(x-x1) + y1
            
            var entryAVG = [ChartDataEntry]();
            let valueI = ChartDataEntry(x: Double(bridge.dataX[0]), y:Double(bridge.dataY[0]));
            let lastY = Double(bridge.a) + (Double(bridge.b) * Double(bridge.n))
            let valueF = ChartDataEntry(x: Double(bridge.n), y: lastY);
            entryAVG.append(valueI);
            entryAVG.append(valueF);
            let dsX = LineChartDataSet(entries: entryAVG, label: "Linear Regression")
            dsX.colors = [NSUIColor.red]
            
            
            let data = LineChartData()
            data.addDataSet(ds)
            if(lastY != 0){
                data.addDataSet(dsX)
            }
            
            
            self.lineChartView.data = data
            self.lineChartView.gridBackgroundColor = NSUIColor.white
            self.lineChartView.chartDescription?.text = "Collab between Johan Ordenes and Wladislaw Rabinski"
            self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
        }else{
            func dialogOKCancel(question: String, text: String) -> Bool {
                let alert = NSAlert()
                alert.messageText = question
                alert.informativeText = text
                alert.alertStyle = .warning
                alert.addButton(withTitle: "OK")
                return alert.runModal() == .alertFirstButtonReturn
            }

            _ = dialogOKCancel(question: "File error", text: "Please select a file path to read")
        }
        
        
        
    }
    
    override open func viewWillAppear(){
        self.lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
}
