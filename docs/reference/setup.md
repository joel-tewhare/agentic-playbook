## Setup

Short notes for common setup patterns and repeatable project workflows.

## Local Git Setup (project created locally, not cloned)

Use this when starting a project from a local folder (no existing Git history).

1. Initialise repo
   git init

2. Add .gitignore before first commit
   - ignore: node_modules, .next, .env.local

3. If build files were already tracked:
   git rm -r --cached .next

4. Create baseline commit
   git add -A
   git commit -m "chore: initial project setup"

5. Create working branch
   git checkout -b <feature-branch>

Mental model:

- main = clean baseline
- feature branch = active work
