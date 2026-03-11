
## 2024-05-19 - Avoid String Parsing in Render Loop
**Learning:** Found a performance anti-pattern where a formatted string (`percentText`) was being parsed back to a `double` during the build method's `_avgProgress` calculation on every frame.
**Action:** Always pre-calculate derived numeric metrics during the data mapping phase (`fromApi()`) rather than recomputing or re-parsing data inside the Flutter widget build path to reduce UI thread load and GC pressure.
