import SwiftUI

struct RoundedTopCornersShape: Shape {
    let cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.height))
        
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        path.addQuadCurve(
            to: CGPoint(x: cornerRadius, y: 0),
            control: CGPoint(x: 0, y: 0)
        )
        
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        
        path.addQuadCurve(
            to: CGPoint(x: rect.width, y: cornerRadius),
            control: CGPoint(x: rect.width, y: 0)
        )
        
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        
        path.closeSubpath()
        
        return path
    }
}

struct ContentView: View {
    @StateObject private var agentManager = AgentManager()
    @State private var showAgentList = false
    @GestureState private var dragOffset: CGFloat = 0.0
    
    let agentNames = Agent.allAgents.map { $0.name }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .bottom) {
                
                agentManager.agentBackground
                    .ignoresSafeArea() // The gradient covers the whole screen
                    .animation(.easeInOut(duration: 1.5), value: agentManager.currentAgent)
                
                VStack {
                    VStack(spacing: 30) {
                        ZStack {
                            // Use ultraThinMaterial for the card background
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.ultraThinMaterial)
                                .frame(width: 370, height: 550)
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 4)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                            
                            VStack(spacing: 20) {
                                Image(agentManager.currentAgent.faceImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                                    .padding(.top, 120)
                                
                                Text(agentManager.currentAgent.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                                
                                Text(agentManager.currentAgent.role)
                                    .font(.headline)
                                    .foregroundColor(Color.white.opacity(0.7))
                                    .padding(.top, 5)
                                    .multilineTextAlignment(.center)
                                
                                VStack(alignment: .center) {
                                    Text("Abilities")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    
                                    ForEach(agentManager.currentAgent.abilities, id: \.self) { ability in
                                        Text(ability)
                                            .foregroundColor(.white)
                                            .padding(.vertical, 2)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                                .padding(.top, 10)
                                
                                ScrollView {
                                    Text(agentManager.currentAgent.bio)
                                        .font(.system(size: 14))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 350, alignment: .center)
                                        .padding(.top, 10)
                                }
                                .padding(.top, 10)
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Button(action: {
                                withAnimation(.spring()) {
                                    showAgentList.toggle()
                                }
                            }) {
                                Text("Show All Agents")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                            
                            Button(action: {
                                withAnimation(.spring()) {
                                    agentManager.randomizeAgent()
                                }
                            }) {
                                Text("Randomize Agent")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(25)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                    )
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(.bottom, 20)
                    }
                    .padding(.horizontal)
                }
                
                if showAgentList {
                    VStack(spacing: 0) {
                        
                        Capsule()
                            .fill(Color.white.opacity(0.3))
                            .frame(width: 40, height: 5)
                            .padding(.top, 10)
                            .padding(.bottom, 10)
                        
                        List(agentNames, id: \.self) { agentName in
                            Text(agentName)
                                .font(.title3)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.vertical, 15)
                                .padding(.horizontal, 20)
                                .background(Color.white.opacity(0.2))
                                .clipShape(Capsule())
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    if let selectedAgent = Agent.allAgents.first(where: { $0.name == agentName }) {
                                        agentManager.currentAgent = selectedAgent
                                        agentManager.agentBackground = agentManager.getBackgroundGradient(for: selectedAgent)
                                    }
                                    withAnimation(.spring()) {
                                        showAgentList = false
                                    }
                                }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                    .frame(height: proxy.size.height * 0.75)
                    .background(.ultraThinMaterial) // Glassy blurry background for the sheet
                    .clipShape(RoundedTopCornersShape(cornerRadius: 20))
                    .overlay(
                        RoundedTopCornersShape(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.3), lineWidth: 1)
                    )
                    .edgesIgnoringSafeArea(.bottom)
                    .offset(y: dragOffset + 35)
                    .gesture(
                        DragGesture()
                            .updating($dragOffset) { value, state, _ in
                                if value.translation.height > 0 {
                                    state = value.translation.height
                                }
                            }
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.spring()) {
                                        showAgentList = false
                                    }
                                }
                            }
                    )
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: showAgentList)
                }
            }
        }
    }
}
