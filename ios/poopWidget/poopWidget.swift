//
//  poopWidget.swift
//  poopWidget
//
//  Created by Anthony on 2024-08-21.
//

import WidgetKit
import SwiftUI
import Foundation
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PoopEntry {
        PoopEntry(date: Date(), data: "default3")
    }

    func getSnapshot(in context: Context, completion: @escaping (PoopEntry) -> ()) {
        let entry = PoopEntry(date: Date(), data: "uninit")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            // get data here
            print("GETTING POOP DATA")
            let data = try? await fetchPoop();
//            let userDefaults = UserDefaults(suiteName: Config.poopAppGroup)
//            let data = userDefaults?.string(forKey: Config.dbKey) ?? "No
            let entry = PoopEntry(date: Date(), data: data ?? "null data")
            
            // Next fetch happens 15 minutes later
            let nextUpdate = Calendar.current.date(
                byAdding: DateComponents(minute: 15),
                to: Date()
            )!
            
            let timeline = Timeline(
                entries: [entry],
                policy: .after(nextUpdate)
            )
            
            completion(timeline)
        }
    }
}

struct PoopEntry: TimelineEntry {
    let date: Date
    let data: String
}

func parsePersonData(from jsonString: String) -> [PersonData] {
    // Convert JSON string to Data
    if let jsonData = jsonString.data(using: .utf8) {
        do {
            // Parse JSON data to Dictionary
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Int]
            
            // Map dictionary to an array of PersonData
            let personDataList = dictionary?.map { PersonData(name: $0.key.capitalized, value: $0.value) } ?? []
            
            let sortedPersonDataList = personDataList.sorted { $0.name < $1.name }
            
            return sortedPersonDataList
            
        } catch {
            print("Failed to parse JSON: \(error.localizedDescription)")
        }
    }
    // Return an empty array if parsing fails
    return []
}

struct poopWidgetEntryView : View {
    let username = Config.localDB?.string(forKey: "username") ?? "Guest"
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geometry in
            HStack (alignment: .center, spacing: 10) {
                // add button here
                BarChartView(data: parsePersonData(from: entry.data))
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity
                    )
//                    .border(Color.blue)
//                VStack {
//                    Spacer()
//                    Button(action: {
//                        Task {
//                            try await incrementPoop()
//                        }
//                    }) {
//                        Text("+").font(.caption).frame(height: 30)
//                            
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        Task {
//                            try await decrementPoop()
//                        }
//                    }) {
//                        Text("-").font(.caption).frame(height: 30)
//                    }
//                    Spacer()
//                }
            }
        }
    }
}

struct poopWidget: Widget {
    let kind: String = Config.widgetKind

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                poopWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                poopWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}


// I think here the easiest way is just to fire an increment via http
// which then receives a response of the updated counter.

#Preview(as: .systemSmall) {
    poopWidget()
} timeline: {
    PoopEntry(date: .now, data: "{\"anthony\": 4, \"clare\": 100}")
    PoopEntry(date: .now, data: "{\"anthony\": 4, \"clare\": 2}")
}
