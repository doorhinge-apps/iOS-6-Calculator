//
// iOS 6 Calculator
// ContentView.swift
//
// Created on 29/5/25
//
// Copyright ©2025 DoorHinge Apps.
//


import SwiftUI

func forTrailingZero(_ temp: Double) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.usesGroupingSeparator = false
    formatter.minimumFractionDigits = temp.truncatingRemainder(dividingBy: 1) == 0 ? 0 : 1
    formatter.maximumFractionDigits = 10
    
    return formatter.string(from: NSNumber(value: temp)) ?? String(temp)
}

struct ContentView: View {
    @State var currentEquation = ""
    @State var currentDisplayNumber = "0"
    
    @State var memory = "0"
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .center, spacing: 0) {
                ZStack(alignment: .bottom) {
                    LinearGradient(colors: [Color(hex: "D6D7D0"), Color(hex: "9FA18E"), Color(hex: "CBCFAB")], startPoint: .top, endPoint: .bottom)
                    
                    HStack {
                        Spacer()
                        
//                        Text("\(currentEquation) : \(currentDisplayNumber)")
                        Text(formatWithCommas(currentDisplayNumber))
                            .font(.custom("Helvetica Neue", size: 70))
                            .fontWeight(.medium)
                    }.padding(20)
                    
                }.layoutPriority(0)
                
                ZStack {
                    VStack(spacing: 10) {
                        LazyVGrid(
                            columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                            alignment: .center,
                            spacing: 10) {
                                Group {
                                    Button {
                                        memory = "0"
                                    } label: {
                                        Text("mc")
                                    }
                                    .buttonStyle(BlueButton(color1: "455A5C", color2: "6B787D", color3: "7F8C8E", color4: "54656B"))
                                    .padding(4)
                                    
                                    Button {
                                        if let current = Double(currentDisplayNumber) {
                                            let memValue = Double(memory) ?? 0
                                            memory = forTrailingZero(memValue + current)
                                        }
                                    } label: {
                                        Text("m+")
                                    }
                                    .buttonStyle(BlueButton(color1: "455A5C", color2: "6B787D", color3: "7F8C8E", color4: "54656B"))
                                    .padding(4)
                                    
                                    Button {
                                        if let current = Double(currentDisplayNumber) {
                                            let memValue = Double(memory) ?? 0
                                            memory = forTrailingZero(memValue - current)
                                        }
                                    } label: {
                                        Text("m-")
                                    }
                                    .buttonStyle(BlueButton(color1: "455A5C", color2: "6B787D", color3: "7F8C8E", color4: "54656B"))
                                    .padding(4)
                                    
                                    Button {
                                        currentDisplayNumber = memory
                                    } label: {
                                        Text("mr")
                                    }
                                    .buttonStyle(BlueButton(color1: "455A5C", color2: "6B787D", color3: "7F8C8E", color4: "54656B"))
                                    .padding(4)
                                }

                                
                                Group {
                                    Button {
                                        currentEquation = ""
                                        currentDisplayNumber = "0"
                                    } label: {
                                        Text("AC")
                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62"))
                                        .padding(4)
                                    
                                    Button {
                                        currentEquation = makeNegative(in: currentEquation)
                                        updateDisplayNumber()
                                    } label: {
                                        Text("±")
                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62"))
                                        .padding(4)
                                    
                                    Button {
                                        updateOperator(newOperator: "/")
                                        updateDisplayNumber()
                                    } label: {
                                        Text("÷")
                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62", useWhiteStroke: {lastRealOperator(in: currentEquation) == "/"}))
                                        .padding(4)
                                    
                                    Button {
                                        updateOperator(newOperator: "*")
                                        updateDisplayNumber()
                                    } label: {
                                        Text("×")
                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62", useWhiteStroke: {lastRealOperator(in: currentEquation) == "*"}))
                                        .padding(4)
                                }
                                
                                ForEach(0..<9, id: \.self) { number in
                                    let index = [7, 8, 9, 4, 5, 6, 1, 2, 3]
                                    Button {
                                        currentEquation.append("\(index[number])")
                                        updateDisplayNumber()
                                    } label: {
                                        Text("\(index[number])")
                                    }.buttonStyle(BlueButton(color1: "141414", color2: "2D2D2D", color3: "777777", color4: "2A2A2A"))
                                        .padding(4)
                                    
                                    if (number + 1) % 3 == 0 {
                                        if number + 1 == 3 {
                                            Button {
                                                updateOperator(newOperator: "-")
                                                    } label: {
                                                Text("-")
                                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62", useWhiteStroke: {lastRealOperator(in: currentEquation) == "-"}))
                                                .padding(4)
                                        }
                                        
                                        if number + 1 == 6 {
                                            Button {
                                                updateOperator(newOperator: "+")
                                                    } label: {
                                                Text("+")
                                                    }.buttonStyle(BlueButton(color1: "765E53", color2: "877670", color3: "AA9C95", color4: "836C62", useWhiteStroke: {lastRealOperator(in: currentEquation) == "+"}))
                                                .padding(4)
                                        }
                                    }
                                }
                            }
                        GeometryReader { lowerGeo in
                            HStack(alignment: .top, spacing: 3) {
                                Button {
                                    currentEquation.append("0")
                                    updateDisplayNumber()
                                } label: {
                                    Text("0")
                                }.buttonStyle(BlueButton(color1: "141414", color2: "2D2D2D", color3: "777777", color4: "2A2A2A", radius: 90))
                                    .padding(4)
                                    .frame(width: lowerGeo.size.width / 2)
                                
                                HStack(alignment: .top, spacing: 3) {
                                    Button {
                                        currentEquation.append(".")
                                        updateDisplayNumber()
                                    } label: {
                                        Text(".")
                                    }.buttonStyle(BlueButton(color1: "141414", color2: "2D2D2D", color3: "777777", color4: "2A2A2A"))
                                        .padding(4)
                                    
                                    Button {
                                        if let result = evaluateExpression(currentEquation) {
                                            currentEquation = ""
                                            currentDisplayNumber = String(forTrailingZero(result))
                                        }
                                    } label: {
                                        Text("=")
                                    }.buttonStyle(BlueButton(color1: "AD4307", color2: "EE702D", color3: "C79674", color4: "B1521C", height: 150))
                                        .padding(4)
                                        .offset(y: -85)
                                    
                                }.frame(width: lowerGeo.size.width / 2)
                            }
                        }
                    }
//                    .frame(width: geo.size.width - 40/*, height: geo.size.height * (2/3) - 40*/)
                    .frame(width: geo.size.width - 40, height: 500)
                    .layoutPriority(1)
                }.padding(20)
                    
                .background(
                    Image("Leather")
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 2)
                        .overlay {
                            Color.black.opacity(0.5)
                        }
                        .frame(width: geo.size.width/*, height: geo.size.height * (2/3)*/)
                )
                .frame(width: geo.size.width/*, height: geo.size.height * (2/3)*/)
            }
        }.ignoresSafeArea()
    }
    
    func updateDisplayNumber() {
        let pattern = #"(?<!\d)-?\d+\.?\d*$"#
        
        if let range = currentEquation.range(of: pattern, options: .regularExpression) {
            let numberString = String(currentEquation[range])
            
            if let number = Double(numberString) {
                
                if numberString.hasSuffix(".") || numberString.hasSuffix(".0") {
                    currentDisplayNumber = numberString
                } else {
                    currentDisplayNumber = String(forTrailingZero(number))
                }
            }
        }
    }
    
    func updateOperator(newOperator: String) {
        if currentEquation == "" {
            currentEquation = currentDisplayNumber
        }
        if currentEquation.last == "+" || currentEquation.last == "-" || currentEquation.last == "×" || currentEquation.last == "÷" {
            currentEquation.removeLast()
        }
        currentEquation.append(newOperator)
    }
    
    func lastRealOperator(in input: String) -> Character? {
        let operators: Set<Character> = ["+", "-", "*", "/"]
        
        guard let last = input.last else {
            return nil
        }

        return operators.contains(last) ? last : nil
    }

    func formatWithCommas(_ numberString: String) -> String {
        guard numberString.contains(".") || numberString.contains(",") else {
            // Just format integer-only values
            if let intVal = Int(numberString) {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                formatter.usesGroupingSeparator = true
                return formatter.string(from: NSNumber(value: intVal)) ?? numberString
            } else {
                return numberString
            }
        }

        let parts = numberString.split(separator: ".", omittingEmptySubsequences: false)
        let integerPart = String(parts[0])
        let fractionalPart = parts.count > 1 ? String(parts[1]) : ""

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true

        guard let intValue = Int(integerPart),
              let formattedInt = formatter.string(from: NSNumber(value: intValue)) else {
            return numberString
        }

        if parts.count == 1 {
            return formattedInt + "."
        } else {
            return formattedInt + "." + fractionalPart
        }
    }
    
    func makeNegative(in equation: String) -> String {
        let pattern = #"(?<!\d)-?\d+\.?\d*$"#
        
        guard let range = equation.range(of: pattern, options: .regularExpression) else {
            return equation
        }
        
        let numberString = String(equation[range])
        
        guard let number = Double(numberString) else {
            return equation
        }
        
        let invertedNumber = -number
        
        let newNumberString = invertedNumber.truncatingRemainder(dividingBy: 1) == 0
            ? String(Int(invertedNumber))
            : String(invertedNumber)
        
        let newEquation = equation.replacingCharacters(in: range, with: newNumberString)
        
        return newEquation
    }
    
    func evaluateExpression(_ input: String) -> Double? {
        enum Token {
            case number(Double)
            case op(Character)
        }

        func tokenize(_ input: String) -> [Token] {
            var tokens: [Token] = []
            var current = ""
            var previousChar: Character?

            for (i, char) in input.enumerated() {
                if char.isNumber || char == "." {
                    current.append(char)
                } else if "+*/-".contains(char) {
                    if char == "-", (i == 0 || (previousChar != nil && "+-*/".contains(previousChar!))) {
                        // Unary minus
                        current.append(char)
                    } else {
                        if !current.isEmpty {
                            tokens.append(.number(Double(current)!))
                            current = ""
                        }
                        tokens.append(.op(char))
                    }
                }
                previousChar = char
            }

            if !current.isEmpty {
                tokens.append(.number(Double(current)!))
            }

            return tokens
        }

        func precedence(of op: Character) -> Int {
            switch op {
            case "+", "-": return 1
            case "*", "/": return 2
            default: return 0
            }
        }

        func apply(_ lhs: Double, _ rhs: Double, with op: Character) -> Double {
            switch op {
            case "+": return lhs + rhs
            case "-": return lhs - rhs
            case "*": return lhs * rhs
            case "/": return lhs / rhs
            default: fatalError("Unknown operator")
            }
        }

        func shuntingYard(_ tokens: [Token]) -> [Token] {
            var output: [Token] = []
            var operators: [Character] = []

            for token in tokens {
                switch token {
                case .number:
                    output.append(token)
                case .op(let op):
                    while let top = operators.last,
                          precedence(of: top) >= precedence(of: op) {
                        output.append(.op(operators.removeLast()))
                    }
                    operators.append(op)
                }
            }

            while let op = operators.popLast() {
                output.append(.op(op))
            }

            return output
        }

        func evaluatePostfix(_ tokens: [Token]) -> Double {
            var stack: [Double] = []

            for token in tokens {
                switch token {
                case .number(let value):
                    stack.append(value)
                case .op(let op):
                    let rhs = stack.removeLast()
                    let lhs = stack.removeLast()
                    stack.append(apply(lhs, rhs, with: op))
                }
            }

            return stack.last ?? 0
        }

        let tokens = tokenize(input)
        let postfix = shuntingYard(tokens)
        return evaluatePostfix(postfix)
    }

}

struct BlueButton: ButtonStyle {
    let color1: String
    let color2: String
    let color3: String
    let color4: String
    let radius: CGFloat
    let height: CGFloat
    let useWhiteStroke: () -> Bool

    init(color1: String, color2: String, color3: String, color4: String, radius: CGFloat = 50, height: CGFloat = 65, useWhiteStroke: @escaping () -> Bool = { false }) {
        self.color1 = color1
        self.color2 = color2
        self.color3 = color3
        self.color4 = color4
        self.radius = radius
        self.height = height
        self.useWhiteStroke = useWhiteStroke
    }

    func makeBody(configuration: Configuration) -> some View {
        GeometryReader {geo in
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [Color(hex: color1), Color(hex: color1), Color(hex: color2)], startPoint: .top, endPoint: .bottom))
//                    .stroke(Color.black, lineWidth: 3)
                    .frame(width: geo.size.width, height: height)
                
                ZStack {
                    Ellipse()
                        .fill(RadialGradient(colors: [Color(hex: color3), Color(hex: color4)], center: .center, startRadius: 1, endRadius: radius))
                        .frame(width: geo.size.width * 1.5, height: 65)
                        .offset(y: height == 65 ? -35: -height/2)
                }.frame(width: geo.size.width, height: height)
                    .cornerRadius(10)
                    .clipped()
                    .opacity(configuration.isPressed ? 0.0: 1.0)
//                    .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
                
                configuration.label
//                    .font(.system(size: 30, weight: .regular, design: .default))
                    .font(.custom("Helvetica Neue Bold", size: 30))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .onChange(of: configuration.isPressed) { newValue in
                        if configuration.isPressed {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            SoundEffectPlayer.shared.play()
                        }
                    }
                    
                
                RoundedRectangle(cornerRadius: 10)
//                    .stroke(Color.black, lineWidth: 3)
                    .stroke(useWhiteStroke() ? Color.white : Color.black, lineWidth: 3)
                    .frame(width: geo.size.width, height: height)
            }
        }.frame(height: height)
    }
}


#Preview {
    ContentView()
}
