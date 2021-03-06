{ stdenv, fetchFromGitLab, pkgconfig, cmake, gettext, cairo, pango, pcre
, glib, imlib2, gtk2, libXinerama, libXrender, libXcomposite, libXdamage
, libX11, libXrandr, librsvg, libpthreadstubs, libXdmcp
, libstartup_notification, hicolor-icon-theme, wrapGAppsHook
}:

stdenv.mkDerivation rec {
  name = "tint2-${version}";
  version = "16.4";

  src = fetchFromGitLab {
    owner = "o9000";
    repo = "tint2";
    rev = version;
    sha256 = "1h9l45zimai2hqfcf2y98g4i03imhmvm3mlsld9x99i650kxr5jm";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [ pkgconfig cmake gettext wrapGAppsHook ];

  buildInputs = [ cairo pango pcre glib imlib2 gtk2 libXinerama libXrender
    libXcomposite libXdamage libX11 libXrandr librsvg libpthreadstubs
    libXdmcp libstartup_notification hicolor-icon-theme ];

  postPatch = ''
    substituteInPlace CMakeLists.txt --replace /etc $out/etc
    for f in ./src/launcher/apps-common.c \
             ./src/launcher/icon-theme-common.c \
             ./themes/*tint2rc
    do
      substituteInPlace $f --replace /usr/share/ /run/current-system/sw/share/
    done
  '';

  meta = {
    homepage = https://gitlab.com/o9000/tint2;
    description = "Simple panel/taskbar unintrusive and light (memory, cpu, aestetic)";
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
    maintainers = [ stdenv.lib.maintainers.romildo ];
  };
}
