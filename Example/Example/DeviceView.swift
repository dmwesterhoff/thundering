import SwiftUI
import SwiftUIX

struct DeviceView: View {
    
    @State var viewModel = DeviceViewModel()
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
                #if !os(macOS)
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                #endif

            
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
    }
    
    func writeOut() {
        viewModel.port.writeData(data: writeOutput.data(using: .utf8)!)
        writeOutput = ""
    }
    
    var readerData: String {
        return viewModel.messages.map { String(data: $0, encoding: .utf8)! }
            .joined(separator: "\n")
    }
}

#Preview {
    DeviceView()
}
