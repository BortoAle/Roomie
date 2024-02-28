//
//  ActivityCardView.swift
//  Roommates
//
//  Created by Matt Novoselov on 20/02/24.
//

import SwiftUI

struct ActivityCardView: View {
    var activityName: String
    var activityEmoji: String
    var personName: String
    var showingToggle: Bool = true
    
    @State var checked = false
    
    var body: some View {
        HStack(spacing: 15){
            Text(activityEmoji)
                .font(.title2)
                .padding(.all, 10)
                .background(
                    ZStack{
                        Color(.white)
                        
                        Color(getPastelColor(activityEmoji)).opacity(0.3)
                    }
                )
                .clipShape(Circle())
                .saturation(checked ? 0.5 : 1)
            
            VStack (alignment: .leading){
                Text(activityName)
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack (spacing: 5){
                    Image(systemName: "person.fill")
                        .imageScale(.small)
                    
                    Text(personName)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.gray)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight:.infinity, alignment:.leading)
            
            if showingToggle{
                Toggle("", isOn: $checked)
                    .toggleStyle(CheckboxToggleStyle(style: .circle))
            }
            
        }
        .opacity(checked ? 0.4 : 1)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    @Environment(\.isEnabled) var isEnabled
    let style: Style
    
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            withAnimation(){
                configuration.isOn.toggle()
            }
        }, label: {
            ZStack {
                Image(systemName: configuration.isOn ? "checkmark.\(style.sfSymbolName).fill" : style.sfSymbolName)
                    .imageScale(.large)
                    .foregroundColor(.white)
                    .fontWeight(.medium)
                configuration.label
            }
        })
        .buttonStyle(PlainButtonStyle()) // remove any implicit styling from the button
        .disabled(!isEnabled)
        
    }
    
    enum Style {
        case square, circle
        
        var sfSymbolName: String {
            switch self {
            case .square:
                return "square"
            case .circle:
                return "circle"
            }
        }
    }
}

#Preview {
    ActivityCardView(activityName: "Clean Kitchen", activityEmoji: "🍳", personName: "Matt Novoselov")
}
