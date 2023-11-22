//
//  DatePickerBootcamp.swift
//  SwiftBootCamp
//
//  Created by 高广校 on 2023/11/21.
//

import SwiftUI

struct DatePickerBootcamp: View {
    
    @State var selectedDate: Date = Date()
    
    let startDate: Date = Calendar.current.date(from: DateComponents(year: 2018)) ?? Date()
    
    let endDate: Date = Date()
    
    var dataFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        
        VStack {
            Text("Selected date is")
            
            Text(dataFormatter.string(from: selectedDate))
                .font(.title)
            
            DatePicker("Select a date", selection: $selectedDate,in: startDate...endDate,displayedComponents: [.hourAndMinute,.date])
                .accentColor(.gray)
                .pickerStyle(.wheel)
                .padding()
        }
    }
}

#Preview {
    DatePickerBootcamp()
}
