# Plan: publish 2.5e at dsatcl.jeroenjanssens.com

Status: **plan only — nothing implemented yet** (2026-11-09).

Goal: the Quarto edition (`book/2.5e/_book`) replaces the 2e website. It's
served by **GitHub Pages** at **https://dsatcl.jeroenjanssens.com**, set up
with `jj-com/scripts/add-subdomain` like rush, quarto-term, and raylibr. Every
old URL redirects to the matching page in **one** 301 hop.

## 1. Current situation (checked 2026-11-09)

| What | Where | Notes |
|---|---|---|
| jeroenjanssens.com | **Cloudflare Pages** project `jeroenjanssens`, deploys on push to `jj-com` `main` | `jj-com/netlify.toml` is a leftover; DNS on Cloudflare |
| jeroenjanssens.com/dsatcl/ | `jj-com/misc/dsatcl/` (9.7 MB copy of the 2e output, incl. `*.htmlbak`), copied by `.eleventy.js` (`addPassthroughCopy`) | Hand-edited (f14941d), so it has drifted from the source |
| datascienceatthecommandline.com | A **Netlify** site, DNS at Netlify (NS1), deployed by hand (`make publish-production` → `netlify deploy --prod --dir www/_site`) | Serves a 2021 landing page at `/` and `/2e/data.zip`; redirects `/1e/*` → `/2e/*` and `/2e/*` → `jeroenjanssens.com/dsatcl/:splat`. The live `_redirects` is **not** the one in `www/src/_redirects` (that one is from 2021) |
| `data.zip` | Only at `datascienceatthecommandline.com/2e/data.zip` | 43 files: `book/2e/data/ch*/*`. The 2.5e chapter data is byte-identical |
| Slides `50-reasons.pdf` | Only in `jj-com/misc/dsatcl/resources/` | Chapter 1 links to `datascienceatthecommandline.com/resources/50-reasons.pdf`, which is a 404 today |
| GitHub Pages for this repo | Not enabled | Default branch `master`; repo homepage still `https://datascienceatthecommandline.com` |
| Cloudflare token (`jj-com/scripts/secrets.enc.yaml`) | DNS edit for jeroenjanssens.com only | Enough for `add-subdomain` |
| Netlify CLI | Not installed here, not logged in | Needed only for the old domain (step 11) |

Old URLs vs the new book: every page and image of the old copy exists in
`book/2.5e/_book` under the same name. Missing are only bookdown assets
(`libs/`, `dsatcl2e.css`, `reference-keys.txt`), which nothing links to, and
`resources/50-reasons.pdf` (fixed in step 2). In-page anchors carry over,
except chapter 7's figure IDs (`#fig:…` → `#fig-…`).

