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
clone_public mcaifee https://github.com/turinglabsorg/mcaifee.git || true
clone_public doc https://github.com/turinglabsorg/doc.git || true

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

if [ -f "$SRC/doc/bin/doc" ]; then
  note "installing doc"
  chmod +x "$SRC/doc/bin/doc" "$SRC/doc/bin/doc-hook" 2>/dev/null || true
  mkdir -p "$HOME/.local/bin"
  ln -sfn "$SRC/doc/bin/doc" "$HOME/.local/bin/doc"
  note "doc CLI linked in $HOME/.local/bin"
  if have python3; then
    DOC_HOOK="$SRC/doc/bin/doc-hook" python3 - <<'PY'
import json, os, tempfile

hook = os.environ["DOC_HOOK"]
specs = [
    ("PreToolUse", "Bash", hook + " publish_guard"),
    ("Stop", None, hook + " reply_check"),
    ("UserPromptSubmit", None, hook + " skill_router"),
]

def commands(node):
    found = []
    if isinstance(node, dict):
        if isinstance(node.get("command"), str):
            found.append(node["command"])
        for value in node.values():
            found.extend(commands(value))
    elif isinstance(node, list):
        for value in node:
            found.extend(commands(value))
    return found

def install(path):
    data = {}
    if os.path.exists(path):
        try:
            with open(path) as handle:
                data = json.load(handle)
        except json.JSONDecodeError:
            print("fluxkit: skipped doc hooks in %s. The file is not valid JSON." % path)
            return
    if not isinstance(data, dict):
        print("fluxkit: skipped doc hooks in %s. The file is not an object." % path)
        return
    hooks = data.setdefault("hooks", {})
    if not isinstance(hooks, dict):
        print("fluxkit: skipped doc hooks in %s. hooks is not an object." % path)
        return
    changed = False
    for event, matcher, command in specs:
        entries = hooks.setdefault(event, [])
        if not isinstance(entries, list):
            print("fluxkit: skipped %s in %s. It is not a list." % (event, path))
            continue
        if command in commands(entries):
            continue
        if matcher:
            bucket = next((item for item in entries if isinstance(item, dict) and item.get("matcher") == matcher), None)
            if bucket is None:
                bucket = {"matcher": matcher, "hooks": []}
                entries.append(bucket)
        else:
            bucket = next((item for item in entries if isinstance(item, dict) and "matcher" not in item), None)
            if bucket is None:
                bucket = {"hooks": []}
                entries.append(bucket)
        hook_list = bucket.setdefault("hooks", [])
        if isinstance(hook_list, list):
            hook_list.append({"type": "command", "command": command, "timeout": 20})
            changed = True
    if not changed:
        print("fluxkit: doc hooks already present in %s" % path)
        return
    directory = os.path.dirname(path) or "."
    os.makedirs(directory, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=directory, prefix=".doc-hooks.")
    try:
        with os.fdopen(fd, "w") as handle:
            json.dump(data, handle, indent=2)
            handle.write("\n")
        if os.path.exists(path):
            os.chmod(tmp, os.stat(path).st_mode & 0o777)
        else:
            os.chmod(tmp, 0o600)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.remove(tmp)
    print("fluxkit: doc hooks registered in %s" % path)

home = os.environ["HOME"]
install(os.path.join(home, ".claude", "settings.json"))
install(os.path.join(home, ".codex", "hooks.json"))
PY
  else
    note "skipped doc hooks. python3 is not on PATH."
  fi
else
  note "skipped doc install. Checkout missing."
fi

if [ -f "$SRC/mcaifee/install.sh" ]; then
  note "installing mcaifee"
  if sh "$SRC/mcaifee/install.sh" --agent-skill; then
    note "mcaifee installed in ${MCAIFEE_INSTALL_DIR:-$HOME/.local/bin}"
  else
    note "mcaifee installer failed"
  fi
else
  note "skipped mcaifee install. Checkout missing."
fi

mcaifee_bin=""
if [ -x "${MCAIFEE_INSTALL_DIR:-$HOME/.local/bin}/mcaifee" ]; then
  mcaifee_bin="${MCAIFEE_INSTALL_DIR:-$HOME/.local/bin}/mcaifee"
elif have mcaifee; then
  mcaifee_bin="mcaifee"
fi

if have npm && [ -n "$mcaifee_bin" ]; then
  note "installing the ambox CLI through mcaifee. This does not register an address."
  if "$mcaifee_bin" npm install -g ambox; then
    note "ambox CLI installed"
  else
    note "ambox CLI was not installed. mcaifee did not allow npm install -g ambox."
  fi
elif have npm; then
  note "skipped ambox. mcaifee is not installed, so the npm install was not run."
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
[ -f "$HOME/.mcaifee/config.json" ] && printf '%s\n' "$HOME/.mcaifee/config.json" >> "$list"
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

for tool in git node jq docker uv ollama signal-cli gcloud aws doctl argo hush mcaifee doc; do
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
