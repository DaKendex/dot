ave() {
  if [ "$#" -gt 1 ]; then
    echo "Usage: ave [region]"
    return 1
  fi

  profile=${1:-$(sed -n 's/^\[profile \(.*\)\]/\1/p' ~/.aws/config | fzf --height 40% --reverse --prompt="Select AWS Profile: ")}
  # profile=${1:-dev}
  aws-vault exec $profile -- zsh
}

# Login to ECR, optionally specifying a profile name and region.
# Add this global variable to toggle FIPS usage to the ~/.env.zsh file. Needs fzf, `brew install fzf`
# Uncomment to use FIPS endpoints
# AWS_FEDERAL=true

ecr-login () {
    if [ "$#" -gt 2 ]; then
        echo "Usage: ecr-login [profile] [region]"
        return 1
    fi
    profile=${1:-$(sed -n 's/^\[profile \(.*\)\]/\1/p' ~/.aws/config | fzf --height 40% --reverse --prompt="Select AWS Profile: ")}
    if [ -z "$profile" ]; then
        echo "No profile selected"
        return 1
    fi
    region=${2:-$(aws configure get region --profile "$profile")}
    if [ -z "$region" ]; then
        echo "Region not specified and no default region set for profile $profile"
        return 1
    fi
    if [ "$AWS_FEDERAL" = true ]; then
        endpoint_suffix="dkr.ecr-fips"
    else
        endpoint_suffix="dkr.ecr"
    fi
    registry="$(aws sts get-caller-identity --profile "$profile" --query 'Account' --output text).$endpoint_suffix.$region.amazonaws.com"
    docker logout "$registry" 2>/dev/null
    aws ecr get-login-password --profile "$profile" --region "$region" | docker login --username AWS --password-stdin "$registry"
}

# BEGIN_AWS_SSO_CLI

# AWS SSO requires `bashcompinit` which needs to be enabled once and
# only once in your shell.  Hence we do not include the two lines:
#
# autoload -Uz +X compinit && compinit
# autoload -Uz +X bashcompinit && bashcompinit
#
# If you do not already have these lines, you must COPY the lines 
# above, place it OUTSIDE of the BEGIN/END_AWS_SSO_CLI markers
# and of course uncomment it

# __aws_sso_profile_complete() {
#      local _args=${AWS_SSO_HELPER_ARGS:- -L error}
#     _multi_parts : "($(/opt/homebrew/bin/aws-sso ${=_args} list --csv Profile))"
# }
#
# aws-sso-profile() {
#     local _args=${AWS_SSO_HELPER_ARGS:- -L error}
#     if [ -n "$AWS_PROFILE" ]; then
#         echo "Unable to assume a role while AWS_PROFILE is set"
#         return 1
#     fi
#     eval $(/opt/homebrew/bin/aws-sso ${=_args} eval -p "$1")
#     if [ "$AWS_SSO_PROFILE" != "$1" ]; then
#         return 1
#     fi
# }
#
# aws-sso-clear() {
#     local _args=${AWS_SSO_HELPER_ARGS:- -L error}
#     if [ -z "$AWS_SSO_PROFILE" ]; then
#         echo "AWS_SSO_PROFILE is not set"
#         return 1
#     fi
#     eval $(/opt/homebrew/bin/aws-sso ${=_args} eval -c)
# }
#
# compdef __aws_sso_profile_complete aws-sso-profile
# complete -C /opt/homebrew/bin/aws-sso aws-sso

# END_AWS_SSO_CLI
