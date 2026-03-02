# Git Workflow and Branching Strategy

## Overview Of Git Workflow Strategy

This project implements the Git Flow branching model to support development with a clear separation between ongoing development, preparations for releases, production-ready code, and emergency production fixes.

The model includes two long-lived branches:

    - `main` — represents stable, production-ready code.

    - `develop` — represents the integration branch for completed features.

The other branches involved in the worfklow are temporary: `feature/*`, `release/*`, and `hotfix/*`.

Together, these branches support structured development, controlled releases, and production stability across Development, Staging, and Production environments.

## When And How Each Branch Should Be Used

### `main`

**Purpose:**
- Represents production-ready code
- Must always be stable and deployable

**Rules:**
- No direct commits allowed
- The main branch is updated only through:
  - `release/*` branches
  - `hotfix/*` branches

**Environment:**
Production

---

### `develop`

**Purpose:**
- Integration branch for completed features
- Pulls together feature work before getting ready for a release

**Rules:**
- No direct commits allowed
- Updated only through:
  - `feature/*` branches
  - Merges from `release/*`
  - Merges from `hotfix/*`

**Environment:**
Development

---

### `feature/*`

**Purpose:**
- Used for developing new features

**Lifecycle:**
1. Branch from `develop`
2. Implement feature
3. Open pull request into `develop`
4. Merge after review
5. Delete branch

**Environment:**
Development (before dev integration)

---

### `release/*`

**Purpose:**
- Used to prepare a production release
- A space to clean up documents, make version bumps, fix minor bugs, and make adjustments to configurations. Importantly, this is not a place to add new features!


**Lifecycle:**
1. Branch from `develop`
2. Apply release-related changes
3. Merge into `main`
4. Merge back into `develop`
5. Delete branch

**Environment:**
Staging (before prod integration)

---

### `hotfix/*`

**Purpose:**
- Used for urgent production fixes

**Lifecycle:**
1. Branch from `main`
2. Implement fix
3. Merge into `main`
4. Merge into `develop`
5. Delete branch

**Environment:**
Production

---
## How Branches Interact With Each Other

Below is a graph that visualizes the interactions between branch types:

```
feature/* → develop → release/* → main
↘
develop

hotfix/* → main
↘
develop
```

Key Interaction Rules:
- Features must always merge into `develop` first
- Production releases must go through a `release/*` branch
- Emergency fixes originate from `main` (they happen in production!)
- All production changes must be merged back into `develop` to ensure consistency
- Temporary branches are deleted after successful merges

## Explanation Of Design Decisions

The Git Flow branching model makes sense for this project because we are working with multiple environments (Dev, Staging, and Production). 

This workflow ensures production stability, traceable history, controlled release cycles, and a clear separation of responsibilities. 

Each branch maps to a deployment environment (this is strategic):
| Branch                    | Environment |
| ------------------------- | ----------- |
| feature/*                 | Build       |
| develop                   | Dev         |
| release/*                 | Staging     |
| main                      | Production  |

### Branch Protection Rules

To prevent accidental production changes, I configured branch protection rules for `main` and `develop`.

Because the `main` branch represents production-ready code, it is important that there are strict controls on it. Therefore, I configured rules to ensure that direct pushes to `main` are disabled, and all changes must be introduced through pull requests. Additionally, I disabled force pushes and branch deletion to make sure commit histories are preserved. Finally, I require at least one approval before merging. 

I also configured rules for the `develop` branch. I disabled direct pushes, and require pull requests for all merges. I also disabled force pushes and branch deletion. Unlike `main`, I do not require approval before merging. 

### Decision to use manual Git Flow instead of git flow init

Through my research, I learned that there was a Git Flow CLI extension that could be used to quickly implement this workflow. However, I chose to implement this branching strategy manually becasue I wanted to ensure that I had a full understanding of the underlying Git operations at work. Additionally, I didn't want to obscure transparency when it came to branch creation and merging. 