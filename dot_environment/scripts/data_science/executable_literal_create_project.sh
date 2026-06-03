#!/usr/bin/env bash
#
# init_ds_project.sh — scaffold a data science project and initialize a uv venv.
#
# Usage:
#   ./init_ds_project.sh [project-name]
#
# If no name is given, defaults to "project-name".

set -euo pipefail

PROJECT="${1:-project-name}"

if [[ -e "$PROJECT" ]]; then
  echo "Error: '$PROJECT' already exists. Aborting." >&2
  exit 1
fi

echo "Creating project '$PROJECT'..."

# --- Directory tree ---------------------------------------------------------
dirs=(
  "data/raw"
  "data/interim"
  "data/processed"
  "data/external"
  "notebooks"
  "src/data"
  "src/features"
  "src/models"
  "src/visualization"
  "scripts"
  "models"
  "reports/figures"
  "tests"
  "config"
  "docs"
)

for d in "${dirs[@]}"; do
  mkdir -p "$PROJECT/$d"
done

# --- Python package markers -------------------------------------------------
touch \
  "$PROJECT/src/__init__.py" \
  "$PROJECT/src/data/__init__.py" \
  "$PROJECT/src/features/__init__.py" \
  "$PROJECT/src/models/__init__.py" \
  "$PROJECT/src/visualization/__init__.py" \
  "$PROJECT/tests/__init__.py"

# --- Keep empty dirs under version control ----------------------------------
for d in data/raw data/interim data/processed data/external \
  notebooks scripts models reports/figures config docs; do
  touch "$PROJECT/$d/.gitkeep"
done

# --- README -----------------------------------------------------------------
cat >"$PROJECT/README.md" <<EOF
# $PROJECT

A data science project.

## Setup

\`\`\`bash
uv sync          # install dependencies into .venv
source .venv/bin/activate
\`\`\`

## Structure

- \`data/\`        raw / interim / processed / external datasets (git-ignored)
- \`notebooks/\`   exploration; import reusable code from \`src/\`
- \`src/\`         importable package (data, features, models, visualization)
- \`scripts/\`     CLI entry points and one-off jobs
- \`models/\`      serialized models (git-ignored)
- \`reports/figures/\` generated charts
- \`tests/\`       unit tests
- \`config/\`      configuration files
EOF

# --- .gitignore -------------------------------------------------------------
cat >"$PROJECT/.gitignore" <<'EOF'
# Data & models (track with DVC / Git LFS / external storage instead)
data/raw/*
data/interim/*
data/processed/*
data/external/*
models/*
!**/.gitkeep

# Python
__pycache__/
*.py[cod]
.ipynb_checkpoints/
.venv/
*.egg-info/
.pytest_cache/

# Secrets / env
.env
*.key

# OS
.DS_Store
EOF

# --- Initialize uv ----------------------------------------------------------
if ! command -v uv >/dev/null 2>&1; then
  echo "Warning: 'uv' not found on PATH. Skipping venv init." >&2
  echo "Install it from https://docs.astral.sh/uv/ then run 'uv init' in $PROJECT." >&2
else
  echo "Initializing uv project..."
  (
    cd "$PROJECT"
    # Create pyproject.toml without overwriting our README/.gitignore.
    uv init --no-readme --no-workspace . >/dev/null 2>&1 || uv init . >/dev/null 2>&1
    # Create the virtual environment.
    uv venv
    # Add common data science dependencies.
    uv add numpy pandas matplotlib scikit-learn jupyter
  )
  echo "Virtual environment created at $PROJECT/.venv"
fi

echo "Done. Next:"
echo "  cd $PROJECT && source .venv/bin/activate"
