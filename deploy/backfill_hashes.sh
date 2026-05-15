#!/usr/bin/env bash
# SPDX-License-Identifier: AGPL-3.0-or-later
# backfill_hashes.sh — Compute BLAKE3 hashes for fetched data and update source TOMLs
#
# Walks the .data/ directory for each thread, computes BLAKE3 hashes of fetched
# files, and updates the corresponding data/sources/*.toml with hashes and timestamps.
#
# Usage:
#   ./backfill_hashes.sh [--thread THREAD] [--data-dir DIR] [--dry-run]
#
# Requires: b3sum (cargo install b3sum)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
FOUNDATION_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

THREAD_FILTER=""
DATA_DIR="$FOUNDATION_ROOT/.data"
DRY_RUN=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --thread)    THREAD_FILTER="$2"; shift 2 ;;
        --data-dir)  DATA_DIR="$2"; shift 2 ;;
        --dry-run)   DRY_RUN=true; shift ;;
        -h|--help)
            echo "Usage: $0 [--thread THREAD] [--data-dir DIR] [--dry-run]"
            exit 0 ;;
        *)           echo "Unknown option: $1"; exit 1 ;;
    esac
done

log() { echo "[backfill] $(date '+%H:%M:%S') $*"; }

if ! command -v b3sum >/dev/null 2>&1; then
    log "ERROR: b3sum not found. Install: cargo install b3sum"
    exit 1
fi

TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
UPDATED=0
SKIPPED=0

log "Foundation BLAKE3 manifest backfill"
log "  Data directory: $DATA_DIR"
log "  Timestamp: $TIMESTAMP"
[[ "$DRY_RUN" == "true" ]] && log "  DRY RUN — no files will be modified"
echo ""

backfill_source_toml() {
    local toml_file="$1"
    local thread_data_dir="$2"
    local thread_name
    thread_name=$(basename "$toml_file" .toml)

    if [[ -n "$THREAD_FILTER" && "$thread_name" != *"$THREAD_FILTER"* ]]; then
        return
    fi

    log "Processing $thread_name..."

    if [[ ! -d "$thread_data_dir" ]]; then
        log "  SKIP: No data directory at $thread_data_dir"
        ((SKIPPED++)) || true
        return
    fi

    local file_count
    file_count=$(find "$thread_data_dir" -type f 2>/dev/null | wc -l)
    if [[ "$file_count" -eq 0 ]]; then
        log "  SKIP: Data directory is empty"
        ((SKIPPED++)) || true
        return
    fi

    local dir_hash
    dir_hash=$(find "$thread_data_dir" -type f | sort | xargs cat | b3sum | cut -d' ' -f1)
    log "  Directory BLAKE3: $dir_hash ($file_count files)"

    if [[ "$DRY_RUN" == "true" ]]; then
        log "  DRY RUN: would update blake3 fields in $toml_file"
        return
    fi

    local empty_count
    empty_count=$(grep -c 'blake3 = ""' "$toml_file" 2>/dev/null || echo "0")
    if [[ "$empty_count" -eq 0 ]]; then
        log "  All hashes already filled — skipping"
        return
    fi

    local temp_file="${toml_file}.tmp"
    local first_empty=true
    while IFS= read -r line; do
        if [[ "$line" == 'blake3 = ""' && "$first_empty" == "true" ]]; then
            echo "blake3 = \"${dir_hash}\"" >> "$temp_file"
            first_empty=false
        elif [[ "$line" == 'blake3 = ""' ]]; then
            echo "$line" >> "$temp_file"
        elif [[ "$line" == 'retrieved = ""' && "$first_empty" == "false" ]]; then
            echo "retrieved = \"${TIMESTAMP}\"" >> "$temp_file"
            first_empty=true
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$toml_file"
    mv "$temp_file" "$toml_file"

    log "  Updated first empty blake3+retrieved in $toml_file"
    ((UPDATED++)) || true
}

SOURCES_DIR="$FOUNDATION_ROOT/data/sources"
for toml_file in "$SOURCES_DIR"/*.toml; do
    [[ -f "$toml_file" ]] || continue
    thread_name=$(basename "$toml_file" .toml)
    thread_data_dir="$DATA_DIR/$thread_name"
    backfill_source_toml "$toml_file" "$thread_data_dir"
done

echo ""
log "Backfill complete: $UPDATED updated, $SKIPPED skipped"
log ""
log "NOTE: This script fills directory-level hashes for the first empty entry"
log "per source TOML. For per-accession hashes, run fetch_sources.sh with"
log "--register to anchor individual files via NestGate."
