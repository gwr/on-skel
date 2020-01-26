#
# CDDL HEADER START
#
# The contents of this file are subject to the terms of the
# Common Development and Distribution License (the "License").
# You may not use this file except in compliance with the License.
#
# You can obtain a copy of the license at usr/src/OPENSOLARIS.LICENSE
# or http://www.opensolaris.org/os/licensing.
# See the License for the specific language governing permissions
# and limitations under the License.
#
# When distributing Covered Code, include this CDDL HEADER in each
# file and include the License file at usr/src/OPENSOLARIS.LICENSE.
# If applicable, add the following below this CDDL HEADER, with the
# fields enclosed by brackets "[]" replaced with your own identifying
# information: Portions Copyright [yyyy] [name of copyright owner]
#
# CDDL HEADER END
#
# Copyright (c) 2005, 2010, Oracle and/or its affiliates. All rights reserved.
# Copyright 2012 Joshua M. Clulow <josh@sysmgr.org>
# Copyright 2013 Nexenta Systems, Inc. All rights reserved.
#

#	Configuration variables for the runtime environment of the nightly
# build script and other tools for construction and packaging of releases.
# This script is sourced by 'nightly' and 'bldenv' to set up the environment.
# See illumos-gate/usr/src/tools/env for details.
export NIGHTLY_OPTIONS='-DCFlnpr'

# CODEMGR_WS - where is your workspace
export CODEMGR_WS=`git rev-parse --show-toplevel`

# This is a variable for the rest of the script - GATE doesn't matter to
# nightly itself.
GATE=`basename ${CODEMGR_WS}`

# Compilers may be specified using the following variables:
# PRIMARY_CC	- primary C compiler
# PRIMARY_CCC	- primary C++ compiler
#
# SHADOW_CCS    - list of shadow C compilers
# SHADOW_CCCS	- list of shadow C++ compilers
#
# Each entry has the form <name>,<path to binary>,<style> where name is a
# free-form name (possibly used in the makefiles to guard options), path is
# the path to the executable.  style is the 'style' of command line taken by
# the compiler, currently either gnu (or gcc) or sun (or cc), which is also
# used by Makefiles to guard options.
#
# __SUNC and __GNUC must still be set to reflect the style of the primary
# compiler (and to influence the default primary, otherwise)
#
# for example:
# export PRIMARY_CC=gcc4,/opt/gcc/4.4.4/bin/gcc,gnu
# export PRIMARY_CCC=gcc4,/opt/gcc/4.4.4/bin/g++,gnu
# export SHADOW_CCS=studio12,/opt/SUNWspro/bin/cc,sun
# export SHADOW_CCCS=studio12,/opt/SUNWspro/bin/CC,sun
#
# There can be several space-separated entries in SHADOW_* to run multiple
# shadow compilers.
#
# To disable shadow compilation, unset SHADOW_* or set them to the empty string.
#
export GNUC_ROOT=/usr/gcc/7
export PRIMARY_CC=gcc7,$GNUC_ROOT/bin/gcc,gnu
export PRIMARY_CCC=gcc7,$GNUC_ROOT/bin/g++,gnu
export SHADOW_CCS=gcc4,/opt/gcc/4.4.4/bin/gcc,gnu
export SHADOW_CCCS=gcc4,/opt/gcc/4.4.4/bin/g++,gnu

# Maximum number of dmake jobs.  Small WS -- keep it simple.
export DMAKE_MAX_JOBS=4

# You should not need to change the next three lines
export ATLOG="$CODEMGR_WS/log"
export LOGFILE="$ATLOG/nightly.log"
export MACH="$(uname -p)"

# where is the proto area etc.
export ROOT="$CODEMGR_WS/proto/root_${MACH}"
export SRC="$CODEMGR_WS/usr/src"
export MULTI_PROTO="no"

#
# Build environment variables, including version info for mcs, etc.
# We want the git changeset hash.
GIT_REV=`git rev-parse --short=10 HEAD`
export VERSION="${GATE}:${GIT_REV}"
export ONNV_BUILDNUM=152

# export RELEASE='5.11'
# export RELEASE_DATE='October 2007'

# Package creation variables.
export PKGARCHIVE="${CODEMGR_WS}/packages/${MACH}/nightly"
# export PKGPUBLISHER_REDIST='on-redist'

# Package manifest format version.
export PKGFMT_OUTPUT='v1'

# Disable shadow compilation.
export CW_NO_SHADOW='1'

# Build tools - don't change these unless you know what you're doing.
export BUILD_TOOLS=/opt
export ONBLD_TOOLS=/opt/onbld

# see usr/src/pkg
# export PKGPUBLISHER=on-skel
