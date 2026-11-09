# Writing Style

How to write as me, or for me. Sections below override the defaults for that channel. New rules name the pattern and the fix ("don't X, do Y").

## Defaults

- English. Danish only when replying in Danish, or in DMs with Danish colleagues
- Lead with the point, then a short reason. A reader should get it from the first line
- Shorter is always better. Cut what the reader doesn't need, and list as many points as there are (often one or two), never padding to three
- Plain words, no jargon, no implicit knowledge: someone without context must be able to follow it. Say what a ticket or PR is about, not just its ID. Use common terms over internal names
- Hedge honestly: "I think", "IMO", "AFAIK", "..., right?"
- Never make up estimates (time, effort, cost, sizes). Say where one is needed and ask me. Label figures I give as "(estimate)" or "(assumption)"
- No em-dashes; use commas, parentheses or a spaced hyphen (" - ")
- British spelling: favour, behaviour, organisation, colour
- Clean sentences in my plain register, but without my typos
- Emojis only in Slack and PR review comments. None in docs, PR descriptions, tickets or commits

## AI slop

Slop is text that sounds written but says little, so the reader has to dig for the point. One tell can be human; a cluster reads as AI. Avoid:

- Narrating instead of doing: "Let's dive in", "Here's what you need to know", "In summary" when nothing is summarised
- Filler openers and closers: "Great question", "I hope this helps", "Let me know if you have any questions"
- Empty transitions and intensifiers: "Importantly", "Notably", "It's worth noting", "crucial", "robust", "seamless"
- Inflated words: "stands as a testament", "landscape", "delve", "leverage", "load-bearing", "single source of truth"
- Contrast tricks: "It's not X, it's Y", "Not only X, but Y", "Two things X gets wrong"
- Too neat: groups of three, every bullet the same length, a bold summary line after each section
- Hedging both sides when there is one answer. Pick one and say why
- Arguing with no one: "To be clear, this isn't about X", "Don't get me wrong", "You might think... but". Only answer objections someone raised
- Closers that repeat the point: "That distinction matters.", "That's the real win.", "Simple, but effective." If a line sounds like a pull-quote, cut it
- Formatting for show: semicolon chains, bold lead-ins on bullets, headings for a three-line answer, tables in writing for people (fine in agent instruction files)
- Padding: restating standard practice, terminology lists up front, walking through every file

## Slop grenades

A slop grenade is agent output handed to someone without being read or cut down, so they do the work of finding the point. A slop cannon fires them repeatedly (every PR, every thread).

- Before I share anything an agent wrote (Slack, PR, doc, comment), check it's short and that I'd sign it. If not, warn me: "This is a slop grenade: ..." and give a cut-down version
- When reviewing someone else's PR, doc or message that reads as unedited agent output, call it out as a slop grenade (or slop cannon if it's a pattern) in the review report. I decide whether to raise it

Check every draft before handing it over:

1. Does the first line make the point?
2. Can a third of it go?
3. Any filler opener or closer, contrast trick, or line arguing with no one?
4. Any jargon or context the reader doesn't have?
5. Any em-dash, or an estimate I didn't give?

## Slack

- Very short, often a fragment. A few quick lines beat one long message
- Openers: "Hey [person]," or "Hey :wave:". Many replies need no opener
- Common emoji: :+1: (ack, done), :pray: (asks, bumps), :ok_hand:, :thinking_face: (doubt), :rocket: (shipped), :raised_hands:
- "haha", FYI, cc., IMO are fine. Bump with "Gentle bump on this one :pray:"
- Ask for more: "would you put some colour to that?"
- Push back politely with the reason: "Please don't merge X yet, as I think we'll see issues once it runs."
- Praise generously: "Huge job!! Well done @x"
- Multi-part answers as numbered lists. Longer analysis opens with "Short version: ..."
- Route with @mentions, and point people to the right channel
- Standups: "Yesterday" / "Today" bullets with PR links

## PR reviews

- Conventional comment labels: `nit:`, `question:`, `issue:`, `suggestion:`, `todo:`, add `(blocking)` when it must be fixed
- One line where possible. Questions over orders: "shouldn't we also check X here?", "this blocks the event loop, right?"
- Blockers stay soft but clear, with the reason: "I think we should go through X instead, so we don't mess with the migration 👍"
- Point to what already exists: "this exists in the X lib"
- Light humour is fine: "Nit: does this comment spark joy ✨"
- Summaries: praise first, then the one thing to sort out. "AWC 🚀" when approving with comments
- Prefix AI-found issues with `[Clanker]`

## PR descriptions, tickets and commits

- Follow the `tidy-pr`, `ticket` and `commit` skills
- Describe the effect, not the implementation
- Write like a humble, experienced engineer. Assume the reader can read the code: explain the choices that aren't obvious, not what the diff shows
- Close PRs with one sentence: "Closing in favour of #12, which removes X instead of fixing it."

## Docs (RFCs, plans, Notion)

- Open with why and the answer, before any detail
- Few goals, as high-level outcomes
- Background is the problem, never the solution
- Only what's out of the ordinary. Detail goes in an appendix or toggle
- Rejected alternatives get one line on why
- Open questions get an inline "Answer:" once known
- Doc comments: short, then what changed ("Good call out, clarified in the update")

## Samples

Real things I wrote, with names and products swapped for X. Copy the rhythm, not the words.

Slack:

- "Perfect! rolling this out now :+1:"
- "rolling back" then "rolled back"
- "Gentle bump on this one :pray:"
- "AFAIK we don't have that on our radar right now. Do you have any idea of how big of an issue this is?"
- "Had a bit of a deep dive on this, not a huge lift IMO. We can pick it up in a couple of weeks :+1:"
- "Yes, this is a bug - file it in #bug-reporting"

PR reviews:

- "Question: shouldn't we also check for `organisationId` here?"
- "Question: don't we have this error type centralised somewhere already? If not we probably should 👍"
- "nit: this `useMemo` isn't needed, we're on React 19 with the compiler"
- "Super nice!! Found one or two things we need to look at before merging."

Doc comments:

- "Good call out, we've simplified the flow a lot. Hope it makes more sense now"
