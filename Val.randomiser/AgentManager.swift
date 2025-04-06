import SwiftUI
class AgentManager: ObservableObject {
    @Published var currentAgent: Agent
    @Published var agentBackground: LinearGradient
    
    // Initialization
    init() {
        // Initialize the default agent
        self.currentAgent = Agent(name: "Phoenix", role: "DUELIST", abilities: ["Blaze", "Curveball", "Hot Hands", "Run It Back"], faceImage: "phoenix_face", bio: "Hailing from the U.K., Phoenix's star power shines through in his fighting style, igniting the battlefield with flash and flare.")
        
        // Initialize the agentBackground property
        self.agentBackground = LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom)
        
        // After the properties are initialized, you can safely call self
        self.agentBackground = getBackgroundGradient(for: self.currentAgent)
    }
    
    // Method to get background gradient for a given agent
    func getBackgroundGradient(for agent: Agent) -> LinearGradient {
        switch agent.name.lowercased() {
        case "phoenix":
            return LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]),
                                  startPoint: .top, endPoint: .bottom)
        case "jett":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]),
                                  startPoint: .top, endPoint: .bottom)
        case "sage":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.cyan]),
                                  startPoint: .top, endPoint: .bottom)
        case "raze":
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.yellow]),
                                  startPoint: .top, endPoint: .bottom)
        case "reyna":
            return LinearGradient(gradient: Gradient(colors: [Color.red, Color.purple]),
                                  startPoint: .top, endPoint: .bottom)
        case "killjoy":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]),
                                  startPoint: .top, endPoint: .bottom)
        case "omen":
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]),
                                  startPoint: .top, endPoint: .bottom)
        case "brimstone":
            return LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                  startPoint: .top, endPoint: .bottom)
        case "sova":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]),
                                  startPoint: .top, endPoint: .bottom)
        case "viper":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]),
                                  startPoint: .top, endPoint: .bottom)
        case "yoru":
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                  startPoint: .top, endPoint: .bottom)
        case "skye":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.brown]),
                                  startPoint: .top, endPoint: .bottom)
        case "astra":
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]),
                                  startPoint: .top, endPoint: .bottom)
        case "kayo":
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.green]),
                                  startPoint: .top, endPoint: .bottom)
        case "chamber":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]),
                                  startPoint: .top, endPoint: .bottom)
        case "neon":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.yellow]),
                                  startPoint: .top, endPoint: .bottom)
        case "fade":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.pink]),
                                  startPoint: .top, endPoint: .bottom)
        case "harbor":
            return LinearGradient(gradient: Gradient(colors: [Color.blue, Color.green]),
                                  startPoint: .top, endPoint: .bottom)
        case "gekko":
            return LinearGradient(gradient: Gradient(colors: [Color.green, Color.purple]),
                                  startPoint: .top, endPoint: .bottom)
        case "deadlock":
            return LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]),
                                  startPoint: .top, endPoint: .bottom)
        case "iso":
            return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.purple]),
                                  startPoint: .top, endPoint: .bottom)
        case "vyse":
            return LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.purple]),
                                  startPoint: .top, endPoint: .bottom)
        case "tejo":
            return LinearGradient(gradient: Gradient(colors: [Color.brown, Color.yellow]),
                                  startPoint: .top, endPoint: .bottom)
        case "clove":
            return LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]),
                                  startPoint: .top, endPoint: .bottom)
        case "breach":
            return LinearGradient(gradient: Gradient(colors: [Color.orange, Color.black]),
                                  startPoint: .top, endPoint: .bottom)
        case "cypher":
            return LinearGradient(gradient: Gradient(colors: [Color.brown, Color.gray]),
                                  startPoint: .top, endPoint: .bottom)
        default:
            return LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray]),
                                  startPoint: .top, endPoint: .bottom)
        }
    }
    
    // Randomize the agent
    func randomizeAgent() {
        if let randomAgent = Agent.allAgents.randomElement() {
            self.currentAgent = randomAgent
            self.agentBackground = getBackgroundGradient(for: randomAgent)
        }
    }
}
