import SwiftUI
import SwiftUIX

struct HostView: View {
    
    @State var viewModel = HostViewModel()
    @State var writeOutput: String = ""
    
    var body: some View {
        VStack {
            header
            
            if viewModel.connected {
                writer
                Divider()
                reader
            }
            else {
                waiting
            }

            Spacer()
        }
        .frame(minWidth: 400, maxWidth: 600, minHeight: 400, maxHeight: 900)
        .idealFrame(width: 600, height: 900)
    }
    
    var header: some View {
        VStack {
            HStack {
                Spacer()
                
                Circle()
                    .foregroundStyle(viewModel.connected ? .green: .red)
                    .frame(width: 5, height: 5)
                    .padding(.trailing)
                
                Text(viewModel.connected ? "connected": "disconnected")
                    .fontDesign(.monospaced)
                    .bold()
                
                Spacer()
            }
            .padding()
            
            Divider()
        }
    }
    
    var waiting: some View {
        VStack {
            Spacer()
            
            ActivityIndicator()
                .padding(.bottom)
            
            Text("waiting to connect...")
                .monospaced()
                .fontWeight(.light)
            
            Spacer()
        }
    }
    
    var writer: some View {
        HStack {
            TextField("write data", text: $writeOutput)
                .autocorrectionDisabled()
                .onSubmit {
                    writeOut()
                }
            
            
            Button(action: {
                writeOut()
            }, label: {
                Text("write")
                    .bold()
            })
            .disabled(writeOutput.isEmpty)
        }
        .monospaced()
        .padding()
    }
    
    var reader: some View {
        TextEditor(text: .constant(readerData))
            .monospaced()
            .disabled(true)
            .padding(.horizontal)
            .foregroundColor(Color.white)
    }
    
    func writeOut() {
        viewModel.device?.writeData(data: writeOutput.data(using: .utf8)!)
        writeOutput = ""
    }
    
    var readerData: String {
        return viewModel.messages.map { String(data: $0, encoding: .utf8)! }
            .joined(separator: "\n")
    }
}

#Preview {
    HostView()
}
