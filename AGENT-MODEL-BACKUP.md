# Backup: Agent Model Assignments (Removed from .agent.md files)

This file preserves the original model assignments removed from *.agent.md files.
Purpose: Reference for future extension development to perform automatic model switching.

---

## Agent Model Mappings

| Agent Name | Model |
|------------|-------|
| GPT-4.1 Implementation Agent | gpt-4.1 |
| GPT-4.1 Research Agent | gpt-4.1 |
| Claude Haiku 4.5 Implementation Agent | claude-haiku-4.5 |
| Raptor Mini Implementation Agent | raptor-mini |
| Sonnet 4.6 Implementation Agent | sonnet-4.6 |
| Sonnet 4.6 Technical Agent | sonnet-4.6 |

---

## Notes for Future Extension Development

- Each agent was originally assigned a specific model in its front matter via `model:` YAML field
- VS Code Copilot Chat does not expose an API to programmatically switch the GUI model selector
- Future extension could use these mappings to:
  1. Detect agent selection via chat commands (e.g., `/agent sonnet46-implementation`)
  2. Suggest or prompt user to switch model in GUI
  3. Explore undocumented VS Code Copilot APIs for model switching
  4. Develop custom UI overlay or command for seamless switching

---

## Original File Locations

- `/home/ndronet/.config/Code/User/prompts/gpt41-implementation.agent.md`
- `/home/ndronet/.config/Code/User/prompts/gpt41-research.agent.md`
- `/home/ndronet/.config/Code/User/prompts/haiku45-implementation.agent.md`
- `/home/ndronet/.config/Code/User/prompts/raptor-implementation.agent.md`
- `/home/ndronet/.config/Code/User/prompts/sonnet46-implementation.agent.md`
- `/home/ndronet/.config/Code/User/prompts/sonnet46-research.agent.md`
