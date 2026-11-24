---
name: screen
description: Judge a finished CV against its job posting the way a screener would - what could get it filtered out, ranked low or skipped by a recruiter, and what would improve it. Use after apply, or when the user asks to review, check, score or critique a CV for a posting.
argument-hint: [run folder name, default: the newest folder in applications/]
---

# screen

Run: $ARGUMENTS (empty = the most recently modified folder in `applications/`)

Goal: find what would stop this CV from reaching an interview, before a recruiter does. This skill reports; it does not edit the CV unless the user then says so.

The run folder must contain `posting.md`, `cv.html`, `cv.txt` and the PDF. If it does not, say what is missing and stop.

## 1. Cold read by a fresh agent

You wrote or have read the strategy behind this CV, so you will see what was meant, not what is on the page. Spawn ONE general-purpose agent (Agent tool) and give it only:

- the path to the PDF, `cv.txt` and `posting.md`
- `research.md` only for the "Requirement classes" and "Role" sections (when the posting names no role, that is the yardstick)
- NOT `fit.md`, NOT `profile/profile.md`, NOT this conversation's reasoning

Ask it to act as three screeners in turn and report findings, each with the exact CV line or place it refers to:

1. **Parser / ATS.** Read `cv.txt` only. Are name, email, phone, location found at the top? Are section names standard? Are job titles, employers and dates extractable and consistent? Anything out of order, glued together, missing, or only visible in the PDF? Which of the posting's hard terms (technologies, role words, required language, location) are absent from the text, and which appear only once or only in a skills list with no evidence nearby?
2. **Recruiter, 10-second scan of page one.** Look at the PDF. What role does this person seem to be? Does that match the posting? What are the first three things the eye lands on, and are they the three most relevant? Is there any reason to reject visible at a glance: missing must-have, wrong seniority, unexplained gap, wall of text, typos, anything that reads as generic or machine-written, anything odd for the country (photo, personal data)? Would they read page two?
3. **Hiring manager, full read.** For each core requirement of the posting: is there proof, a bare claim, or nothing? Which bullets are vague (no what, no result, no scale)? Which claims would they probe in an interview, and which look inflated? What is on the CV that this role does not care about and is taking space from something better?

Then one verdict: `pass`, `borderline` or `likely filtered`, with the single biggest reason, and a requirement coverage count (core requirements with proof / total).

## 2. Check the findings against the truth

Now use `profile/profile.md` and `fit.md` yourself. For every problem the agent found, decide which it is:

- **fixable from the profile** - the fact exists but the CV hides, buries or words it badly. Say the exact change.
- **fixable by asking** - the profile is silent; name the question for the user.
- **real gap** - listed under Confirmed not-haves. No CV change can fix it; say how to handle it (leave unsaid, show the nearest true thing, prepare the interview answer). Never suggest claiming it.
- **wrong** - the agent misread; drop it.

Also check what the cold reader cannot: is anything in the CV not supported by the profile, or stronger than the profile says? Does it break a rule in "CV preferences"? Those are blockers.

Then look the other way: is there a fact in the profile that answers a core requirement and is not in the CV at all?

## 3. Write `review.md` in the run folder

Agent-facing, terse: verdict, coverage, findings table (severity, where, problem, class from step 2, fix). If a `review.md` exists, append a dated section; never overwrite.

Severity:
- **blocker** - can get the CV filtered or rejected on sight (failed gate visible, contact not parsed, core term missing though true, unsupported claim, typo in name/contact, page spilled)
- **major** - costs ranking or the recruiter's interest (key proof on page two, role unclear in ten seconds, vague bullets on the main proof points)
- **minor** - polish

## 4. Report in chat

Short and ranked: the verdict in one sentence, then blockers, then majors, each with the proposed fix. Minor points as one line. End by listing the fixes you can apply right now from the profile and the questions that need the user. Apply fixes only when the user agrees; after applying, re-render with `./render.sh`, repeat the checks from apply step 7, and run the humanize skill on any reworded text.
