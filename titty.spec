%define name titty
%define version 0.1.0
%define unmangled_version 0.1.0
%define release 1

Summary: Terminal emulator based on kitty
Name: %{name}
Version: %{version}
Release: %{release}
Source0: https://github.com/kohnish/titty/archive/refs/heads/master.zip
License: GPLv3
Group: Development/Libraries
BuildRequires: gcc harfbuzz-devel cmake pkg-config lcms2-devel wayland-devel wayland-protocols-devel python3-devel dbus-devel libxkbcommon-devel libxkbcommon-x11-devel fontconfig-devel python3-setuptools

%description
Terminal emulator based on kitty not titties

%prep
%setup -n titty-master
ls
pwd

%build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j
../fix-proj.sh `pwd`/../ 1
sh -c "cd real_root && python3 setup.py build"

%install
cd build/real_root
python3 setup.py install --single-version-externally-managed -O1 --root=$RPM_BUILD_ROOT --record=INSTALLED_FILES

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
/usr/bin/titty
/usr/lib/debug/usr/lib/python*/site-packages/titty/
/usr/lib/python*/site-packages/titty*
/usr/lib/python*/site-packages/titty
