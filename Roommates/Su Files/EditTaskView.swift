//
//  EditTaskView.swift
//  Roommates
//
//  Created by Suyeon Cho on 19/02/24.
//

import SwiftUI

struct EditTaskView: View {
    
    @State private var taskName: String = " "
    
    var body: some View {
        NavigationView{
            VStack (alignment: .leading){
                HStack{
                    Text("Edit task")
                        .bold()
                    Button(action: { /*presentationMode.wrappedValue.dismiss() */}) {
                        ExitButtonView()
                        
                    }.frame(width: 24, height: 24)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                TextField("Enter task name", text: $taskName)
                    .bold()
                    .foregroundColor(.accentColor)
                Divider()
                    .background(Color.secondary)
                    .padding(.bottom)
                Text("Days active")
                    .bold()
               DaySelectionView()
                    .padding(.bottom)
                
                Button(action: { /* Actions */ }, label: {
                    Text("Delete Task")
                        .bold()
                        .frame(maxWidth: .infinity)
                }) .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .tint(.pastelRed)
                
                Button(action: { /* Actions */ }, label: {
                    Text("Save")
                        .bold()
                        .frame(maxWidth: .infinity)
                }) .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                
                Spacer()
            }.padding()
        }
        
        
        
    }
}

#Preview {
    EditTaskView()
}
