# uportal-setup-scripts
Simple scripts to install build tools and Tomcat for uPortal in a *nix
environment. Mac are popular development platforms, so they will also
be supported.

Only a few scripts, those dealing with account setup and OS packages,
require `root` access as noted below.

uPortal is flexible and with that flexibility comes a plethora of
configurations. Captured in these scripts is a way to set up uPortal
for development, staging and production. There are many other ways.
These scripts may streamline your setup by directly using them, or
they may form a basis of your own custom scripts.

The two targets are a development system that supports multiple
installs and a dedicated server with a single, well-known location.

## Development System
The assumptions we make for a development system are that the scripts
must support multiple directory targets and ownership is a local user
rather than `root`. A typical setup installs the build tools to a local
directory, native libraries are installed in a system directory, and 
multiple Tomcats should be supported.

To capture a developer environment, overrides for some script properties
can be saved in `dev.properties`. See `dev.properties.sample` as an
example.

## Dedicated Server
Server assumptions are that the server or VM is focused on a single
uPortal instance. A typical setup installs almost exclusively to a
single directory. Activities requiring `root` access will be separated
to support cases where such access is restricted.

## Script Overview

### `install-commands.sh` (as root)

Install needed OS commands. The scripts will need `wget` to download
packages and users will need `git` to sync with uPortal repository.

### `create-portal-account.sh` (as root, server-only)
Create Portal account, group and directory. Default name is `uportal`
and the default directory is `/opt/uportal`. Reasoning for this location
is to keep it out of `/home` which may have a limited partition size,
and out of system directories that may cause confusion.

These values can be overridden in `config.properties`.

### `download-tools.sh JDK_OS [download dir]` (as uPortal user)
Download the build tools and Tomcat from Apache Archives. Also downloaded
is Java 8. To select the correct JDK a valid OS architecture needs to be
selected. Valid values are ` linux-i586 linux-x64 macosx-x64 solaris-sparcv9 solaris-x64 windows-i586 windows-x64 `. 
The files are saved in `/opt/uportal` but that can be overridden
by passing the directory as an argument to the script, or setting 
`DOWNLOAD_DIR` in `dev.properties`.

This script is very sensitive to version changes. Most changes can be
managed in `versions.properties`, but a change to URLs may require
a direct change.

### `set-tools.sh JDK_OS [download dir]` (as uPortal user)
Unzip tools and JDK to `/opt/uportal` or to `$TOOLS_DIR` if set in
`dev.properties`. This script has the same arguments as
`download-tools.sh` and should match.

Note: while Tomcat is downloaded in `download-tools.sh` it is not
set with this script. It is set up in the following script.


