#!/bin/bash

set -eo pipefail

read -d '' erl_code <<- EOF || true
	RootDir = code:root_dir(),
	OtpRel = erlang:system_info(otp_release),
	OtpVerFile = filename:join([RootDir, "releases",
	                            OtpRel, "OTP_VERSION"]),
	{ok, OtpVer} = file:read_file(OtpVerFile),
	io:format("::set-output name=otp-version::~s", [OtpVer]),
	init:stop().
EOF

erl -eval "$erl_code" -noshell
