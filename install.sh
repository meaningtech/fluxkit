#!/bin/sh
# Fluxkit installer. Safe to re-run. Does not print secret values.
set -u

printf '%s\n' \
  "FLUXKIT" \
  "AGENT: tell your human now, in their language, before you continue:" \
  "you are installing Fluxkit, and you are also checking the whole security system." \
  ""

ROOT="${FLUXKIT_HOME:-$HOME/.fluxkit}"
SRC="$ROOT/src"
mkdir -p "$SRC"

note() { printf 'fluxkit: %s\n' "$1"; }

have() { command -v "$1" >/dev/null 2>&1; }

clone_public() {
  name="$1"
  url="$2"
  dest="$SRC/$name"
  if [ -d "$dest/.git" ]; then
    if git -C "$dest" pull --ff-only >/dev/null 2>&1; then
      note "updated $name"
    else
      note "could not update $name"
    fi
    return 0
  fi
  rm -rf "$dest"
  if git clone --depth 1 "$url" "$dest" >/dev/null 2>&1; then
    note "cloned $name"
  else
    note "could not clone $name"
    return 1
  fi
}

note "source checkouts go to $SRC"

clone_public grog https://github.com/turinglabsorg/grog.git || true
clone_public devo https://github.com/turinglabsorg/devo.git || true
clone_public hush https://github.com/turinglabsorg/hush.git || true
clone_public argo https://github.com/turinglabsorg/argo.git || true
clone_public ambox https://github.com/turinglabsorg/ambox.git || true

if [ -f "$SRC/grog/skill/install.sh" ] && have node && have npm && have jq; then
  note "installing grog. Empty answers skip tokens."
  # Enough blank lines for the token, Linear, Telegram, and Discord prompts.
  if printf '%s\n' "" "" "" "" "" "" "" "" "" "" "" "" | bash "$SRC/grog/skill/install.sh"; then
    note "grog installed"
  else
    note "grog installer failed. The checkout is at $SRC/grog"
  fi
else
  note "skipped grog install. Need the checkout plus node, npm, and jq."
fi

if [ -f "$SRC/hush/install.sh" ]; then
  note "installing hush"
  if sh "$SRC/hush/install.sh" --agent-skill; then
    note "hush installed in ${HUSH_INSTALL_DIR:-$HOME/.local/bin}"
  else
    note "hush installer failed"
  fi
else
  note "skipped hush install. Checkout missing."
fi

if have npm; then
  note "installing the ambox CLI. This does not register an address."
  if npm install -g ambox >/dev/null 2>&1; then
    note "ambox CLI installed"
  else
    note "ambox CLI was not installed. npm install -g ambox needs a working npm prefix."
  fi
else
  note "skipped ambox. npm is not on PATH."
fi

if [ -f "$SRC/devo/skill/install.sh" ] && have node; then
  note "installing devo"
  if bash "$SRC/devo/skill/install.sh"; then
    note "devo installed"
  else
    note "devo installer failed"
  fi
else
  note "skipped devo install"
fi

note "argo source is at $SRC/argo when the clone worked. Models are not downloaded."

printf '%s\n' "" "SECURITY CHECK" "No secret values are read."

mode_of() {
  if stat -f '%Lp' "$1" >/dev/null 2>&1; then
    stat -f '%Lp' "$1"
  else
    stat -c '%a' "$1"
  fi
}

check_private() {
  path="$1"
  if [ ! -e "$path" ]; then
    note "absent $path"
    return 0
  fi
  mode="$(mode_of "$path")"
  others="$(printf '%s' "$mode" | awk '{ print substr($0, length($0), 1) }')"
  if [ "$others" != "0" ]; then
    note "FAIL $path is mode $mode and other users can see it"
    return 1
  fi
  note "ok $path mode $mode"
}

fail=0
list="$ROOT/security-files"
: > "$list"
[ -f "$HOME/.grog/config.json" ] && printf '%s\n' "$HOME/.grog/config.json" >> "$list"
if [ -d "$HOME/.hush" ]; then
  find "$HOME/.hush" -type f >> "$list" 2>/dev/null || true
else
  note "absent $HOME/.hush"
fi
if [ -d "$HOME/.ambox/agents" ]; then
  find "$HOME/.ambox/agents" \( -name 'private.pem' -o -name 'config.json' \) >> "$list" 2>/dev/null || true
else
  note "absent $HOME/.ambox"
fi
if [ ! -s "$list" ]; then
  note "no secret files to check yet"
else
  while read -r file; do
    [ -n "$file" ] || continue
    check_private "$file" || fail=1
  done < "$list"
fi
rm -f "$list"

hook="$HOME/.claude/hooks/gcloud-guard.sh"
if [ -x "$hook" ]; then
  note "ok gcloud guard is installed"
else
  note "FAIL gcloud guard is missing or not executable at $hook"
  fail=1
fi

for tool in git node jq docker uv ollama signal-cli gcloud aws doctl argo hush; do
  if have "$tool"; then
    note "ok command $tool"
  else
    note "absent command $tool"
  fi
done

if have argo; then
  note "running argo doctor"
  if argo doctor; then
    note "ok argo doctor"
  else
    note "FAIL argo doctor"
    fail=1
  fi
else
  note "argo is not on PATH, so the security system is not fully installed"
fi

printf '%s\n' "" "FLUXKIT DONE"
if [ "$fail" -ne 0 ]; then
  note "the security check found a failure. Tell the human which line failed."
  exit 1
fi
note "tell the human the security check finished and what was absent."
exit 0
