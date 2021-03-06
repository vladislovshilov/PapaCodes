//
//  RowView.swift
//  Papa Codes
//
//  Created by Vlados iOS on 2/24/20.
//  Copyright © 2020 Vladislav Shilov. All rights reserved.
//

import SwiftUI

struct RowView: View {
    
    var promocode: Promocode
    
    var body: some View {
        HStack {
            Image("papacodes").resizable().frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text("Условия: \(promocode.name)")
                Spacer()
                Text("Промокод: \(promocode.code)").bold()
                Spacer()
            }
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(promocode: .init())
    }
}
