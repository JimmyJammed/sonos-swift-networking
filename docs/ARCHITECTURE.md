# Architecture

Endpoints builds typed requests; Models encodes and decodes API data; Transport owns HTTP behavior. There are no external dependencies. Sonos SDK composes these primitives with authentication and UI state.

61 Control API factories and 66 object models were derived from the official reference retrieved on 2026-09-14. ENDPOINTS links each source. Cloud Queue hosting, SMAPI, and secret-bearing OAuth exchange are separate responsibilities.
