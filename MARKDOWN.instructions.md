---
description: 'Standard guidelines for creating and maintaining Markdown documentation, including TOC generation and documentation brevity.'
name: MARKDOWN instructions
applyTo: '**/*.md'
---
# Copilot Instruction: Markdown Documentation Standards

### **A. General Documentation Principles**

 - **Brevity and Minimization:** **Do not create superfluous quantities of new documentation.** Attempt to keep documentation to a minimum, focusing on essential information and avoiding redundant files or overly verbose explanations.
 - **TOC Requirement:** **When documentation has 5 or more sections (headers), always maintain a Table of Contents (TOC)** at the top of the document to improve navigation and readability.
 - **Emoji/Icons Usage:** Emoji and icons are allowed only when they enhance clarity or effectiveness of information (e.g., checkmarks, X marks, eraser/delete). Use sparingly and only when they add value. Avoid decorative or excessive emoji/icons.

---

### **B. Table of Contents (TOC) Linking Instruction**

When generating a Table of Contents (TOC), follow these steps to create correct internal anchor links:

1.  **Header-to-Anchor Conversion:** Convert the header text to **all lowercase** and replace all spaces with **hyphens** (`-`) to generate the unique anchor ID.
2.  **Link Format:** Use the Markdown link syntax: `[Header Text](#anchor-id)`. The anchor ID **must** be prefixed with a hash symbol (`#`).

#### **TOC Example**

```markdown
## Table of Contents
- [Introduction](#introduction)
- [Project Setup](#project-setup)
- [API Usage](#api-usage)
- [Troubleshooting](#troubleshooting)

## Introduction
Content for Introduction...
```

### **C. Numbering & Reference Style**

 - **Avoid `#XXXX`** for local documentation numbering (it looks like GitHub issue references).
 - For local lists, use **`No. 1`**, **`Number 1`**, **`Issue A`**, or **`Item # 1`** (with spacing).
 - Use `#1234` only when referencing an actual GitHub issue or PR.
