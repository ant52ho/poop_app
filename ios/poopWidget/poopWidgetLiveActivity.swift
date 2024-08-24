//
//  poopWidgetLiveActivity.swift
//  poopWidget
//
//  Created by Anthony on 2024-08-21.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct poopWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct poopWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: poopWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension poopWidgetAttributes {
    fileprivate static var preview: poopWidgetAttributes {
        poopWidgetAttributes(name: "World")
    }
}

extension poopWidgetAttributes.ContentState {
    fileprivate static var smiley: poopWidgetAttributes.ContentState {
        poopWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: poopWidgetAttributes.ContentState {
         poopWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: poopWidgetAttributes.preview) {
   poopWidgetLiveActivity()
} contentStates: {
    poopWidgetAttributes.ContentState.smiley
    poopWidgetAttributes.ContentState.starEyes
}
