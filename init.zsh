# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::copilot::deps()
#
#>
######################################################################
p6df::modules::copilot::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::copilot::vscodes()
#
#>
######################################################################
p6df::modules::copilot::vscodes() {

  p6df::modules::vscode::extension::install github.copilot
  p6df::modules::vscode::extension::install github.copilot-chat

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::copilot::vscodes::config()
#
#>
######################################################################
p6df::modules::copilot::vscodes::config() {

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
# Function: p6df::modules::copilot::external::brews()
#
#>
######################################################################
p6df::modules::copilot::external::brews() {

  p6df::core::homebrew::cli::brew::install copilot-cli

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::copilot::home::symlink()
#
#  Environment:	 P6_DFZ_SRC_P6M7G8_DOTFILES_DIR
#>
######################################################################
p6df::modules::copilot::home::symlink() {

  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DOTFILES_DIR/p6df-copilot/share/copilot" "$HOME/.copilot"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::copilot::aliases::init()
#
#>
######################################################################
p6df::modules::copilot::aliases::init() {

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
# Function: str str = p6df::modules::copilot::prompt::mod()
#
#  Returns:
#	str - str
#
#  Environment:	 GH_USER P6_DFZ_PROFILE_COPILOT
#>
######################################################################
p6df::modules::copilot::prompt::mod() {

  local str
  if p6_string_blank_NOT "$P6_DFZ_PROFILE_COPILOT"; then
    if p6_string_blank_NOT "$GH_USER"; then
      str="copilot:\t  $P6_DFZ_PROFILE_COPILOT: $GH_USER"
    fi
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6df::modules::copilot::profile::on(profile, code)
#
#  Args:
#	profile -
#	code - shell code block (export GITHUB_COPILOT_TOKEN=...)
#
#  Environment:	 P6_DFZ_PROFILE_COPILOT
#>
######################################################################
p6df::modules::copilot::profile::on() {
  local profile="$1"
  local code="$2"

  p6_run_code "$code"

  p6_env_export "P6_DFZ_PROFILE_COPILOT" "$profile"

  p6_return_void
}

######################################################################
#<
#
# Function: p6df::modules::copilot::profile::off(code)
#
#  Args:
#	code - shell code block previously passed to profile::on
#
#  Environment:	 P6_DFZ_PROFILE_COPILOT
#>
######################################################################
p6df::modules::copilot::profile::off() {
  local code="$1"

  p6_env_unset_from_code "$code"
  p6_env_export_un P6_DFZ_PROFILE_COPILOT

  p6_return_void
}
