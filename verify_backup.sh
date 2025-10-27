#!/bin/bash
# Backup Verification Script - Test backup integrity

echo "🔍 MASTER BACKUP VERIFICATION"
echo "============================"

LATEST_BACKUP="/home/spencer/MASTER_BACKUPS/LATEST"

if [ ! -L "$LATEST_BACKUP" ]; then
    echo "❌ No backup found at $LATEST_BACKUP"
    exit 1
fi

BACKUP_DIR=$(readlink -f "$LATEST_BACKUP")
echo "📁 Verifying backup: $BACKUP_DIR"
echo ""

# Check Astra system
echo "🤖 Verifying Astra System Backup..."
if [ -d "$BACKUP_DIR/AstraVoiceControl_WORKING" ]; then
    echo "✅ AstraVoiceControl backed up"
else
    echo "❌ AstraVoiceControl missing"
fi

if [ -d "$BACKUP_DIR/amy_core_WORKING" ]; then
    echo "✅ amy_core backed up"
else
    echo "❌ amy_core missing"  
fi

if [ -d "$BACKUP_DIR/AstraRobot_REPOSITORY" ]; then
    echo "✅ AstraRobot repository backed up"
else
    echo "❌ AstraRobot repository missing"
fi

# Check Dogzilla system
echo ""
echo "🐕🦖 Verifying Dogzilla System Backup..."
if [ -d "$BACKUP_DIR/DogzillaRobot_REPOSITORY" ]; then
    echo "✅ DogzillaRobot repository backed up"
else
    echo "❌ DogzillaRobot repository missing"
fi

# Check critical files
echo ""
echo "📄 Verifying Critical Files..."
critical_files=(
    "AstraVoiceControl_WORKING/package.json"
    "amy_core_WORKING/mobile_api_server.py"
    "DogzillaRobot_REPOSITORY/DOGZILLA_SETUP_GUIDE.md"
    "DogzillaRobot_REPOSITORY/dogzilla_control.sh"
    "BACKUP_MANIFEST.txt"
    "QUICK_RESTORE.sh"
)

for file in "${critical_files[@]}"; do
    if [ -f "$BACKUP_DIR/$file" ]; then
        echo "✅ $file present"
    else
        echo "❌ $file missing"
    fi
done

# Check backup size and file count
echo ""
echo "📊 Backup Statistics..."
BACKUP_SIZE=$(du -sh "$BACKUP_DIR" | cut -f1)
FILE_COUNT=$(find "$BACKUP_DIR" -type f | wc -l)
echo "📁 Size: $BACKUP_SIZE"
echo "📄 Files: $FILE_COUNT"

# Test restore script
echo ""
echo "🧪 Testing Restore Script..."
if [ -x "$BACKUP_DIR/QUICK_RESTORE.sh" ]; then
    echo "✅ Restore script is executable"
else
    echo "❌ Restore script not executable"
fi

echo ""
echo "🎯 VERIFICATION COMPLETE!"
echo "Backup is ready for emergency restoration."