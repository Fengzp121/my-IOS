//
//  firstWidgetDemo.swift
//  firstWidgetDemo
//
//  Created by 你吗 on 2021/3/16.
//  Copyright © 2021 ffzp. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
  
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    func abc() -> Void {
        print("打我啊！")
    }
}

struct firstWidgetDemoEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        VStack{
            HStack{
                Button("打我",action:entry.abc)
            }
            //Button("打我",action:abc)
            Image.init("avatar")
            ZStack{
                Text("啵啵是傻逼")
            }
        }
        
    }
}

@main
struct firstWidgetDemo: Widget {
    let kind: String = "firstWidgetDemo"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            firstWidgetDemoEntryView(entry: entry)
        }
        .configurationDisplayName("啵啵")
        .description("This is 啵啵's widget.")
    }
}

struct firstWidgetDemo_Previews: PreviewProvider {
    static var previews: some View {
        firstWidgetDemoEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
