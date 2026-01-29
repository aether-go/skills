#!/bin/bash

# Skills Management Script for Aether.go Skills
# This script provides convenient commands to manage, validate, and install skills

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="${SCRIPT_DIR}/skills"

# Global installation paths
GLOBAL_CLAUDE_SKILLS="${HOME}/.claude/skills"
GLOBAL_OPENCODE_SKILLS="${HOME}/.config/opencode/skill"

# Print colored message
print_message() {
    local color=$1
    shift
    echo -e "${color}$*${NC}"
}

# Print error message
print_error() {
    print_message "${RED}" "Error: $*"
}

# Print success message
print_success() {
    print_message "${GREEN}" "Success: $*"
}

# Print info message
print_info() {
    print_message "${BLUE}" "Info: $*"
}

# Print warning message
print_warning() {
    print_message "${YELLOW}" "Warning: $*"
}

# Check if skills directory exists
check_skills_dir() {
    if [ ! -d "${SKILLS_DIR}" ]; then
        print_error "Skills directory not found: ${SKILLS_DIR}"
        exit 1
    fi
}

# List all skills
list_skills() {
    check_skills_dir
    print_info "Listing all skills in ${SKILLS_DIR}..."
    echo ""
    
    local count=0
    for skill_dir in "${SKILLS_DIR}"/*/; do
        if [ -d "${skill_dir}" ]; then
            local skill_name=$(basename "${skill_dir}")
            local skill_file="${skill_dir}/SKILL.md"
            
            if [ -f "${skill_file}" ]; then
                # Extract description from YAML frontmatter
                local description=$(grep -A 1 "^description:" "${skill_file}" | tail -1 | sed 's/^[[:space:]]*//' || echo "No description")
                echo -e "${GREEN}✓${NC} ${skill_name}"
                echo "  ${description}"
                echo ""
                ((count++))
            fi
        fi
    done
    
    print_info "Total skills found: ${count}"
}

# Show skill details
show_skill() {
    local skill_name=$1
    
    if [ -z "${skill_name}" ]; then
        print_error "Please provide a skill name"
        echo "Usage: $0 show <skill-name>"
        exit 1
    fi
    
    local skill_dir="${SKILLS_DIR}/${skill_name}"
    local skill_file="${skill_dir}/SKILL.md"
    
    if [ ! -f "${skill_file}" ]; then
        print_error "Skill not found: ${skill_name}"
        exit 1
    fi
    
    print_info "Showing details for skill: ${skill_name}"
    echo ""
    cat "${skill_file}"
}

# Search skills
search_skills() {
    local search_term=$1
    
    if [ -z "${search_term}" ]; then
        print_error "Please provide a search term"
        echo "Usage: $0 search <search-term>"
        exit 1
    fi
    
    check_skills_dir
    print_info "Searching for skills matching: ${search_term}"
    echo ""
    
    local count=0
    for skill_dir in "${SKILLS_DIR}"/*/; do
        if [ -d "${skill_dir}" ]; then
            local skill_name=$(basename "${skill_dir}")
            local skill_file="${skill_dir}/SKILL.md"
            
            if [ -f "${skill_file}" ]; then
                # Search in skill name and content
                if grep -qi "${search_term}" <<< "${skill_name}" || grep -qi "${search_term}" "${skill_file}"; then
                    echo -e "${GREEN}✓${NC} ${skill_name}"
                    ((count++))
                fi
            fi
        fi
    done
    
    if [ ${count} -eq 0 ]; then
        print_warning "No skills found matching: ${search_term}"
    else
        print_info "Found ${count} matching skills"
    fi
}

# Show statistics
show_stats() {
    check_skills_dir
    print_info "Skills statistics"
    echo ""
    
    local total=0
    local valid=0
    local invalid=0
    
    for skill_dir in "${SKILLS_DIR}"/*/; do
        if [ -d "${skill_dir}" ]; then
            local skill_file="${skill_dir}/SKILL.md"
            ((total++))
            
            if [ -f "${skill_file}" ]; then
                if validate_single_skill "${skill_dir}" >/dev/null 2>&1; then
                    ((valid++))
                else
                    ((invalid++))
                fi
            else
                ((invalid++))
            fi
        fi
    done
    
    echo "Total skills: ${total}"
    echo -e "${GREEN}Valid skills: ${valid}${NC}"
    if [ ${invalid} -gt 0 ]; then
        echo -e "${RED}Invalid skills: ${invalid}${NC}"
    fi
}

# Validate a single skill
validate_single_skill() {
    local skill_dir=$1
    local skill_name=$(basename "${skill_dir}")
    local skill_file="${skill_dir}/SKILL.md"
    
    # Check if SKILL.md exists
    if [ ! -f "${skill_file}" ]; then
        echo "✗ ${skill_name}: SKILL.md not found"
        return 1
    fi
    
    # Check for YAML frontmatter
    if ! grep -q "^---$" "${skill_file}"; then
        echo "✗ ${skill_name}: YAML frontmatter not found"
        return 1
    fi
    
    # Check for name field
    if ! grep -q "^name:" "${skill_file}"; then
        echo "✗ ${skill_name}: 'name' field not found in frontmatter"
        return 1
    fi
    
    # Check for description field
    if ! grep -q "^description:" "${skill_file}"; then
        echo "✗ ${skill_name}: 'description' field not found in frontmatter"
        return 1
    fi
    
    # Check if description starts with "Use when"
    if ! grep -q "^description:.*Use when" "${skill_file}"; then
        echo "✗ ${skill_name}: description must start with 'Use when'"
        return 1
    fi
    
    echo "✓ ${skill_name}: Valid"
    return 0
}

