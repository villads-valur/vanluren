# Spec Checks

What to look for on the Spec axis, plus the PR description quality check.

## Spec

- Requirements that are missing or only partly done
- Behaviour nobody asked for (scope creep)
- Requirements that look implemented but the implementation looks wrong
- The PR description says something the code doesn't do, or the code does something significant the description doesn't mention
- The test plan doesn't cover the risky parts, or describes steps that can't work with this code

Quote the spec or description line for each Spec finding.

## PR description quality

Judge the description itself, separately from the code:

- **AI slop**: filler and generic phrasing ("This PR introduces a comprehensive solution..."), headings with nothing useful under them, a file-by-file retelling of the diff instead of the why, overclaiming ("robust", "seamless"), em-dash or emoji-heavy lists
- **Unclear**: a reviewer can't tell what changed, why, or how to test it; the important change is buried
- **Jargon**: unexplained acronyms, internal names or buzzwords someone outside the team wouldn't follow

These are observations for me, not comments to post. I decide whether to raise them.
