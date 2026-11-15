# CV guidelines

Distilled from web research on 2026-11-15. Most public material on this topic is vendor blogs; the evidence grade says how far to trust each point. Where sources disagree, the safe option is chosen.

## How screening really works

- An ATS is mostly a database. It parses the CV into fields (name, contact, jobs, dates, skills, education) and a human searches, filters and ranks. Content-based auto-rejection is rare (about 8% of recruiters in the one survey that gets quoted). [weak-medium]
- The real automatic filter is the **knockout questions on the application form**: work authorisation, location, years of experience, licences. These are answered by the user, truthfully, outside the CV. [medium]
- Ranking against the posting is common. A CV at the bottom of the ranking is never opened. So the posting's own terms must appear in the CV, in context, where they are true. [medium]
- "Match scores" from online scanners are word-overlap estimates the employer never sees. Do not optimise for them. [medium]
- Hidden white text and keyword stuffing get the application rejected by the human who opens it. Never. [medium]
- The first human look is a scan of seconds (the "7 seconds" Ladders study is small and old, but the direction holds): name, current title and employer, previous title and employer, dates, education. Page one decides whether page two is read. [weak-medium]

## Parsing safety (the template must pass this)

- Real text layer, standard fonts, no text inside images.
- Contact details in the page body, not in a PDF/Word header or footer.
- Two columns are fine when built with CSS grid/flex and the DOM order is the logical reading order. Columns built from tables or floating text boxes scramble. [vendor tests conflict; this explains the conflict]
- Standard section names: Experience, Education, Skills, Projects, Languages, Certifications.
- Dates in one consistent format, next to each job.
- Skills also as a plain comma-separated list somewhere; skill bars, stars and icons carry no parsable information.
- The photo is ignored by parsers. It costs nothing there.
- PDF and DOCX parse about equally well; layout matters, format does not.
- **Check:** `render.sh` writes `cv.txt`. Read it. Name and contact first, sections in order, no interleaved columns, nothing missing.

## Content

- **Top third of page one answers "is this the person for this role?"** Title line matching the posting's role where truthful, then a 2-3 line summary built from this candidate's real facts for this posting.
- **Bullets:** action + what + result. "Accomplished X, measured by Y, by doing Z." A number where one honestly exists (scale, time, money, users, percentage, team size). No invented metrics; a concrete outcome without a number beats a fake number. [direction solid, the "+40% interviews" figures are vendor claims]
- Most relevant bullets first within each job. Most recent and most relevant jobs get the most space; old or unrelated ones shrink to a line.
- Use the posting's exact words for things the candidate truly has (if the posting says "CI/CD pipelines" and the profile says "build automation with GitLab CI", write "CI/CD pipelines (GitLab CI)"). Mirror vocabulary, never capability.
- Write the term and its abbreviation once: "Amazon Web Services (AWS)".
- Length: no more pages than the original template; two at most unless the field expects more (academia).
- Reverse-chronological. No unexplained gaps longer than about six months; a one-line truthful explanation beats silence.

## Not sounding machine-written

About half of hiring managers say they reject CVs they judge to be AI-written; what they are actually reacting to is generic, unedited boilerplate, since nobody detects AI text reliably. [medium]

- Banned: results-driven, passionate, dynamic, leveraged, spearheaded, synergy, cutting-edge, proven track record, detail-oriented, team player, fast-paced, "responsible for", "utilized".
- No sentence that could sit unchanged in another person's CV. Every line carries a specific: a system, a number, a product, a customer type, a tool.
- Plain verbs: built, ran, cut, moved, fixed, led, wrote, shipped, negotiated.
- Keep the user's own phrasing from the original CV where it is already good.

## Inflated requirements

- Postings are wish lists written by hiring managers. In an analysis of 6,000+ applications (TalentWorks), interview rates rose up to a 50-60% requirement match and were flat above it. [weak-medium, single source]
- So: apply and tailor confidently at roughly half or more of the core requirements. Years of experience, long tool lists and "preferred" items are soft.
- Hard gates are real: licence, legal right to work, required language, security clearance, a degree the law demands, location when stated as non-negotiable. A failed hard gate is told to the user before any CV is written.

## Photo and regional conventions

- The user wants the photo and basic information kept. That is the default, always.
- Photo is normal or expected in German-speaking countries and common across most of continental Europe; discouraged in the UK, Ireland, US and Canada. For a posting in those four, say so once in chat and let the user decide. No sourced data found for Serbia; follow the template.
- CV in the language of the posting unless the user says otherwise.

## Sources

- https://atsverification.com/blog/ats-resume-myths-debunked/
- https://tietalent.com/en/blog/249/the-truth-about-ats-in-2026-5-resume-myths-that-hurt-your-job-search
- https://thetailorcv.com/blog/ats-myths-debunked
- https://www.hrdive.com/news/eye-tracking-study-shows-recruiters-look-at-resumes-for-7-seconds/541582/
- https://hiretop.com/blog/can-ats-read-columns-tables-text-boxes/
- https://resumeatlas.io/ats-resume-parsing-benchmark
- https://enhancv.com/blog/are-two-column-resumes-ats-friendly/
- https://careers.augsburg.edu/resources/crafting-bullet-points-for-your-resume/
- https://www.cnbc.com/2018/12/12/matching-half-of-a-jobs-requirements-might-still-get-you-an-interview.html
- https://qz.com/255565/job-requirements-are-mostly-fiction-and-you-should-ignore-them
- https://resumegenius.com/blog/ai-impact-on-hiring-2026
- https://clickhired.ai/blog/do-recruiters-reject-ai-resumes-2026
- https://www.uni2study.com/articles/cv-conventions-europe-germany-france-uk-spain
- https://hireflow.net/blog/resume-photo-rules-by-country-us-vs-eu-vs-uk
