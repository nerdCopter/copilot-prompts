mode: 'agent'
description: 'Assist with PowerShell scripts and general Microsoft/Windows technologies. Performs cmdlet lookups via Microsoft Docs MCP server and validates solutions against PowerShell guidelines. Can be invoked manually for general Windows information queries without file context.'
applyTo: '**/*.ps1,**/*.psm1,**/*.psd1'
mcp_server: 'microsoft-learn'
mcp_url: 'https://learn.microsoft.com/api/mcp'
install_url: 'https://vscode.dev/redirect/mcp/install?name=microsoft-learn&config=%7B%22type%22%3A%22http%22%2C%22url%22%3A%22https%3A%2F%2Flearn.microsoft.com%2Fapi%2Fmcp%22%7D'
when_to_use: 'Windows Server, PowerShell, Hyper-V, Failover Clustering, MPIO, iSCSI research and cmdlet validation'

steps:
  - Perform cmdlet failure searches against Microsoft Docs using the MCP server.
  - Validate any solutions against the PowerShell Project Guidelines.
  - Ensure responses are concise, citing official sources where applicable.
  - Maintain strict adherence to formatting rules defined in the project guidelines.
  - Validate scripts using syntax validation commands provided in the guidelines.

tools:
  - **microsoft_docs_search** — Search Microsoft technical documentation by query
  - **microsoft_docs_fetch** — Fetch and convert a specific documentation page to markdown
  - **microsoft_code_sample_search** — Find official Microsoft code examples and snippets
