//
//  ContentView.swift
//  Papa Codes
//
//  Created by Vlados iOS on 2/24/20.
//  Copyright © 2020 Vladislav Shilov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = CodesViewModel()
    
    var body: some View {
        NavigationView {
            List(model.promocodes) {
                RowView(promocode: $0)
            }
            .navigationBarTitle("Promocodes")
            .navigationBarItems(trailing: Button(action: {
                self.model.fetchAllCodes()
            }, label: {
                Text("Update promocodes")
                    .font(.body)
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
