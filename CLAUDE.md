# cvinator

Turns one person's career data into a CV tailored to a specific job posting. There is no application code: the agent is the system, `render.sh` only prints HTML to PDF.

## Commands

- `/cv-intake` — first-time setup or update: reads everything in `input/`, builds `profile/profile.md`, rebuilds the original CV as `template/cv.html`, interviews the user about gaps.
- `/cv-apply <posting URL or pasted text>` — researches the company, role and pay, checks fit, asks the user about gaps, writes the tailored CV PDF into a new folder under `applications/`.

- `/cv-review [run folder]` — judges a finished CV against its posting as a parser, a recruiter and a hiring manager would; reports what could get it filtered out and what to improve. Defaults to the newest run.

## Layout

```
input/                  user drops things here: current CV, photo, certificates, notes, LinkedIn export
profile/profile.md      single source of truth about the person
template/cv.html        the user's original CV layout, rebuilt in HTML (+ template/photo.*)
applications/<date>_<company>_<role>/
    posting.md  research.md  fit.md  review.md  cv.html  cv.txt  <First>_<Last>_CV.pdf
cv-guidelines.md        what makes a CV pass screening, with sources
render.sh               ./render.sh path/to/cv.html [out.pdf]
```

## Rules

1. **Nothing invented.** Every claim in a CV must trace to `profile/profile.md`. If the profile is silent, ask the user; never guess, never round up, never add a skill because the posting wants it.
2. **Ask, then remember.** Every answer the user gives, including "no, I don't have that", goes into `profile/profile.md` right away so it is never asked twice.
3. **Privacy.** Web searches contain the company, role and location only. Never the user's name, email, phone, employer history or any other personal detail.
4. **The template is fixed.** Photo, contact block, fonts, colours and layout stay as in `template/cv.html`. Tailoring changes text, order and selection of content only.
5. **Only the PDF is for humans.** Every other file is agent working memory: terse, factual, no prose polish. What the user needs to know is said in chat.
6. **Runs are kept.** Never delete or overwrite an existing folder in `applications/`. A second run for the same posting gets a new folder.
7. **Humanize every CV.** Text written for a CV always goes through the humanize skill (`anthropic-skills:humanize`) before rendering, without the user asking.
8. Snap Chromium cannot read `/tmp` or hidden directories. Keep everything it renders inside this project.
