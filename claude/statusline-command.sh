#!/bin/bash

input=$(cat)

# Extract data
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
dir=$(basename "$cwd")

# Git branch and status
branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
git_status=""
if [ -n "$branch" ]; then
	if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]; then
		git_status=" ($branch*)"
	else
		git_status=" ($branch)"
	fi
fi

# Context percentage
usage=$(echo "$input" | jq '.context_window.current_usage')
context_info=""
if [ "$usage" != "null" ]; then
	current=$(echo "$usage" | jq '.input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens')
	size=$(echo "$input" | jq '.context_window.context_window_size')
	pct=$((current * 100 / size))
	context_info="[${pct}% context]"
fi

# Build left and right sides
left="${dir}${git_status}"
right="${context_info}"

# Calculate terminal width and padding
term_width=$(tput cols 2>/dev/null || echo 80)
total_len=$((${#left} + ${#right}))

if [ $total_len -lt $term_width ]; then
	# Add padding between left and right
	printf '%s%*s' "$left" $((term_width - ${#left})) "$right"
else
	# Terminal too narrow, just concatenate
	printf '%s %s' "$left" "$right"
fi