Cloudflare Pages notes for `jj-com/src/_redirects`: path rules work (also with
Netlify's `!`, which Pages ignores); rules for a whole domain don't
(`https://jeroenjanssens.pages.dev/*` and the `.nl` rules have no effect
today). That's a separate issue; it doesn't affect this move.

## 2. Target

```
dsatcl.jeroenjanssens.com           GitHub Pages (Actions), book/2.5e/_book + data.zip
  ▲                    ▲
  │ 301 (Cloudflare    │ 301 (Netlify _redirects)
  │ Pages _redirects)  │
jeroenjanssens.com/dsatcl/*         datascienceatthecommandline.com/*
```

## 3. Steps

### Phase 1: this repo (on `2-5e`, then merge into `master`)

1. **`site-url`.** In `book/2.5e/_quarto.yml`, under `book:`: `site-url: https://dsatcl.jeroenjanssens.com`
   (canonical links, Open Graph URLs, sitemap). `repo-branch: master` stays.
2. **Slides.** Copy `jj-com/misc/dsatcl/resources/50-reasons.pdf` to
   `book/2.5e/resources/50-reasons.pdf`, list it under `project: resources:`, and
   link it relatively from chapter 1 (`resources/50-reasons.pdf`).
3. **Links in the book and README to the new home.**
   - `chapter-2-getting-started.qmd:28`: `https://dsatcl.jeroenjanssens.com/data.zip`
   - `chapter-11-conclusion.qmd:138`: `https://dsatcl.jeroenjanssens.com/`
   - `README.md` (lines 5, 6, 10): the new URL; the cover image moves to
     `book/2.5e/images/` (or the repo) instead of `datascienceatthecommandline.com/static/…`
4. **Publish workflow** `.github/workflows/publish-book.yml` (modelled on
   quarto-term's `publish-docs.yml`):
   - on push to `master` touching `book/2.5e/_book/**`, `book/2.5e/data/ch*/**`,
     or the workflow; plus `workflow_dispatch`;
   - no rendering in CI (it needs Docker and ~6 minutes; `_book` is tracked):
     copy `book/2.5e/_book` to `site/`, then
     `cd book/2.5e/data && zip -qrX ../../../site/data.zip ch*` (no `.cache`);
   - `actions/upload-pages-artifact` + `actions/deploy-pages`;
   - `permissions: pages: write, id-token: write`; `concurrency: pages`.
   `data.zip` is built in CI, so it isn't tracked and doesn't churn `_book`.
5. **Render, compare, commit** (`make render compare` in `book/2.5e`), then
   **merge `2-5e` into `master` and push**. Nothing is public yet: Pages isn't
   enabled.

### Phase 2: GitHub Pages and the subdomain

6. **Enable Pages** with Actions as the source:
   `gh api -X POST repos/jeroenjanssens/data-science-at-the-command-line/pages -f build_type=workflow`,
   then run the workflow (`gh workflow run publish-book.yml`).
7. **Check the default URL**
   `https://jeroenjanssens.github.io/data-science-at-the-command-line/`
   returns 200. (`add-subdomain` checks this, and that no page links to
   `/data-science-at-the-command-line/` paths; Quarto uses relative links.)
8. **Add the subdomain**:
   `cd ../jj-com && scripts/add-subdomain data-science-at-the-command-line dsatcl`.
   It creates the DNS-only CNAME `dsatcl` → `jeroenjanssens.github.io`, sets the
   custom domain, waits for the certificate and enforces HTTPS, and sets the
   repo's homepage to `https://dsatcl.jeroenjanssens.com/`.
9. **Verify the new site** (`bin/check-site.sh`, new): every page with and
   without `.html`, `/data.zip` (43 files), `/resources/50-reasons.pdf`, a
   missing page gives the book's `404.html`, search works, HTTPS only.

### Phase 3: redirects (only after the new site works)

10. **jeroenjanssens.com** (jj-com, deploys on push to `main`):
    - `src/_redirects`:
      ```
      /dsatcl     https://dsatcl.jeroenjanssens.com/          301
      /dsatcl/*   https://dsatcl.jeroenjanssens.com/:splat    301
      ```
    - in the same commit: remove `misc/dsatcl/` and its `addPassthroughCopy`
      line in `.eleventy.js`, so no static file can shadow a rule;
    - update jj-com's links to the book (`src/pages/home.md`, `public.md`,
      `books.md`, `os.md`, `src/dynamic/posts/pp.md`, `datascienceweekly.md`,
      `ibash.md`, `machine.md`) to `https://dsatcl.jeroenjanssens.com/…`; the
      two deep links (`#performing-sql-queries-on-csv`,
      `#acknowledgments-for-the-second-edition-2021`) exist in 2.5e.
11. **datascienceatthecommandline.com** (Netlify): replace the site's contents
    with only a `_redirects` file, in this order (first match wins):
    ```
    /2e/data.zip                 https://dsatcl.jeroenjanssens.com/data.zip   301!
    /resources/*                 https://dsatcl.jeroenjanssens.com/resources/:splat   301!
    # 1e chapter names (from www/src/_redirects), with and without /1e/
    /1e/chapter-4-creating-reusable-command-line-tools.html  https://dsatcl.jeroenjanssens.com/chapter-4-creating-command-line-tools   301!
    /1e/chapter-6-managing-your-data-workflow.html           https://dsatcl.jeroenjanssens.com/chapter-6-project-management-with-make 301!
    /1e/chapter-10-conclusion.html                           https://dsatcl.jeroenjanssens.com/chapter-11-conclusion                  301!
    /chapter-4-creating-reusable-command-line-tools.html     https://dsatcl.jeroenjanssens.com/chapter-4-creating-command-line-tools   301!
    /chapter-6-managing-your-data-workflow.html              https://dsatcl.jeroenjanssens.com/chapter-6-project-management-with-make 301!
    /chapter-10-conclusion.html                              https://dsatcl.jeroenjanssens.com/chapter-11-conclusion                  301!
    /1e/:page                    https://dsatcl.jeroenjanssens.com/:page      301!
    /2e/*                        https://dsatcl.jeroenjanssens.com/:splat     301!
    /*                           https://dsatcl.jeroenjanssens.com/:splat     301!
    ```
    (`/1e/:page` and the root catch-all keep the other chapter names, which are
    the same in 1e and 2.5e; anything unknown ends at the new site's 404.)
    Keep it as `www/_redirects` in this repo and deploy with
    `npx netlify-cli deploy --prod --dir www --site <site id>`, after
    `! npx netlify-cli login` (you) and `netlify sites:list` to find the site.
    `www/src` (the 2021 Eleventy site) and the `build-www`/`publish-*` Makefile
    targets go.
12. **Check every redirect** (`bin/check-redirects.sh`, new): a table of old URLs
    and the expected final URL, each in **one** hop: both domains, `/`,
    `/dsatcl`, `/dsatcl/`, chapters with and without `.html`, `/1e/…` names,
    `/2e/data.zip`, `/resources/50-reasons.pdf`, an image, a query string.

### Phase 4: tidy up

13. Remove `PLAN-deploy.md`'s "plan only" status; note the result in `PLAN-2-5e.md`.
14. Optional: Google Search Console change of address for the old domain.
15. Optional, separate: the `.nl` and `pages.dev` domain rules in jj-com don't
    work on Cloudflare Pages; a Cloudflare redirect rule would (needs a token
    with redirect-rule permission).

## 4. Order, risks, and rollback

- **Order matters:** the new site (phase 2) must work before any redirect
  (phase 3) points to it. Between phases, the old URLs keep working as now.
- **jj-com's `/dsatcl/*` rule and the copied files** change in one commit, so
  there's no moment with both or neither.
- **HTTPS certificate** can take a while or get stuck; `add-subdomain` retries.
  Until it's issued, don't switch redirects.
- **Caching:** Cloudflare and browsers may cache the old pages or the 301s;
  301s are cached long by browsers, so test with `curl` first.
- **Rollback:** each step is a reversible commit or setting: revert jj-com's
  commit (restores `/dsatcl/`), redeploy the old Netlify site from its last
  deploy in the Netlify UI, remove the DNS record / disable Pages.

## 5. Needs you

- Merging `2-5e` into `master` (step 5) makes the new book the default branch.
- `! npx netlify-cli login` for step 11, or deploy the `_redirects` folder in
  the Netlify UI yourself.
- Optional: Search Console (step 14).
