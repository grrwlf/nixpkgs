{ stdenv, postfix, writeText, coreutils, ... } :
stdenv.mkDerivation {
  name = "sasl_passwd";
  builder = writeText "builder.sh" ''
    ${coreutils}/bin/mkdir $out
    echo '[smtp.gmail.com]:587 grrwlf@gmail.com:lekam_72_radius' > $out/sasl_passwd
    ${coreutils}/bin/chmod 600 $out/sasl_passwd
  '';
}
