# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::ghcopilot::deps()
#
#>
######################################################################
p6df::modules::ghcopilot::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::vscodes()
#
#>
######################################################################
p6df::modules::ghcopilot::vscodes() {

  p6df::modules::vscode::extension::install github.copilot
  p6df::modules::vscode::extension::install github.copilot-chat

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::vscodes::config()
#
#>
######################################################################
p6df::modules::ghcopilot::vscodes::config() {

  cat <<'EOF'
  "github.copilot.enable": {
    "*": true,
    "yaml": true,
    "plaintext": false,
    "markdown": true
  }
EOF

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::external::brews()
#
#>
######################################################################
p6df::modules::ghcopilot::external::brews() {

  p6df::core::homebrew::cli::brew::install copilot-cli

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::home::symlink()
#
#  Environment:	 HOME P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::ghcopilot::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-ghcopilot/share/copilot" "$HOME/.copilot"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::aliases::init()
#
#>
######################################################################
p6df::modules::ghcopilot::aliases::init() {

  local _module="$1"
  local _dir="$2"
  # core copilot CLI commands
  p6_alias ghcs "gh copilot suggest"
  p6_alias ghce "gh copilot explain"
  p6_alias ghcc "gh copilot config"

  # common patterns
  p6_alias ghcsg "gh copilot suggest -t git"
  p6_alias ghcss "gh copilot suggest -t shell"
  p6_alias ghcsgh "gh copilot suggest -t gh"

  p6_return_void
}

######################################################################
#<
#
# Function: words ghcopilot $GH_COPILOT_VERSION = p6df::modules::ghcopilot::profile::mod()
#
#  Returns:
#	words - ghcopilot $GH_COPILOT_VERSION
#
#  Environment:	 GH_COPILOT_VERSION
#>
######################################################################
p6df::modules::ghcopilot::profile::mod() {

  p6_return_words 'ghcopilot' '$GH_COPILOT_VERSION'
}

