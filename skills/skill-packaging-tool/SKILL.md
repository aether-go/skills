---
name: skill-packaging-tool
description: Use when packaging skills into distributable installable packages with version management and dependency declarations
---

# Skill Packaging Tool

## Overview
Package skills into distributable installable packages (zip/tar) with version management, dependency declarations, and installation scripts. Enables skill sharing and distribution.

## When to Use

```
Ready to distribute skill? ──────────────┐
                                        │
Need version management? ────────────────┤
                                        ├─► Use skill-packaging-tool
Sharing skills with team? ──────────────┤
                                        │
Publishing to skill marketplace? ─────────┘
```

Use when:
- Distributing skills to others
- Publishing to marketplace
- Creating skill releases
- Managing skill versions
- Setting up skill registry
- Creating skill bundles

Don't use when:
- Editing skill locally
- Using skill in conversation
- Simple file sharing

## Core Pattern

### Skill Package Structure

```
skill-name-v1.0.0/
├── skill.yaml                    # Package metadata
├── SKILL.md                      # Main skill file
├── supporting-files/              # Additional resources
│   ├── examples/
│   │   └── example-usage.md
│   ├── templates/
│   │   └── template.txt
│   └── tests/
│       └── test-skill.md
├── docs/                         # Documentation
│   ├── README.md
│   ├── CHANGELOG.md
│   └── CONTRIBUTING.md
├── install.sh                    # Installation script
└── manifest.json                 # Skill manifest
```

### Package Manifest (skill.yaml)

```yaml
name: "bdd-scenario-writer"
version: "1.0.0"
description: "Convert user stories into Gherkin BDD scenarios"

author:
  name: "Aether Go Team"
  email: "team@aether-go.com"

license: "MIT"
repository: "https://github.com/aether-go/skills"

keywords:
  - "bdd"
  - "testing"
  - "gherkin"
  - "scenarios"

category: "testing"

dependencies:
  - name: "spec-parser"
    version: ">=1.0.0"
  - name: "test-driven-development"
    version: ">=2.0.0"

compatibility:
  opencode: ">=1.0.0"
  claude-code: ">=0.5.0"

files:
  - "SKILL.md"
  - "supporting-files/examples/"
  - "docs/"

checksum: "sha256:abc123..."
```

## Implementation

### Package Creation

```python
import os
import tarfile
import hashlib
import yaml

def create_skill_package(skill_dir, output_dir):
    """Create skill package from skill directory."""

    # Load manifest
    manifest_path = os.path.join(skill_dir, 'skill.yaml')
    with open(manifest_path) as f:
        manifest = yaml.safe_load(f)

    # Create package filename
    package_name = f"{manifest['name']}-v{manifest['version']}.tar.gz"
    package_path = os.path.join(output_dir, package_name)

    # Create archive
    with tarfile.open(package_path, 'w:gz') as tar:
        for root, dirs, files in os.walk(skill_dir):
            for file in files:
                file_path = os.path.join(root, file)
                arcname = os.path.relpath(file_path, skill_dir)
                tar.add(file_path, arcname=arcname)

    # Calculate checksum
    checksum = calculate_checksum(package_path)

    # Update manifest
    manifest['checksum'] = checksum
    with open(manifest_path, 'w') as f:
        yaml.dump(manifest, f)

    print(f"✅ Package created: {package_path}")
    return package_path

def calculate_checksum(file_path):
    """Calculate SHA256 checksum of file."""

    sha256 = hashlib.sha256()
    with open(file_path, 'rb') as f:
        for block in iter(lambda: f.read(4096), b''):
            sha256.update(block)

    return f"sha256:{sha256.hexdigest()}"
```

### Installation Script (install.sh)

```bash
#!/bin/bash

# Skill Installation Script

set -e

SKILL_NAME="bdd-scenario-writer"
VERSION="1.0.0"
INSTALL_DIR="$HOME/.config/opencode/skill"

# Check if skill already installed
if [ -d "$INSTALL_DIR/$SKILL_NAME" ]; then
    echo "⚠️  Skill $SKILL_NAME already installed"
    read -p "Overwrite? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Installation cancelled"
        exit 0
    fi
    rm -rf "$INSTALL_DIR/$SKILL_NAME"
fi

# Extract package
echo "📦 Extracting $SKILL_NAME-v$VERSION.tar.gz..."
tar -xzf "$SKILL_NAME-v$VERSION.tar.gz" -C "$INSTALL_DIR"

# Verify checksum
echo "🔍 Verifying checksum..."
# ... checksum verification logic

# Check dependencies
echo "🔗 Checking dependencies..."
# ... dependency checking logic

echo "✅ Installation complete!"
echo "Skill installed at: $INSTALL_DIR/$SKILL_NAME"
```

