//
//  DetailView.swift
//  H4X0R News
//
//  Created by 김도연 on 3/11/24.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let url: String?
    
    var body: some View {
        WebView(urlString: url)
    }
}

#Preview {
    DetailView(url: "http://www.google.com")
}
