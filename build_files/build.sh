#!/bin/bash

# set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

COPY system_files/desktop/niri / \
     r8152 /


RUN dnf5 -y copr enable avengemedia/dms && \
    dnf5 -y install \
        kernel-devel \
        niri \
        dms && \
    dnf5 -y copr disable avengemedia/dms
    # systemctl --user add-wants niri.service dms
RUN cd /r8152
RUN make all
RUN rm -rf /r8152
RUN dnf5 -y remove kernel-devel


# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

# systemctl enable podman.socket
