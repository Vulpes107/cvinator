---
name: apply
description: Produce a CV tailored to one job posting. Takes a posting URL or pasted posting text, researches the company, the role and the pay, checks the user's fit, asks about gaps, and writes the final PDF into a new folder under applications/. Use whenever the user shares a job posting or asks for a CV for a specific job.
argument-hint: <posting URL or pasted posting text>
---

# apply

Posting: $ARGUMENTS

Read `CLAUDE.md` rules, `cv-guidelines.md` and `profile/profile.md` first. If the profile or `template/cv.html` does not exist, run the intake skill and come back.

Goal: the highest honest chance of an interview. Honest means every line is true and the user could defend it in the interview.

## 1. Capture the posting

- URL given: fetch it. LinkedIn and most job boards block this; if the text does not come back complete, ask the user to paste the posting and continue.
- Create `applications/<YYYY-MM-DD>_<company>_<role>/` (lowercase, hyphens). If it exists, add `_2`.
- Save `posting.md`: URL, capture date, then the posting text verbatim. Postings disappear; this copy is the record.
- Look through earlier folders in `applications/` for the same company or a similar role and reuse their research and the user's earlier answers.

## 2. Research (parallel web searches, company and role terms only, never the user's data)

Write `research.md`, each fact with source URL and date. Mark anything unverified.

**Company** — what it sells and to whom, size, ownership and funding, financial health, recent news, layoffs or hiring freezes, the products and technology the role touches, engineering or team blog, culture and employee reviews (and how many reviews that is based on), red flags.

**Role** — what this person will do day to day, why the role is likely open, the problem the team needs solved, who it reports to if public, the same or sister postings from this company (they reveal what is really required), reported interview process.

**What they actually expect** — read the posting against the research and sort every requirement:
- *gate*: licence, right to work, required language, clearance, legally required degree, non-negotiable location
- *core*: in the title, in the first lines, repeated, or tied to the listed responsibilities
- *soft*: years of experience, long tool lists, "preferred", "nice to have", "ideally"
- *filler*: generic traits every posting lists

**Pay** — market range for this title, seniority and location: base and total, currency, gross or net, employment or contract. At least two independent sources (company's own stated range, levels.fyi, Glassdoor, Kununu, local salary surveys and job boards, public pay-transparency data). Typical benefits for this company and market. Then a recommendation for this user given their level: the number to ask for, the range to expect, the floor to walk away at, compared with the salary targets in the profile.

## 3. Fit analysis

Write `fit.md`: a table with one row per requirement — class (gate/core/soft/filler), status, evidence from the profile.

Status:
- **met** — the profile has direct evidence
- **adjacent** — the profile has something close and transferable; name it
- **unknown** — the profile says nothing
- **no** — listed under Confirmed not-haves

## 4. Ask the user

The profile is never complete; people learn things they never wrote down. Before writing anything, ask about:

- every **unknown** on a gate or core requirement ("The posting asks for X. Have you worked with it, even briefly, on the side, or with something similar? Where?")
- every **adjacent** core item where a detail would make it stronger
- anything that stands out: a gap, a title mismatch, a seniority jump, a short tenure, a change of field

One batch, most important first, soft items only if few. For yes/no/some choices use AskUserQuestion; for "tell me what you did" ask in chat. Do not ask about anything already answered in the profile or in a previous run.

Write every answer into `profile/profile.md` immediately (a "no" goes under Confirmed not-haves) and update `fit.md`.

Then judge:
- A **gate fails** → tell the user plainly, with what the research says about how strict it is, and ask whether to continue. Do not produce a CV that hides it.
- Under about half of the core requirements met or adjacent → say so with the odds as you see them; continue if the user wants.
- Otherwise continue without asking.

## 5. Strategy (append to `fit.md`)

- The one-sentence case for this candidate for this role.
- Three to five proof points from the profile that carry it, ranked.
- Posting terms to mirror, each mapped to the true profile fact it will be attached to.
- What to shrink or leave out as irrelevant.
- For each unmet core requirement: the nearest true thing to show instead. Never a claim of the missing thing. Silence on a soft gap is fine.

## 6. Write the CV

Copy `template/cv.html` to the run folder as `cv.html` and change content only:

- photo, name, contact block, layout, fonts, colours, CSS: untouched. Read the notes comment at the top of the template first; it says how pages work and how to make asset paths resolve from the run folder
- title line and summary rewritten for this role
- experience: bullets reselected from the full profile, reordered by relevance to this posting, reworded with the posting's vocabulary where true; job titles, employers and dates never altered
- skills: the ones this posting cares about first, in the posting's wording; drop irrelevant ones; none the profile does not have
- projects, certificates, courses: include those that serve the case
- language of the posting, unless the profile says otherwise
- follow `cv-guidelines.md` for bullets, length and wording

Then, always and without being asked, invoke the humanize skill (`anthropic-skills:humanize`, via the Skill tool) and run all the CV text you wrote or changed through it. Its rewrites may change wording only: facts, numbers, dates, titles and the mirrored posting terms stay. If the skill is not available in this session, apply the "Not sounding machine-written" section of `cv-guidelines.md` by hand and say so in the report.

## 7. Render and verify

`./render.sh applications/<run>/cv.html applications/<run>/<First>_<Last>_CV.pdf`

Then check, fix and re-render until all pass:

1. Read the PDF: looks like the template, photo present, nothing overflowing or cut, no page with only a few lines, page count no higher than the template.
2. Read `cv.txt`: name and contact first, sections in order, columns not interleaved.
3. Go through every line of the CV and find its fact in `profile/profile.md`. Remove or correct anything that has no source or says more than the source.
4. Every core requirement with status met or adjacent is visible on page one or in the first bullets of the relevant job.
5. The humanize pass was run; no banned phrases from `cv-guidelines.md`; no line that could belong to anyone else.
6. Dates, titles and employers identical to the profile. No typos.

## 8. Report in chat

The other files are not for the user, so say what matters here, briefly:

- path to the PDF
- fit: what matches strongly, what is thin, and which gaps are likely to come up in the interview
- what was emphasised and what was cut compared with the base CV
- company in three lines, including any red flag
- pay: market range, what to ask for, benefits to expect, sources
- anything the user must answer themselves on the application form (knockout questions), truthfully
- photo note once if the posting is in the UK, Ireland, US or Canada
- that `/screen` gives an independent screening check of this CV
