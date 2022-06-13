import SwiftUI
import AVFoundation
struct ContentView: View {
    let button: [[EggTime]] = [
        [.soft], [.medium], [.hard]
    ]
    @State private var eggTimer: [String: Int] = ["Soft": 300, "Medium": 420,"Hard": 720]
    @State private var totalTime = 0
    @State private var title: String = "How do you like your eggs?"
  
    @State private var player: AVAudioPlayer!
    // Total time needed for the egg
    @State private var curentTime = 0.0
    // Set up the timer object
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    
    var body: some View {
        ZStack {
            Color(red: 214/255, green: 242/255, blue: 252/255)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Text(title)
                        .font(.system(size: 30))
                        .foregroundColor(Color(red: 132/255, green: 142/255, blue: 146/255))
                    
                }
                .padding()
                
                HStack {
                    
                    ForEach(button, id: \.self) { row in
                        ForEach(row, id: \.self){ item in
                            Button {
                                totalTime = eggTimer[item.rawValue]!
                                curentTime = 0
                                title = item.rawValue
                                
                            } label: {
                                
                                Image(item.eggImage)
                                    .resizable()
                                    .frame(width: 130.5, height: 172.5)
                                
                            }
                        }
                    }
                }
                HStack{
                    ProgressView(value: curentTime,
                                 total: Double(totalTime))
                    
                    .onReceive(timer) { _ in
                        if curentTime < Double(totalTime) {
                            curentTime += 1
                        }else{
                            title = "Done"
                            silentMode()
                            player = try! AVAudioPlayer(contentsOf: url!)
                            player.play()
                        }
                    }
                    .padding()
                }
            }
            
        }
    }
    func silentMode(){
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
