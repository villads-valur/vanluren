# Smell Baseline

Code smells from Martin Fowler's _Refactoring_ (chapter 3). Use them even in repos with no written standards. Report a smell as "possible ...", never as a hard rule, and let the repo's own standards win when they disagree.

- **Mysterious Name**: you can't tell from the name what a variable, function or type is for. Suggest a clearer name; if none fits, the code is probably doing too much
- **Duplicated Code**: the same logic appears more than once in the change. Pull it into one place both can call
- **Feature Envy**: a function works mostly with another module's data. Move it next to that data
- **Data Clumps**: the same group of values gets passed around together. Turn them into one type
- **Primitive Obsession**: a plain string or number stands in for something with real meaning (an ID, a status, money). Give it a dedicated type
- **Repeated Switches**: the same `switch` or `if` chain on one value shows up in several places. Use a single lookup or move the behaviour onto the type
- **Shotgun Surgery**: one change needs small edits in lots of files. Keep things that change together in one place
- **Divergent Change**: one file keeps changing for unrelated reasons. Split it so each part has one reason to change
- **Speculative Generality**: options, parameters or abstractions added for needs nobody has yet. Remove them until there's a real need
- **Message Chains**: code digs through objects (`a.b().c().d()`). Give the first object a method that does the lookup
- **Middle Man**: a function or class that just passes calls along. Call the real target directly
