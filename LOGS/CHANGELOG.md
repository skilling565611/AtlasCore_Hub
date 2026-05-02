# AtlasCore Hub — Changelog

---

## [v1.0] — 2026-05-02

### Added
- Initial repository setup on `Dev` branch
- `.gitignore` with OS, editor, log, and build exclusions
- `README.md` at repo root
- `MD/` folder for documentation files (Control Prime)
- `MD/ArcticPrime_Specs.md` — Arctic Prime device specs
- `MD/ControlPrime_Specs.md` — Control Prime device specs
- `PIX/` folder for phone-side voice/text input (PIX device)
- `.github/agents/atlascore-dev.agent.md` — AtlasCore Dev custom agent
- `APP/main.py` — App entry point
- `APP/hub.py` — Main hub GUI (tkinter, 4-panel layout)
- `APP/launch_hub_source.bat` — Launch menu for Python source only; reads future EXE settings from JSON with packaging disabled
- `APP/exe_config.json` — Future EXE configuration settings (prepared, disabled)
- `LOGS/CHANGELOG.md` — this file

### Updated
- `APP/launch_hub_source.bat` — Exit moved to option `0`; EXE settings are loaded as active support and build policy now states explicit-request-only (no auto-build)
- `APP/exe_config.json` — EXE support/settings remain active and fully configured; explicit-request build policy added
- `.github/agents/atlascore-dev.agent.md` — Added persistent rules for Exit option `0`, always-on EXE support, and explicit-request-only EXE builds

### Notes
- Git user name set to **Arctic Prime**
- App built with Python + tkinter (no external dependencies)
- Version 1.0 baseline established
