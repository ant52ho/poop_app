//
//  poopWidget.swift
//  poopWidget
//
//  Created by Anthony on 2024-08-21.
//

import WidgetKit
import SwiftUI
import Foundation

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

struct poopWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Data:")
            Text(entry.data)
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

#Preview(as: .systemSmall) {
    poopWidget()
} timeline: {
    PoopEntry(date: .now, data: "default")
    PoopEntry(date: .now, data: "default2")
}

//
//struct Provider: AppIntentTimelineProvider {
//    func placeholder(in context: Context) -> PoopWidgetEntry {
//        PoopWidgetEntry(date: Date(), data: "Placeholder", configuration: ConfigurationAppIntent())
//    }
//    
//    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> PoopWidgetEntry {
//        if context.isPreview{
//            return(placeholder(in: context))
//        } else {
//            let userDefaults = UserDefaults(suiteName: appGroup)
//            let data = userDefaults?.string(forKey: "poopdb") ?? "No data"
//            return(PoopWidgetEntry(date: Date(), data: data, configuration: ConfigurationAppIntent()))
//        }
//    }
//    
//    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<PoopWidgetEntry> {
//        var entries: [PoopWidgetEntry] = []
//        
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 24 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            // Call snapshot to get the entry for each hour
//
//            let entry = await snapshot(for: configuration, in: context)
//            
//            entries.append(entry)
//        }
//        return Timeline(entries: entries, policy: .atEnd)
//    }
//}
//
//struct PoopWidgetEntry: TimelineEntry {
//    var date: Date;
//    let data: String;
//    let configuration: ConfigurationAppIntent;
//}
//
//struct poopWidgetEntryView : View {
//    var entry: Provider.Entry
//
//        var body: some View {
//            VStack {
//                Text("Poop widget")
//                Text(entry.data)
//            }
//        }
//}
//
//struct poopWidget: Widget {
//    let kind: String = "testWidget"
//
//    var body: some WidgetConfiguration {
//        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
//            poopWidgetEntryView(entry: entry)
//                .containerBackground(.fill.tertiary, for: .widget)
//        }
//    }
//}
//
//extension ConfigurationAppIntent {
//    fileprivate static var smiley: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "😀"
//        return intent
//    }
//    
//    fileprivate static var starEyes: ConfigurationAppIntent {
//        let intent = ConfigurationAppIntent()
//        intent.favoriteEmoji = "🤩"
//        return intent
//    }
//}
//
//#Preview(as: .systemSmall) {
//    poopWidget()
//} timeline: {
//    PoopWidgetEntry(date: .now, data: "hello", configuration: .smiley)
//    PoopWidgetEntry(date: .now, data: "world", configuration: .starEyes)
////    SimpleEntry(date: .now, configuration: .starEyes)
//}
//
