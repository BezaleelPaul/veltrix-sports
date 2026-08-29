"""
Automated GitHub Setup for Veltrix Sports
"""

import os
import subprocess
import sys

def run_command(command):
    """Run a command and return output"""
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, cwd=r"C:\Users\bezal\Downloads\veltrix_sports")
        return result.stdout, result.stderr, result.returncode
    except Exception as e:
        return "", str(e), 1

def setup_github():
    print("=" * 60)
    print("VELTRIX SPORTS - Automated GitHub Setup")
    print("=" * 60)
    print()
    
    # Step 1: Initialize Git
    print("[1/6] Initializing Git repository...")
    stdout, stderr, code = run_command("git init")
    if code == 0:
        print("  ✓ Git initialized")
    else:
        print(f"  ✗ Error: {stderr}")
        return False
    
    # Step 2: Create .gitignore
    print("[2/6] Creating .gitignore...")
    gitignore_content = """# Veltrix Sports .gitignore

# Flutter
.dart_tool/
.packages
build/

# Android
android/.gradle/
android/app/debug/
android/app/profile/
android/app/release/

# iOS
ios/Pods/
ios/.symlinks/
ios/Flutter/Flutter.framework

# IDE
.vscode/
.idea/
*.iml

# OS
.DS_Store
Thumbs.db

# Environment
.env
.env.local

# Python
__pycache__/
*.pyc

# Temporary
*.tmp
*.bak

# Keep important files
!diagrams/
!*.md
!*.txt
!*.docx
"""
    with open(".gitignore", "w") as f:
        f.write(gitignore_content)
    print("  ✓ .gitignore created")
    
    # Step 3: Add files
    print("[3/6] Adding files to Git...")
    stdout, stderr, code = run_command("git add .")
    if code == 0:
        print("  ✓ Files added")
    else:
        print(f"  ✗ Error: {stderr}")
        return False
    
    # Step 4: Commit
    print("[4/6] Creating initial commit...")
    stdout, stderr, code = run_command('git commit -m "Initial commit: Veltrix Sports documentation and diagrams"')
    if code == 0:
        print("  ✓ Commit created")
    else:
        print(f"  ✗ Error: {stderr}")
        return False
    
    # Step 5: Instructions
    print("[5/6] Repository setup instructions...")
    print()
    print("  Please create a GitHub repository:")
    print("  1. Go to https://github.com/new")
    print("  2. Repository name: veltrix-sports")
    print("  3. Description: Veltrix Sports - Coaching, Events & Ticketing Platform")
    print("  4. Select: Public (or Private)")
    print("  5. Click 'Create repository'")
    print("  6. Copy the repository URL")
    print()
    
    # Step 6: Get repository URL
    print("[6/6] Push to GitHub...")
    repo_url = input("  Enter your GitHub repository URL: ").strip()
    
    if not repo_url:
        print("  ✗ No URL provided. Run this script again later.")
        return False
    
    # Add remote
    stdout, stderr, code = run_command(f"git remote add origin {repo_url}")
    if code != 0 and "already exists" not in stderr:
        print(f"  ✗ Error adding remote: {stderr}")
        return False
    
    # Push
    stdout, stderr, code = run_command("git push -u origin main")
    if code == 0:
        print("  ✓ Pushed to GitHub")
    else:
        print(f"  ✗ Error pushing: {stderr}")
        return False
    
    print()
    print("=" * 60)
    print("SUCCESS! Documentation backed up to GitHub")
    print("=" * 60)
    print()
    print(f"Repository URL: {repo_url}")
    print()
    print("Your documentation is now safely backed up!")
    print()
    
    return True

if __name__ == '__main__':
    setup_github()
