---
applyTo: "**/*.{rs,toml}"
---
# Rust Architectural & Tool Standards

## 1. Tool Calling Logic (@terminal)
- **Validation Order:** Before any commit or after significant changes, execute:
  1. `cargo clippy --all-targets --all-features -- -D warnings` (Zero-warning tolerance).
  2. `cargo fmt --all -- --check` (If it fails, run `cargo fmt --all`).
  3. `cargo test --verbose`.
- **Performance:** For testing execution speed or complex logic, prefer `cargo build --release` to ensure optimizations are applied.

## 2. Library-First Architecture (Mandatory)
- **Core Principle:** Logic must be decoupled from the interface. The binary (`src/main.rs`) is a "Thin Wrapper" for environment setup and argument parsing only.
- **Shared Logic:** All functions, processing, analysis, and data structures MUST reside in library code (`src/lib.rs` or sub-modules).
- **Scalability:**
  - **Modules:** Use sub-modules (e.g., `src/analysis/mod.rs`) for logical separation within a single crate.
  - **Workspaces:** For large projects, use **Cargo Workspaces**. Extract independent logic into separate crates within the workspace (e.g., `./crates/core`, `./crates/analysis`) to maximize reusability.
- **Rule:** If a function can be tested without a CLI context, it belongs in a library.

## 3. Idiomatic Standards
- **Error Handling:** - Library: Use `thiserror` for defined, structured error types.
  - Binary: Use `anyhow` for high-level context and error propagation.
- **Documentation:** Use `///` for all public library functions. Documentation must describe the purpose, inputs, and outputs.
- **Safety:** Minimize `unsafe` blocks. If `unsafe` is required, it must be accompanied by a `// SAFETY:` comment explaining why the invariant is upheld.

## 4. Environment
- **Temporary Files:** Use `_temp.rs` for non-source test files to keep them out of standard build paths.
- **Tags:** Use text-only tags for status: [OK], [WARN], [ERROR], [PASS], [FAIL].