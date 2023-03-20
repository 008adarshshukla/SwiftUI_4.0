//
//  AudioBookView.swift
//  SwiftUI4.0
//
//  Created by Adarsh Shukla on 28/12/22.
//

import SwiftUI

struct AudioBookView: View {
    @StateObject var vm = AudioBookViewModel()
    var body: some View {
        List {
            ForEach(vm.audioBooks, id: \.self) { audioBook in
                HStack {
                    AsyncImage(url: audioBook.artworkUrl100 ?? URL(string: "")) { image in
                        image
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }

                    Text(audioBook.artistName ?? "")
                    
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                }
            }
        }
        .task {
            do {
                try await vm.getAudioBooks()
            } catch {
                //Do not write throw statement here.
                print(error)
            }
        }
    }
}

struct AudioBookView_Previews: PreviewProvider {
    static var previews: some View {
        AudioBookView()
    }
}