# Validate all skills
validate_skills() {
    local skill_name=$1
    
    check_skills_dir
    
    if [ -n "${skill_name}" ]; then
        # Validate specific skill
        local skill_dir="${SKILLS_DIR}/${skill_name}"
        if [ ! -d "${skill_dir}" ]; then
            print_error "Skill not found: ${skill_name}"
            exit 1
        fi
        print_info "Validating skill: ${skill_name}"
        validate_single_skill "${skill_dir}"
    else
        # Validate all skills
        print_info "Validating all skills..."
        echo ""
        
        local valid=0
        local invalid=0
        
        for skill_dir in "${SKILLS_DIR}"/*/; do
            if [ -d "${skill_dir}" ]; then
                if validate_single_skill "${skill_dir}"; then
                    ((valid++))
                else
                    ((invalid++))
                fi
            fi
        done
        
        echo ""
        print_info "Validation complete"
        echo -e "${GREEN}Valid: ${valid}${NC}"
        if [ ${invalid} -gt 0 ]; then
            echo -e "${RED}Invalid: ${invalid}${NC}"
        fi
    fi
}

# Install skill to global location
install_skill() {
    local skill_name=$1
    
    if [ -z "${skill_name}" ]; then
        print_error "Please provide a skill name"
        echo "Usage: $0 install <skill-name>"
        exit 1
    fi
    
    local skill_dir="${SKILLS_DIR}/${skill_name}"
    
    if [ ! -d "${skill_dir}" ]; then
        print_error "Skill not found: ${skill_name}"
        exit 1
    fi
    
    # Determine installation target
    local target_dir=""
    if [ -d "${GLOBAL_CLAUDE_SKILLS}" ]; then
        target_dir="${GLOBAL_CLAUDE_SKILLS}"
    elif [ -d "${GLOBAL_OPENCODE_SKILLS}" ]; then
        target_dir="${GLOBAL_OPENCODE_SKILLS}"
    else
        # Create Claude skills directory by default
        mkdir -p "${GLOBAL_CLAUDE_SKILLS}"
        target_dir="${GLOBAL_CLAUDE_SKILLS}"
    fi
    
    # Copy skill to global directory
    print_info "Installing ${skill_name} to ${target_dir}..."
    cp -r "${skill_dir}" "${target_dir}/"
    
    if [ $? -eq 0 ]; then
        print_success "Skill ${skill_name} installed successfully to ${target_dir}"
    else
        print_error "Failed to install skill ${skill_name}"
        exit 1
    fi
}

# Install all skills
install_all() {
    check_skills_dir
    
    # Determine installation target
    local target_dir=""
    if [ -d "${GLOBAL_CLAUDE_SKILLS}" ]; then
        target_dir="${GLOBAL_CLAUDE_SKILLS}"
    elif [ -d "${GLOBAL_OPENCODE_SKILLS}" ]; then
        target_dir="${GLOBAL_OPENCODE_SKILLS}"
    else
        # Create Claude skills directory by default
        mkdir -p "${GLOBAL_CLAUDE_SKILLS}"
        target_dir="${GLOBAL_CLAUDE_SKILLS}"
    fi
    
    print_info "Installing all skills to ${target_dir}..."
    
    local count=0
    for skill_dir in "${SKILLS_DIR}"/*/; do
        if [ -d "${skill_dir}" ]; then
            local skill_name=$(basename "${skill_dir}")
            cp -r "${skill_dir}" "${target_dir}/"
            ((count++))
        fi
    done
    
    print_success "Installed ${count} skills to ${target_dir}"
}

# Show help
show_help() {
    cat << EOF
Aether.go Skills Management Script

Usage: $0 <command> [options]

Commands:
    list                    List all available skills
    show <skill-name>       Show detailed information about a specific skill
    search <term>           Search for skills by name or content
    stats                   Show statistics about all skills
    validate [skill-name]    Validate skill format (all skills if no name provided)
    install <skill-name>     Install a specific skill to global location
    install-all             Install all skills to global location
    help                    Show this help message

Examples:
    $0 list
    $0 show bdd-scenario-writer
    $0 search testing
    $0 stats
    $0 validate
    $0 validate bdd-scenario-writer
    $0 install bdd-scenario-writer
    $0 install-all

Global Installation Paths:
    Claude skills:   ~/.claude/skills/
    OpenCode skills:  ~/.config/opencode/skill/

For more information, see README.md and MIGRATION.md
EOF
}

# Main script logic
main() {
    local command=$1
    shift || true
    
    case ${command} in
        list)
            list_skills
            ;;
        show)
            show_skill "$@"
            ;;
        search)
            search_skills "$@"
            ;;
        stats)
            show_stats
            ;;
        validate)
            validate_skills "$@"
            ;;
        install)
            install_skill "$@"
            ;;
        install-all)
            install_all
            ;;
        help|--help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: ${command}"
            echo ""
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
