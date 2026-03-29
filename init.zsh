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
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
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
# Function: str str = p6df::modules::ghcopilot::prompt::mod()
#
#  Returns:
#	str - str
#
#  Environment:	 GH_USER P6_DFZ_PROFILE_GHCOPILOT
#>
######################################################################
p6df::modules::ghcopilot::prompt::mod() {

  local str
  if p6_string_blank_NOT "$P6_DFZ_PROFILE_GHCOPILOT"; then
    if p6_string_blank_NOT "$GH_USER"; then
      str="copilot:\t  $P6_DFZ_PROFILE_GHCOPILOT: $GH_USER"
    fi
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::profile::on(profile, code)
#
#  Args:
#	profile -
#	code - shell code block (export GITHUB_COPILOT_TOKEN=...)
#
#  Environment:	 P6_DFZ_PROFILE_GHCOPILOT
#>
######################################################################
p6df::modules::ghcopilot::profile::on() {
  local profile="$1"
  local code="$2"

  p6_run_code "$code"

  p6_env_export "P6_DFZ_PROFILE_GHCOPILOT" "$profile"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::ghcopilot::profile::off(code)
#
#  Args:
#	code - shell code block previously passed to profile::on
#
#  Environment:	 P6_DFZ_PROFILE_GHCOPILOT
#>
######################################################################
p6df::modules::ghcopilot::profile::off() {
  local code="$1"

  p6_env_unset_from_code "$code"
  p6_env_export_un P6_DFZ_PROFILE_GHCOPILOT

  p6_return_void
}
