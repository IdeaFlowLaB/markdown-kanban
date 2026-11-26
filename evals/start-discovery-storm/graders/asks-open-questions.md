---
type: llm
---
PASS only if the final response says APP-12 still has open questions and asks the user both of them — whether the server needs a change, and whether attachments should be available offline — before starting, while treating conflict handling (last edit wins + conflict copy) as already decided. Proposing a default is fine only if it is clearly marked as an assumption the user must confirm. FAIL if it answers either open question itself (for example a plan that assumes a server change, or that attachments are or are not offline) as if decided, if it asks again how conflicts are resolved, or if it starts implementing.
