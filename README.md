# 🤖 Astra Robot Control System

**A comprehensive Robot Control Platform with Modern React Interface and Flask Backend**

![Astra Robot](https://img.shields.io/badge/Robot-Astra-blue)
![Platform](https://img.shields.io/badge/Platform-Raspberry_Pi_5-green)
![Interface](https://img.shields.io/badge/Interface-React_TypeScript-blue)
![Backend](https://img.shields.io/badge/Backend-Flask_Python-yellow)
![Hardware](https://img.shields.io/badge/Hardware-SunFounder_PiCrawler-orange)

## 🌟 Overview

Astra is a sophisticated robot control platform featuring:

- **🎯 AstraVoiceControl**: Modern React/TypeScript web interface with LCARS Star Trek design
- **🐍 Flask API Backend**: Comprehensive robot control with gesture recognition and voice commands
- **🦾 Hardware Integration**: SunFounder PiCrawler with ultrasonic sensors and camera
- **🎤 Voice Recognition**: Real-time voice command processing with Piper TTS
- **📹 Live Camera Feed**: Real-time video streaming and computer vision
- **🔊 Audio Feedback**: Text-to-speech responses and system notifications

## 🏗️ Architecture

### Frontend: AstraVoiceControl
- **Framework**: React 18 + TypeScript + Vite
- **UI Design**: LCARS Star Trek interface
- **Proxy Server**: Express.js with fallback handling
- **Port**: 5000
- **Features**: Touch-optimized controls, real-time status, gesture buttons, voice interface

### Backend: Flask API Server
- **Framework**: Flask + Robot HAT library
- **Port**: 5001
- **Hardware**: PiCrawler robot integration
- **Features**: Movement control, sensor data, camera management, voice processing

## 🚀 Quick Start

### 1. Clone Repository
```bash
git clone https://github.com/YourUsername/AstraRobot.git
cd AstraRobot
```

### 2. Start Backend (Flask API)
```bash
cd amy_core
python mobile_api_server.py
```

### 3. Start Frontend (React Interface)
```bash
cd AstraVoiceControl
npm install
npm run dev
```

### 4. Access Interface
Open browser to: `http://192.168.1.4:5000`

## 📁 Project Structure

```
AstraRobot/
├── AstraVoiceControl/          # React frontend
│   ├── src/
│   │   ├── components/         # UI components
│   │   ├── services/          # API services
│   │   └── types/             # TypeScript definitions
│   ├── server/                # Express proxy server
│   └── package.json
├── amy_core/                  # Flask backend
│   ├── mobile_api_server.py   # Main API server
│   ├── postwake_router.py     # Voice processing
│   ├── amy_wake.py            # Wake word detection
│   └── docs/                  # Documentation
└── README.md
```

## 🎮 Features

### Voice Commands
- **Quick Commands**: "Hello", "Status", "Emergency Stop"
- **Complex Commands**: "Move forward 3 seconds", "Take photo", "Look around"
- **Gesture Commands**: "Wave", "Stand up", "Sit down", "Look up/down"

### Movement Control
- **Directional**: Forward, backward, left, right
- **Rotation**: Turn left/right, spin
- **Gestures**: Wave, stand, sit, look up/down
- **Emergency Stop**: Immediate halt all movement

### Sensor Data
- **Ultrasonic**: Distance measurement (front-facing)
- **Camera**: Live video feed with on/off control
- **Battery**: Voltage and percentage monitoring
- **Status**: Real-time system health

### Settings
- **Safe Mode**: Enable/disable movement restrictions
- **Camera Toggle**: Turn camera feed on/off
- **Audio Feedback**: Enable/disable voice responses
- **Desk Mode**: Special mode for desktop operation

## 🔧 Configuration

### Network Settings
- Default IP: `192.168.1.4`
- React Server: Port `5000`
- Flask API: Port `5001`
- Camera Stream: Port `9000`

### Hardware Requirements
- Raspberry Pi 5 (recommended) or Pi 4
- SunFounder PiCrawler kit
- USB Camera (optional)
- Speaker for audio feedback
- Microphone for voice commands

## 🛠️ Development

### Adding New Gestures
1. Add gesture method to `amy_core/mobile_api_server.py`
2. Create API endpoint: `@app.route('/api/new-gesture', methods=['POST'])`
3. Add button to React interface in `AstraVoiceControl/src/components/`

### Adding Voice Commands
1. Update `amy_core/postwake_router.py` command routing
2. Add endpoint to Flask API if needed
3. Test with voice interface

### Customizing Interface
- Modify `AstraVoiceControl/src/components/` for UI changes
- Update `AstraVoiceControl/server/routes.ts` for API routing
- Customize LCARS theme in CSS files

## 🎯 Ready for Dogzilla!

This codebase is designed to be easily adaptable to new robot platforms. The modular architecture allows for:
- Hardware abstraction layer for different robot types
- Configurable movement patterns and gestures
- Scalable API endpoints for new features
- Portable React interface that works across platforms

## 📸 Screenshots

*Interface screenshots coming soon...*

## 🤝 Contributing

1. Fork the repository
2. Create feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- SunFounder for the PiCrawler hardware platform
- React and Flask communities for excellent frameworks
- Star Trek for LCARS interface inspiration

---

**Ready to control robots like a Starfleet officer! 🖖**