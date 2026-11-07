# Smell Baseline

Fowler code smells (_Refactoring_, ch. 3) that apply even when a repo documents nothing. Always judgement calls ("possible Feature Envy"); a documented repo standard overrides them.

- **Mysterious Name**: name doesn't reveal what it does or holds → rename; if no honest name comes, the design is murky
- **Duplicated Code**: same logic shape in several hunks or files → extract the shared shape
- **Feature Envy**: function reaches into another object's data more than its own → move it to that data
- **Data Clumps**: the same fields/params keep travelling together → bundle them into one type
- **Primitive Obsession**: a string/number standing in for a domain concept → give it its own small type
- **Repeated Switches**: same `switch`/`if` cascade on the same type in several places → one shared map or polymorphism
- **Shotgun Surgery**: one logical change forces scattered edits → gather what changes together
- **Divergent Change**: one module edited for several unrelated reasons → split by reason to change
- **Speculative Generality**: abstraction, params or hooks the spec doesn't need → inline until a real need shows
- **Message Chains**: long `a.b().c().d()` navigation → hide the walk behind one function
- **Middle Man**: function/class that mostly delegates → call the real target directly
