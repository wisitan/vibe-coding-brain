#!/bin/bash
# ============================================================
# Setup Script for Mac: Link Master Brain to Local Antigravity
# ============================================================

REPO_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
GEMINI_DIR="$HOME/.gemini"
CONFIG_DIR="$GEMINI_DIR/config"

echo "🧠 Setting up Vibe Coding Brain on Mac..."
mkdir -p "$CONFIG_DIR"

# 1. Link GEMINI.md (Persona & Personal Context)
if [ -f "$REPO_DIR/GEMINI.md" ]; then
    rm -f "$GEMINI_DIR/GEMINI.md"
    ln -s "$REPO_DIR/GEMINI.md" "$GEMINI_DIR/GEMINI.md"
    echo "✅ Linked GEMINI.md"
fi

# 2. Link rules
if [ -d "$REPO_DIR/rules" ]; then
    rm -rf "$CONFIG_DIR/rules"
    ln -s "$REPO_DIR/rules" "$CONFIG_DIR/rules"
    echo "✅ Linked rules -> $REPO_DIR/rules"
fi

# 3. Link skills
if [ -d "$REPO_DIR/skills" ]; then
    rm -rf "$CONFIG_DIR/skills"
    ln -s "$REPO_DIR/skills" "$CONFIG_DIR/skills"
    echo "✅ Linked skills -> $REPO_DIR/skills"
fi

# 4. Link templates
if [ -d "$REPO_DIR/templates" ]; then
    rm -rf "$CONFIG_DIR/templates"
    ln -s "$REPO_DIR/templates" "$CONFIG_DIR/templates"
    echo "✅ Linked templates -> $REPO_DIR/templates"
fi

echo ""
echo "🎉 น้อง Sunday ในเครื่อง Mac พร้อมทำงานด้วย Local Brain แล้วค่ะ!"
