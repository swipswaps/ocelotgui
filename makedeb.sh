
# Script for creating a .deb file
# Ocelot Computer Services Inc. is the "upstream developer"
# of a tarball (tar.gz) file from which one may construct a
# .deb (Debian) file. Although this script has been known
# to work, it is assumed that users will read it carefully
# before employing it.
# The final step may require special privileges.

# Thank you to https://wiki.debian.org/Packaging/Intro?action=show&redirect=IntroDebianPackaging

set -e

mkdir -p ~/ocelotgui-test
cd ~/ocelotgui-test
rm -r ocelotgui
cp ~/ocelotgui.tar.gz ocelotgui_1.0.0.orig.tar.gz
tar xf ocelotgui_1.0.0.orig.tar.gz
cd ocelotgui                                                 # FLAW!! We wanted it to be ocelotgui_1.0.0

# We already have ocelotgui executables ocelotgui-qt4 + ocelotgui-qt5
# but we don't want to depend on them, they were made with qmake 64-bit.
rm ocelotgui-qt4
rm ocelotgui-qt5

mkdir debian

tee debian/changelog <<- EOF
ocelotgui (1.0.0-1) UNRELEASED; urgency=low

  * Initial release.

 -- Peter Gulutzan <pgulutzan@ocelot.ca>  Mon, 02 May 2016 14:57:44 -0600
EOF

tee debian/compat <<- EOF
9
EOF
tee debian/control <<- EOF
Source: ocelotgui
Maintainer: Peter Gulutzan <pgulutzan@ocelot.ca>
Section: database
Priority: optional
Standards-Version: 3.9.2
Build-Depends: debhelper (>= 9)

Package: ocelotgui
Architecture: any
Depends: ${shlibs:Depends}, ${misc:Depends}
Description: The Ocelot GUI (ocelotgui), a database client, allows users to connect to
 a MySQL or MariaDB DBMS server, enter SQL statements, and receive results.
 Some of its features are: syntax highlighting, user-settable colors
 and fonts for each part of the screen, result-set displays
 with multi-line rows and resizable columns, and a debugger.
EOF
tee debian/copyright <<- EOF
Format: http://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: ocelotgui
Source: ocelot.ca

Files: ocelotgui.cpp ocelotgui.h *.png *.jpg *.pro *.txt *.ui *.htm *.md
Copyright: Copyright 2014 Ocelot Computer Services Inc. <ocelot.ca>
License: GPL-2
 This program is free software; you can redistribute it
 and/or modify it under the terms of the GNU General Public
 License as published by the Free Software Foundation; either
 version 2 of the License, or (at your option) any later
 version.
 .
 This program is distributed in the hope that it will be
 useful, but WITHOUT ANY WARRANTY; without even the implied
 warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 PURPOSE.  See the GNU General Public License for more
 details.
 .
 You should have received a copy of the GNU General Public
 License along with this package; if not, write to the Free
 Software Foundation, Inc., 51 Franklin St, Fifth Floor,
 Boston, MA  02110-1301 USA
 .
 On Debian systems, the full text of the GNU General Public
 License version 2 can be found in the file
 '/usr/share/common-licenses/GPL-2'.

Files: installsql.cpp
Copyright: 2012, Hewlett-Packard Development Company, L.P.
License: GPL-2
  The routine named debug_mdbug_install inside ocelotgui.cpp is taken and modified from
  https://launchpad.net/mdbug, specifically http://bazaar.launchpad.net/~hp-mdbug-team/mdbug/trunk/view/head:/install.sql,
  and therefore MDBug's maker's copyright and GPL version 2 license provisions
  are reproduced below. These provisions apply only for the
  part of the debug_mdbug_install routine which is marked within the program.
  The program as a whole is copyrighted by Ocelot and
  licensed under GPL version 2 as stated above.
  .
  This file is part of MDBug.
  .
  (c) Copyright 2012 Hewlett-Packard Development Company, L.P.
  .
  This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License
  as published by the Free Software Foundation; version 2 of the License.
  .
  This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
  of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
  .
  You should have received a copy of the GNU General Public License along with this program; if not, see
  <http://www.gnu.org/licenses>.
  .
  Linking MDBug statically or dynamically with other modules is making a combined work based on MDBug. Thus, the terms and
  conditions of the GNU General Public License cover the whole combination.
  .
  In addition, as a special exception, the copyright holders of MDBug give you permission to combine MDBug with free
  software programs or libraries that are released under the GNU LGPL and with code included in the standard release
  of Eclipse under the Eclipse Public License version 1.0 (or modified versions of such code, with unchanged license).
  You may copy and distribute such a system following the terms of the GNU GPL for MDBug and the licenses of the other
  code concerned, provided that you include the source code of that other code when and as the GNU GPL requires
  distribution of source code.
  .
  Note that people who make modified versions of MDBug are not obligated to grant this special exception for their
  modified versions; it is their choice whether to do so. The GNU General Public License gives permission to release a
  modified version without this exception; this exception also makes it possible to release a modified version which
  carries forward this exception.

Files: other
Copyright: 2014 Digia Plc and/or its subsidiary(-ies).
License: BSD
   The class named CodeEditor inside this program is taken and modified from
   http://qt-project.org/doc/qt-4.8/widgets-codeeditor.html
   and therefore CodeEditor's maker's copyright and BSD license provisions
   are reproduced below. These provisions apply only for the
   part of the CodeEditor class which is marked within the program.
   The program as a whole is copyrighted by Ocelot and
   licensed under GPL version 2 as stated above.
 **
 ** Copyright (C) 2014 Digia Plc and/or its subsidiary(-ies).
 ** Contact: http://www.qt-project.org/legal
 **
 ** $QT_BEGIN_LICENSE:BSD$
 **
 ** "Redistribution and use in source and binary forms, with or without
 ** modification, are permitted provided that the following conditions are
 ** met:
 **   * Redistributions of source code must retain the above copyright
 **     notice, this list of conditions and the following disclaimer.
 **   * Redistributions in binary form must reproduce the above copyright
 **     notice, this list of conditions and the following disclaimer in
 **     the documentation and/or other materials provided with the
 **     distribution.
 **   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
 **     of its contributors may be used to endorse or promote products derived
 **     from this software without specific prior written permission.
 **
 **
 ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 **
 ** $QT_END_LICENSE$
EOF
# Use echo not tee because the tab must not be converted to spaces
# \043 is octal for #, \041 is the octal for !, \044 is octal for $
echo -e "\043\041/usr/bin/make -f\n%:\n\tdh \044@\n" >> debian/rules
mkdir debian/source
tee debian/source/format <<- EOF
3.0 (quilt)
EOF
debuild -us -uc
sudo dpkg -i ../ocelotgui_1.0.0-1_amd64.deb 

