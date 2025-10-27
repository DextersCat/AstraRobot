#!/bin/bash
# MASTER BACKUP SYSTEM - 27 October 2025
# Complete backup of all robot systems before Dogzilla arrival

BACKUP_DATE=$(date +"%Y%m%d_%H%M%S")
BACKUP_BASE="/home/spencer/MASTER_BACKUPS"
BACKUP_DIR="$BACKUP_BASE/robot_systems_backup_$BACKUP_DATE"

echo "🔒 MASTER BACKUP SYSTEM - ROBOT PROTECTION"
echo "=========================================="
echo "📅 Backup Date: $BACKUP_DATE"
echo "📁 Backup Location: $BACKUP_DIR"
echo ""

# Create backup directory
mkdir -p "$BACKUP_DIR"
cd "$BACKUP_BASE"

echo "🤖 BACKING UP ASTRA SYSTEM (WORKING PRODUCTION)"
echo "=============================================="

# Backup Astra working system
echo "📂 Backing up AstraVoiceControl interface..."
cp -r /home/spencer/AstraVoiceControl "$BACKUP_DIR/AstraVoiceControl_WORKING"

echo "📂 Backing up amy_core backend..."
cp -r /home/spencer/amy_core "$BACKUP_DIR/amy_core_WORKING"

echo "📂 Backing up AstraRobot repository..."
cp -r /home/spencer/AstraRobot "$BACKUP_DIR/AstraRobot_REPOSITORY"

echo "✅ Astra system backup complete"
echo ""

echo "🐕🦖 BACKING UP DOGZILLA SYSTEM (PREPARED)"
echo "========================================"

# Backup Dogzilla prepared system
echo "📂 Backing up DogzillaRobot repository..."
cp -r /home/spencer/DogzillaRobot "$BACKUP_DIR/DogzillaRobot_REPOSITORY"

echo "✅ Dogzilla system backup complete"
echo ""

echo "⚙️ BACKING UP SYSTEM CONFIGURATION"
echo "================================="

# Backup system configurations
mkdir -p "$BACKUP_DIR/system_config"

echo "📂 Backing up git configuration..."
cp ~/.gitconfig "$BACKUP_DIR/system_config/" 2>/dev/null || echo "⚠️ No .gitconfig found"

echo "📂 Backing up SSH keys..."
cp -r ~/.ssh "$BACKUP_DIR/system_config/" 2>/dev/null || echo "⚠️ No SSH keys found"

echo "📂 Backing up bash configuration..."
cp ~/.bashrc "$BACKUP_DIR/system_config/" 2>/dev/null || echo "⚠️ No .bashrc found"
cp ~/.bash_profile "$BACKUP_DIR/system_config/" 2>/dev/null || echo "⚠️ No .bash_profile found"

echo "📂 Backing up Python pip list..."
pip3 list > "$BACKUP_DIR/system_config/pip_packages_list.txt"

echo "📂 Backing up system info..."
uname -a > "$BACKUP_DIR/system_config/system_info.txt"
lsb_release -a >> "$BACKUP_DIR/system_config/system_info.txt" 2>/dev/null
df -h > "$BACKUP_DIR/system_config/disk_usage.txt"
free -h > "$BACKUP_DIR/system_config/memory_info.txt"

echo "✅ System configuration backup complete"
echo ""

echo "🔧 BACKING UP DEVELOPMENT TOOLS"
echo "=============================="

# Backup important scripts and tools
mkdir -p "$BACKUP_DIR/tools"

echo "📂 Backing up bin directory..."
cp -r /home/spencer/bin "$BACKUP_DIR/tools/" 2>/dev/null || echo "⚠️ No bin directory found"

echo "📂 Backing up custom scripts..."
find /home/spencer -name "*.sh" -type f -exec cp {} "$BACKUP_DIR/tools/" \; 2>/dev/null

echo "✅ Development tools backup complete"
echo ""

echo "📊 CREATING BACKUP MANIFEST"
echo "=========================="

# Create backup manifest
MANIFEST_FILE="$BACKUP_DIR/BACKUP_MANIFEST.txt"

cat > "$MANIFEST_FILE" << EOF
🔒 MASTER BACKUP MANIFEST
========================
Backup Date: $BACKUP_DATE
Backup Location: $BACKUP_DIR
System: $(uname -a)

📦 CONTENTS:
===========

🤖 ASTRA SYSTEM (WORKING PRODUCTION):
- AstraVoiceControl_WORKING/     # Working React interface (port 5000)
- amy_core_WORKING/              # Working Flask backend (port 5001)  
- AstraRobot_REPOSITORY/         # Complete GitHub repository

🐕🦖 DOGZILLA SYSTEM (PREPARED):
- DogzillaRobot_REPOSITORY/      # Complete setup guide & codebase

⚙️ SYSTEM CONFIGURATION:
- system_config/                 # Git, SSH, bash configs
- system_config/pip_packages_list.txt
- system_config/system_info.txt

🔧 DEVELOPMENT TOOLS:
- tools/                         # Scripts and utilities

