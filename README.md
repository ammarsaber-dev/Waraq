<!-- ![Cover](docs/cover.png) -->

# 📖 Waraq
Waraq (ورق, Arabic for "pages") is a personal reading tracker for iOS, built with **SwiftUI** and **SwiftData**. I bought 19 books in one order and had no way to track any of them — this is my fix, and how I'm learning iOS development for real by shipping something I actually use every day.

<br>

<!--
## ▶️ Demo
Watch a quick demo on [YouTube](#).

<br>
-->

## 🌟 Features
- Track your library with a progress ring per book
- Log a starting page when adding a book you've already begun
- Update progress with quick-tap page buttons or manual entry
- Time a reading session with a live, pause-aware timer
- Set a daily page goal per book and track live progress toward it
- View reading stats — streaks, average session length, most-read book

<br>

<!--
## 🖼️ Screenshots

| **Library** | **Book Detail** | **Reading Session** | **Stats** |
| ----------- | ---------------- | -------------------- | --------- |
| ![Library](docs/screenshot-library.png) | ![Detail](docs/screenshot-detail.png) | ![Session](docs/screenshot-session.png) | ![Stats](docs/screenshot-stats.png) |

<br>
-->

## 🛠️ Tools
- Swift
- SwiftUI
- SwiftData
- TimelineView

<br>

## 🗂️ Project Structure

```
    Waraq                            # Root Group
    .
    ├── App                          # App entry point, root view
    ├── Features                     # Organized by feature, not by file type
    │   └── Feature                  # A feature that represents a single concern
    │       ├── Models               # SwiftData models for the feature
    │       ├── ViewModels           # View Models, where the feature needs one
    │       └── Views                # SwiftUI Views, one view per file
    │           └── Components       # Subviews private to a specific screen
    └── Shared                       # Reusable views used across features
```

<br>

## 🗺️ Roadmap
- [x] Book detail view + manual progress updates
- [x] Reading session logging (start/stop timer)
- [x] Stats dashboard
- [x] Daily reading goals
- [ ] Scheduled reading reminders
- [ ] Arabic + English localization

<br>

## 🚀 Getting Started
Clone the repo and open `Waraq.xcodeproj` in Xcode 26+.
```bash
git clone https://github.com/ammarsaber-dev/waraq.git
```
