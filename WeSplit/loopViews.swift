//
//  loopViews.swift
//  WeSplit
//
//  Created by aeglus on 2021/11/27.
//

import SwiftUI

struct loopViews: View {
    let students = ["Harry", "Hermoine", "Ron"]
    @State private var selectedStudent = "Harry"
                    
    var body: some View {
        NavigationView {
            Form {
                Picker("Select your student", selection: $selectedStudent) {
                    ForEach(students, id: \.self) {
                        Text($0)
                }
            }
        }
    }
}
}

struct loopViews_Previews: PreviewProvider {
    static var previews: some View {
        loopViews()
    }
}

