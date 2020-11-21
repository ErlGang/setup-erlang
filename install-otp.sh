#!/bin/bash

## to test this script run:
##   RUNNER_TEMP="." GITHUB_PATH="gh_path" ./install-otp.sh 17.0

set -eo pipefail

cd "$RUNNER_TEMP"

otp="$1"
os="$(lsb_release -si)-$(lsb_release -sr)"
otp_tar="https://repo.hex.pm/builds/otp/${os,,}/OTP-${otp}.tar.gz"
otp_dir="${PWD}/.setup-erlang/OTP-${otp}"

echo "Downloading '${otp_tar}'"
wget -q -O otp.tar.gz "$otp_tar"

echo "Creating OTP directory '${otp_dir}'"
mkdir -p "$otp_dir"

echo "Extracting downloaded tar file"
tar zxf otp.tar.gz -C "$otp_dir" --strip-components=1
rm otp.tar.gz

echo "Installing Erlang"
"${otp_dir}/Install" -sasl "$otp_dir"

echo "Adding '${otp_dir}/bin' to GITHUB_PATH"
echo "${otp_dir}/bin" >> "$GITHUB_PATH"

## returning otp-version output value
otp_version="$(cat "${otp_dir}/releases/"*"/OTP_VERSION")"
echo "::set-output name=otp-version::${otp_version}"
