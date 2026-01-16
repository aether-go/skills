#!/bin/bash

# Skills 管理工具

SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 显示使用帮助
show_help() {
    cat << EOF
Aether.go Skills 管理工具

使用方式:
    ./skills.sh [命令] [选项]

命令:
    list                列出所有技能
    show <skill-name>    显示指定技能的详细信息
    search <keyword>     搜索包含关键词的技能
    stats               显示统计信息
    validate            验证所有技能的格式
    install <name>      安装技能到全局位置
    test <name>         测试指定技能

示例:
    ./skills.sh list
    ./skills.sh show bdd-scenario-writer
    ./skills.sh search testing
    ./skills.sh stats
    ./skills.sh validate

EOF
}

# 列出所有技能
list_skills() {
    echo -e "${BLUE}Aether.go Skills 列表${NC}\n"

    # 按类别分组
    echo "【执行层】"
    for skill in bdd-scenario-writer tdd-red-green-refactor test-pyramid-analyzer sit-scenario-generator chaos-test-designer; do
        show_skill_brief "$skill"
    done

    echo -e "\n【战略层】"
    for skill in business-value-mapper metrics-definer architecture-decision-recorder data-flow-analyzer; do
        show_skill_brief "$skill"
    done

    echo -e "\n【战术层】"
    for skill in spec-parser constitution-validator spec-to-code-tracer spec-evolution-tracker; do
        show_skill_brief "$skill"
    done

    echo -e "\n【AI 协作层】"
    for skill in context-manager skill-recommender recursive-optimizer prompt-template-manager; do
        show_skill_brief "$skill"
    done

    echo -e "\n【工具集成层】"
    for skill in skill-packaging-tool; do
        show_skill_brief "$skill"
    done
}

# 显示技能简要信息
show_skill_brief() {
    local skill_name=$1
    local skill_dir="$SKILLS_DIR/$skill_name"

    if [ -d "$skill_dir" ]; then
        local skill_file="$skill_dir/SKILL.md"
        if [ -f "$skill_file" ]; then
            local description=$(grep "^description:" "$skill_file" | cut -d':' -f2- | sed 's/^ *//')
            echo -e "  ${GREEN}•${NC} $skill_name"
            echo "    $description"
        fi
    fi
}

# 显示技能详细信息
show_skill() {
    local skill_name=$1
    local skill_file="$SKILLS_DIR/$skill_name/SKILL.md"

    if [ ! -f "$skill_file" ]; then
        echo -e "${RED}错误: 找不到技能 '$skill_name'${NC}"
        exit 1
    fi

    echo -e "${BLUE}技能: $skill_name${NC}"
    echo "----------------------------------------"
    cat "$skill_file"
}

# 搜索技能
search_skills() {
    local keyword=$1
    echo -e "${BLUE}搜索包含 '$keyword' 的技能:${NC}\n"

    found=false

    for skill_dir in "$SKILLS_DIR"/*/; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_file="$skill_dir/SKILL.md"

            if [ -f "$skill_file" ]; then
                if grep -qi "$keyword" "$skill_file"; then
                    found=true
                    show_skill_brief "$skill_name"
                    echo ""
                fi
            fi
        fi
    done

    if [ "$found" = false ]; then
        echo -e "${YELLOW}未找到包含 '$keyword' 的技能${NC}"
    fi
}

# 显示统计信息
show_stats() {
    local total_skills=$(find "$SKILLS_DIR" -name "SKILL.md" -type f | wc -l)

    echo -e "${BLUE}Aether.go Skills 统计信息${NC}"
    echo "----------------------------------------"
    echo "总技能数: $total_skills"
    echo "技能目录: $SKILLS_DIR"
    echo ""

    # 按类型统计
    echo "按类型分布:"
    echo "  执行层: 5"
    echo "  战略层: 4"
    echo "  战术层: 4"
    echo "  AI协作层: 4"
    echo "  工具集成层: 1"
}

# 验证技能格式
validate_skills() {
    echo -e "${BLUE}验证技能格式...${NC}\n"

    local errors=0
    local warnings=0

    for skill_dir in "$SKILLS_DIR"/*/; do
        if [ -d "$skill_dir" ]; then
            local skill_name=$(basename "$skill_dir")
            local skill_file="$skill_dir/SKILL.md"

            echo -n "检查 $skill_name ... "

            if [ ! -f "$skill_file" ]; then
                echo -e "${RED}失败${NC} (缺少 SKILL.md)"
                ((errors++))
                continue
            fi

            # 检查 YAML frontmatter
            if ! grep -q "^name:" "$skill_file"; then
                echo -e "${RED}失败${NC} (缺少 name)"
                ((errors++))
            elif ! grep -q "^description:" "$skill_file"; then
                echo -e "${RED}失败${NC} (缺少 description)"
                ((errors++))
            elif ! grep -q "^description: Use when" "$skill_file"; then
                echo -e "${YELLOW}警告${NC} (description 不以 'Use when' 开头)"
                ((warnings++))
            else
                echo -e "${GREEN}通过${NC}"
            fi
        fi
    done

    echo ""
    echo -e "验证完成: ${GREEN}$errors 错误${NC}, ${YELLOW}$warnings 警告${NC}"
}

# 安装技能到全局位置
install_skill() {
    local skill_name=$1
    local skill_dir="$SKILLS_DIR/$skill_name"
    local global_dir="$HOME/.config/opencode/skill/$skill_name"

    if [ ! -d "$skill_dir" ]; then
        echo -e "${RED}错误: 找不到技能 '$skill_name'${NC}"
        exit 1
    fi

    echo "安装技能 '$skill_name' 到全局位置..."
    mkdir -p "$HOME/.config/opencode/skill"
    cp -r "$skill_dir" "$global_dir"
    echo -e "${GREEN}✓ 技能已安装到 $global_dir${NC}"
}

# 测试技能
test_skill() {
    local skill_name=$1
    echo -e "${BLUE}测试技能: $skill_name${NC}"

    # 这里可以添加实际的测试逻辑
    echo "TODO: 实现 skill 测试逻辑"
}

# 主函数
main() {
    case "$1" in
        list)
            list_skills
            ;;
        show)
            if [ -z "$2" ]; then
                echo -e "${RED}错误: 请指定技能名称${NC}"
                exit 1
            fi
            show_skill "$2"
            ;;
        search)
            if [ -z "$2" ]; then
                echo -e "${RED}错误: 请指定搜索关键词${NC}"
                exit 1
            fi
            search_skills "$2"
            ;;
        stats)
            show_stats
            ;;
        validate)
            validate_skills
            ;;
        install)
            if [ -z "$2" ]; then
                echo -e "${RED}错误: 请指定要安装的技能名称${NC}"
                exit 1
            fi
            install_skill "$2"
            ;;
        test)
            if [ -z "$2" ]; then
                echo -e "${RED}错误: 请指定要测试的技能名称${NC}"
                exit 1
            fi
            test_skill "$2"
            ;;
        *)
            show_help
            exit 1
            ;;
    esac
}

main "$@"
