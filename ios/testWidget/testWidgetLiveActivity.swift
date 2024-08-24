//
//  testWidgetLiveActivity.swift
//  testWidget
//
//  Created by Anthony on 2024-08-22.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct testWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct testWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: testWidgetAttributes.self) { context in
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

extension testWidgetAttributes {
    fileprivate static var preview: testWidgetAttributes {
        testWidgetAttributes(name: "World")
    }
}

extension testWidgetAttributes.ContentState {
    fileprivate static var smiley: testWidgetAttributes.ContentState {
        testWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: testWidgetAttributes.ContentState {
         testWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: testWidgetAttributes.preview) {
   testWidgetLiveActivity()
} contentStates: {
    testWidgetAttributes.ContentState.smiley
    testWidgetAttributes.ContentState.starEyes
}
