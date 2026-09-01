# Waraq (ورق)

A reading tracker for people who buy books faster than they read them.

## The problem

I bought 19 books in a single order. Then I had no way to track what I'd started, how far into each one I was, or whether I was actually making progress — because I wasn't. My phone won a lot more than my reading list did.

Waraq is my attempt to fix that, and to learn iOS development properly while doing it — not through tutorials, but by building something I'll actually use every day.

## What it does (v0)

- Add books manually (title, author, total pages), optionally setting a starting page if you're already partway through
- View all books in a list, each with a progress ring reflecting reading status
- Tap into a book to see full details and update progress — quick +10/+25/+50 page buttons, or manual entry for anything else
- Reading status (not started / reading / finished) shown with a colored badge, consistent across list and detail views
- Data persists locally via SwiftData

This is an early, intentionally minimal version. No session timers, goals, reminders, or stats yet — see [Roadmap](#roadmap).

## Tech stack

- **Swift / SwiftUI** — UI and app logic
- **SwiftData** — local persistence
- **MVVM** — architecture pattern
- iOS 26+

## Roadmap

- [x] Book detail view + manual progress updates
- [x] Reading session logging (start/stop timer)
- [ ] Monthly / yearly reading goals
- [ ] Scheduled reading reminders
- [x] Stats dashboard
- [ ] Arabic + English localization

## Getting started

Clone the repo and open `Waraq.xcodeproj` in Xcode 26+.

```bash
git clone https://github.com/ammarsaber-dev/waraq.git
```

## Status

Actively in development as a learning project and portfolio piece. Built one deliberate slice at a time — model, then view, then flow — rather than scaffolded all at once.