### Version Management

```python
class SkillVersionManager:
    def __init__(self):
        self.versions = {}

    def release_version(self, skill_name, version_type):
        """Release new version (major, minor, patch)."""

        current_version = self.get_current_version(skill_name)

        if version_type == 'major':
            new_version = increment_major(current_version)
        elif version_type == 'minor':
            new_version = increment_minor(current_version)
        elif version_type == 'patch':
            new_version = increment_patch(current_version)

        return new_version

    def get_current_version(self, skill_name):
        """Get current version from skill.yaml."""

        manifest_path = f"{skill_name}/skill.yaml"
        with open(manifest_path) as f:
            manifest = yaml.safe_load(f)

        return manifest['version']

def increment_major(version):
    """Increment major version."""
    major, minor, patch = map(int, version.split('.'))
    return f"{major + 1}.0.0"

def increment_minor(version):
    """Increment minor version."""
    major, minor, patch = map(int, version.split('.'))
    return f"{major}.{minor + 1}.0"

def increment_patch(version):
    """Increment patch version."""
    major, minor, patch = map(int, version.split('.'))
    return f"{major}.{minor}.{patch + 1}"
```

### Dependency Resolution

```python
def resolve_dependencies(manifest, registry):
    """Resolve and validate skill dependencies."""

    resolved = []
    errors = []

    for dep in manifest.get('dependencies', []):
        dep_name = dep['name']
        version_constraint = dep.get('version', '*')

        # Find matching version in registry
        matching_versions = registry.find_versions(dep_name, version_constraint)

        if not matching_versions:
            errors.append(
                f"Dependency {dep_name} {version_constraint} not found"
            )
            continue

        resolved.append({
            'name': dep_name,
            'version': matching_versions[0],  # Highest matching
            'constraint': version_constraint
        })

    return resolved, errors
```

### Registry Publishing

```python
def publish_to_registry(package_path, registry_url):
    """Publish skill package to registry."""

    # Authenticate
    credentials = get_credentials(registry_url)

    # Upload package
    with open(package_path, 'rb') as f:
        response = requests.post(
            f"{registry_url}/api/skills/upload",
            files={'package': f},
            headers={'Authorization': f"Bearer {credentials}"}
        )

    if response.status_code == 201:
        print("✅ Published to registry")
        return response.json()['skill_id']
    else:
        print(f"❌ Upload failed: {response.text}")
        return None
```

### Skill Registry API

```python
class SkillRegistry:
    def __init__(self, base_url):
        self.base_url = base_url

    def search_skills(self, query):
        """Search for skills in registry."""

        response = requests.get(
            f"{self.base_url}/api/skills/search",
            params={'q': query}
        )

        return response.json()['results']

    def get_skill_info(self, skill_name):
        """Get skill metadata."""

        response = requests.get(
            f"{self.base_url}/api/skills/{skill_name}"
        )

        return response.json()

    def download_skill(self, skill_name, version='latest'):
        """Download skill package."""

        response = requests.get(
            f"{self.base_url}/api/skills/{skill_name}/download",
            params={'version': version}
        )

        # Save to file
        package_path = f"{skill_name}-{version}.tar.gz"
        with open(package_path, 'wb') as f:
            f.write(response.content)

        return package_path

    def list_versions(self, skill_name):
        """List available versions of skill."""

        response = requests.get(
            f"{self.base_url}/api/skills/{skill_name}/versions"
        )

        return response.json()['versions']
```

### CHANGELOG Format

```markdown
# Changelog

All notable changes to this skill will be documented in this file.

## [1.2.0] - 2026-01-16

### Added
- Support for Scenario Outlines
- Multi-language scenarios (Chinese/English)
- Examples table generation

### Changed
- Improved error messages for invalid Gherkin
- Updated Quick Reference with more patterns

### Fixed
- Bug with duplicate Given steps
- Issue with special characters in feature names

## [1.1.0] - 2026-01-10

### Added
- Background section support
- Tags for scenario organization

## [1.0.0] - 2026-01-01

### Added
- Initial release
- Basic scenario generation
- Happy path and error scenarios
```
