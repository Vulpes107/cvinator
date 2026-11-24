---
name: intake
description: Build or update the person's master career profile and the CV template from the files in input/. Use for first-time setup, when the user adds a new CV, job, project, certificate or photo, or says "update my profile".
---

# intake

Goal: `profile/profile.md` holds everything job-related about the user, and `template/cv.html` reproduces their original CV. Read `CLAUDE.md` rules and `cv-guidelines.md` first.

Extra input from the user for this run: $ARGUMENTS

## 1. Read everything

Read every file in `input/` (CV as PDF/DOCX, photo, certificates, notes, LinkedIn export, anything). If `input/` has no CV, ask the user to put one there and stop. If `profile/profile.md` already exists this is an update: merge, never drop existing facts.

## 2. Write `profile/profile.md`

Capture more than the CV shows; the CV is a subset of the profile. Mark where each fact came from: `[cv]`, `[file: name]`, `[user YYYY-MM-DD]`.

Sections:

- **Identity** — name, contact, location, links, date of birth and nationality only if the original CV shows them
- **Constraints** — work authorisation per country, relocation, remote/hybrid/on-site, notice period, earliest start, travel
- **Targets** — roles wanted, seniority, industries wanted and refused, salary floor and target (currency, gross/net, employment or contract)
- **Experience** — per job: employer, what the employer does, title, exact dates (month and year), team size, reporting line, then every responsibility and achievement as a separate fact with numbers, tools used, and outcome
- **Projects** — work, freelance, personal, open source: problem, own role, tools, result, link
- **Skills** — each with level, years, last used, and where it was used (a skill with no evidence is marked so)
- **Education, Certifications, Courses** — with dates and issuer
- **Languages** — with level (CEFR)
- **Other** — publications, talks, awards, volunteering, interests
- **Confirmed not-haves** — things the user has said they do not have or do not want shown
- **Open questions** — whatever is still unanswered

## 3. Interview the user about what is missing

Go through the profile and list every hole, then ask in chat in batches of at most five numbered questions, most valuable first. Typical holes:

- bullets with no outcome or number ("what changed because of this? roughly how much, how many, how fast?")
- missing months, gaps between jobs longer than six months
- tools listed with no context, or context with no tools
- team size, scope, budget, users, scale
- unclear own role in team projects
- everything in Constraints and Targets, which a CV never contains
- language levels, certificate dates
- things done since the CV was last updated

Write each answer into the profile as it arrives. If the user does not know or declines, record that and move on; do not press. Stop when the remaining holes are minor, and leave them under Open questions.

## 4. Build the template (first run, or when the user supplies a new original)

1. Look at the original CV visually (Read the PDF; for DOCX ask the user to export a PDF into `input/`).
2. Put the photo at `template/photo.<ext>`. Use the image file from `input/` if there is one; otherwise extract it with `pdfimages -all input/<cv>.pdf template/photo`; if that is unavailable ask the user to drop the photo into `input/`.
3. Write `template/cv.html`: one self-contained file, inline CSS, A4 `@page`, same fonts (or the closest installed), colours, column widths, section order, headings, spacing and photo placement as the original, filled with the original content. `<title>` is "First Last - CV". Build columns with CSS grid or flex and order the DOM in logical reading order (name and contact, summary, experience, education, skills, rest). No tables for layout, no text in images, contact details in the body.
4. `./render.sh template/cv.html`, then Read `template/cv.pdf` next to the original and fix differences. Repeat until a person would call them the same document with the same page count. Read `template/cv.txt` and confirm the order is sane.
5. If the original layout breaks a parsing rule in `cv-guidelines.md` in a way HTML cannot hide (for example all skills shown only as bars), tell the user the one smallest change that fixes it and apply it only if they agree.

## 5. Report in chat

Short: what the profile now covers, what is still open, whether the template matches the original, and that `/apply <posting>` is the next step.