🎯 RESTORATION INSTRUCTIONS:
===========================

If disaster strikes, restore with:

1. ASTRA SYSTEM RESTORATION:
   cp -r $BACKUP_DIR/AstraVoiceControl_WORKING /home/spencer/AstraVoiceControl
   cp -r $BACKUP_DIR/amy_core_WORKING /home/spencer/amy_core
   cp -r $BACKUP_DIR/AstraRobot_REPOSITORY /home/spencer/AstraRobot

2. DOGZILLA SYSTEM RESTORATION:
   cp -r $BACKUP_DIR/DogzillaRobot_REPOSITORY /home/spencer/DogzillaRobot

3. SYSTEM CONFIG RESTORATION:
   cp $BACKUP_DIR/system_config/.gitconfig ~/
   cp -r $BACKUP_DIR/system_config/.ssh ~/
   cp $BACKUP_DIR/system_config/.bashrc ~/

4. START ASTRA (KNOWN WORKING):
   cd /home/spencer/amy_core && python mobile_api_server.py &
   cd /home/spencer/AstraVoiceControl && npm run dev

5. VERIFY WORKING SYSTEM:
   http://192.168.1.4:5000/  # Astra interface
   Test voice commands: "Computer, stand up"

✅ BACKUP VERIFICATION:
======================
$(date): Backup created successfully
Total Size: $(du -sh $BACKUP_DIR | cut -f1)
Files Count: $(find $BACKUP_DIR -type f | wc -l)

🚨 EMERGENCY CONTACT:
====================
GitHub: https://github.com/DextersCat/AstraRobot
GitHub: https://github.com/DextersCat/DogzillaRobot
Email: spencerdixon@btinternet.com

This backup contains EVERYTHING needed to restore both robot systems!
EOF

echo "✅ Backup manifest created"
echo ""

# Calculate backup size
BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
FILE_COUNT=$(find "$BACKUP_DIR" -type f | wc -l)

echo "📊 BACKUP STATISTICS"
echo "==================="
echo "📁 Total Size: $BACKUP_SIZE"
echo "📄 Files Backed Up: $FILE_COUNT"
echo "⏰ Time: $(date)"
echo ""

# Create quick restore script
RESTORE_SCRIPT="$BACKUP_DIR/QUICK_RESTORE.sh"
cat > "$RESTORE_SCRIPT" << 'EOF'
#!/bin/bash
# Quick restoration script

echo "🚨 EMERGENCY RESTORATION - ROBOT SYSTEMS"
echo "========================================"

BACKUP_DIR="$(dirname "$0")"
echo "📁 Restoring from: $BACKUP_DIR"

echo "🤖 Restoring Astra (working system)..."
cp -r "$BACKUP_DIR/AstraVoiceControl_WORKING" /home/spencer/AstraVoiceControl
cp -r "$BACKUP_DIR/amy_core_WORKING" /home/spencer/amy_core
cp -r "$BACKUP_DIR/AstraRobot_REPOSITORY" /home/spencer/AstraRobot

echo "🐕🦖 Restoring Dogzilla (prepared system)..."
cp -r "$BACKUP_DIR/DogzillaRobot_REPOSITORY" /home/spencer/DogzillaRobot

echo "⚙️ Restoring system configuration..."
cp "$BACKUP_DIR/system_config/.gitconfig" ~/ 2>/dev/null
cp -r "$BACKUP_DIR/system_config/.ssh" ~/ 2>/dev/null
cp "$BACKUP_DIR/system_config/.bashrc" ~/ 2>/dev/null

echo "✅ RESTORATION COMPLETE!"
echo ""
echo "🚀 To start Astra (known working):"
echo "cd /home/spencer/amy_core && python mobile_api_server.py &"
echo "cd /home/spencer/AstraVoiceControl && npm run dev"
echo ""
echo "🌐 Then access: http://192.168.1.4:5000/"
EOF

chmod +x "$RESTORE_SCRIPT"

echo "🔒 BACKUP COMPLETION SUMMARY"
echo "============================="
echo "✅ Astra working system backed up"
echo "✅ Dogzilla prepared system backed up"  
echo "✅ System configuration backed up"
echo "✅ Development tools backed up"
echo "✅ Backup manifest created"
echo "✅ Quick restore script created"
echo ""
echo "📁 Backup Location: $BACKUP_DIR"
echo "📄 Manifest: $MANIFEST_FILE"
echo "🚀 Restore Script: $RESTORE_SCRIPT"
echo ""
echo "🎯 STATUS: MASTER BACKUP COMPLETE!"
echo "🔒 All robot systems are now protected"
echo ""
echo "💡 To restore in emergency:"
echo "   bash $RESTORE_SCRIPT"

# Create symlink to latest backup
ln -sf "$BACKUP_DIR" "$BACKUP_BASE/LATEST"
echo "🔗 Latest backup symlink created: $BACKUP_BASE/LATEST"

echo ""
echo "🎉 MASTER BACKUP SYSTEM COMPLETE!"
echo "Ready for Dogzilla arrival with full protection! 🐕🦖"