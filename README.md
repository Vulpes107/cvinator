# cvinator

Tailors your CV to a job posting, using Claude Code. It keeps your original CV's look and never invents anything about you.

## Setup

Needs [Claude Code](https://claude.com/claude-code), Chromium and poppler:

```
sudo apt install -y poppler-utils chromium
```

## Use

Open Claude Code in this folder, then:

1. Put your current CV (PDF) in `input/` and run `/cv-intake`. Answer its questions once.
2. For each job, run `/cv-apply` followed by the posting's text (paste it; links to LinkedIn usually don't load).
3. Optional: run `/cv-review` for an independent check of what could get the CV filtered out.

Your CV lands in `applications/<date>_<company>_<role>/` as a PDF. Every run is kept.

## Good to know

- It will ask you when a posting wants something your profile doesn't mention. A "no" is remembered and never asked again.
- Your CV, profile and generated files are ignored by git and stay on your machine.
