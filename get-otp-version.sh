#!/bin/bash

set -eo pipefail

read -d '' erl_code <<- EOF || true
	RootDir = code:root_dir(),
	OtpRel = erlang:system_info(otp_release),
	OtpVerFile = filename:join([RootDir, "releases",
	                            OtpRel, "OTP_VERSION"]),
	io:format("~s", [OtpVerFile]),
	init:stop().
EOF

otp_version_file="$(erl -eval "$erl_code" -noshell)"
otp_version="$(cat "$otp_version_file")"
echo "::set-output name=otp-version::${otp_version}"
