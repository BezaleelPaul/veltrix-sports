# Veltrix Sports - VS Code Setup

## Profile: Flutter Development

### How to Use the Profile

1. Open VS Code
2. Press `Ctrl+Shift+P` to open Command Palette
3. Type "Profiles: Show All Profiles" and select it
4. Select "Flutter Development" profile
5. All extensions and settings will be loaded

### Extensions Included

#### Flutter/Dart Essential
- `dart-code.dart-code` - Dart language support
- `dart-code.flutter` - Flutter support
- `alexisvt.flutter-snippets` - Flutter snippets
- `nash.awesome-flutter-snippets` - More Flutter snippets
- `gmlewis-vscode.flutter-stylizer` - Code organization
- `hzgood.dart-data-class-generator` - Data class generation
- `jeroen-meijer.pubspec-assist` - Pubspec helper

#### Productivity
- `formulahendry.auto-rename-tag` - Auto rename HTML tags
- `formulahendry.code-runner` - Run code snippets
- `christian-kohler.path-intellisense` - Path autocomplete
- `usernamehw.errorlens` - Inline error display
- `gruntfuggly.todo-tree` - TODO highlighting

#### Git & Version Control
- `eamodio.gitlens` - Git supercharged
- `github.vscode-github-actions` - GitHub Actions
- `github.vscode-pull-request-github` - PR management

#### UI & Theme
- `pkief.material-icon-theme` - File icons
- `vscode-icons-team.vscode-icons` - More icons
- `esbenp.prettier-vscode` - Code formatting

#### Remote Development
- `ms-vscode-remote.remote-ssh` - SSH remote
- `ms-vscode-remote.remote-wsl` - WSL remote
- `ms-vscode-remote.remote-containers` - Container remote

#### AI Assistants
- `google.geminicodeassist` - Google Gemini
- `sourcegraph.cody-ai` - Cody AI
- `anthropic.claude-code` - Claude AI

### Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| `Ctrl+Shift+R` | Run Flutter app |
| `Ctrl+Shift+H` | Hot reload |
| `Ctrl+Shift+P` | Hot restart |
| `Ctrl+Shift+D` | Debug attach |
| `Ctrl+Shift+O` | Organize imports |
| `Ctrl+Shift+F` | Fix all issues |
| `Ctrl+Enter` | Quick fix |
| `Ctrl+Shift+Enter` | Insert line after |
| `Ctrl+/` | Toggle comment |
| `Ctrl+D` | Duplicate selection |
| `Ctrl+Shift+Up` | Move line up |
| `Ctrl+Shift+Down` | Move line down |
| `Alt+Up` | Copy line up |
| `Alt+Down` | Copy line down |

### Settings Highlights

- **Format on save** - Auto-format code
- **Auto-fix on save** - Auto-fix issues
- **Organize imports on save** - Auto-organize imports
- **Font ligatures** - Better code readability
- **Bracket pair colorization** - Easy bracket matching
- **Sticky scroll** - Keep context visible
- **Inline suggestions** - AI-powered completions

### Run Configurations

| Configuration | Description |
|---------------|-------------|
| Flutter (Debug) | Debug on connected device |
| Flutter (Profile) | Profile mode |
| Flutter (Release) | Release mode |
| Flutter (Debug - Chrome) | Debug on Chrome |
| Flutter (Debug - Edge) | Debug on Edge |
| Flutter (Debug - Windows) | Debug on Windows |
| Flutter (Attach) | Attach to running app |
| Flutter (Run without Debugging) | Run without debugger |

### Tasks Available

| Task | Description |
|------|-------------|
| Flutter: Run | Run the app |
| Flutter: Clean | Clean build files |
| Flutter: Pub Get | Get dependencies |
| Flutter: Analyze | Analyze code |
| Flutter: Test | Run tests |
| Flutter: Build APK | Build Android APK |
| Flutter: Build iOS | Build iOS app |
| Flutter: Build Web | Build web app |
| Flutter: Build Windows | Build Windows app |
| Flutter: Format | Format code |
| Flutter: Doctor | Check Flutter setup |
| Flutter: Devices | List devices |
| Flutter: Emulators | List emulators |

### Tips

1. **Use `Ctrl+Space`** for IntelliSense suggestions
2. **Use `F12`** to go to definition
3. **Use `Ctrl+K F12`** to peek definition
4. **Use `Ctrl+Shift+F`** to search across files
5. **Use `Ctrl+P`** to quick open files
6. **Use `Ctrl+Shift+P`** for command palette

### Troubleshooting

If extensions don't load:
1. Restart VS Code
2. Check extension is enabled
3. Reload window with `Ctrl+Shift+P` → "Reload Window"

If formatting doesn't work:
1. Check Dart SDK path in settings
2. Run `flutter pub get`
3. Restart VS Code

### Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [VS Code Flutter](https://dartcode.org/docs/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
