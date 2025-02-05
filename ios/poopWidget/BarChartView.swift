//
//  BarChartView.swift
//  Runner
//
//  Created by Anthony on 2024-08-24.
//

import Foundation
import SwiftUI
import Charts

struct BarChartView: View {
    let data: [PersonData]
    
    var body: some View {
        VStack {
            // The chart view
            Chart(data) { person in
                BarMark(
                    x: .value("Name", person.name),
                    y: .value("Score", person.value)
                ).annotation(position: .automatic) {
                    Text("\(person.value)")
                        .font(.caption2) // Smaller font size
                        .padding(4) // More padding
//                        .background(Color, in: RoundedRectangle(cornerRadius: 4))
                        .offset(y: 0) // Adjust the vertical offset if needed
                }
                .foregroundStyle(person.name == "Clare" ? Color.pink.opacity(0.5) : Color.blue.opacity(0.5))
            }
            .chartPlotStyle { plotArea in
                plotArea
                    .frame(maxHeight: .infinity) // Make the chart fit the container's height
            }.chartXAxis {
                AxisMarks(preset: .aligned, values: .automatic) { _ in
                    AxisValueLabel() // Minimal X-axis labels
                    .font(.caption2) 
                }
            }
            .chartYAxis(.hidden)
            .padding(0)
        }
//        .frame(height: maxValue)  Set your desired container height
    }
    
    private var maxValue: Int {
        data.map { $0.value }.max() ?? 1
    }
}
