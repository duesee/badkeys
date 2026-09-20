let
  toml = builtins.fromTOML (builtins.readFile ./../pyproject.toml);
in
{
  lib,
  buildPythonPackage,
  cryptography,
  gmpy2,
  paramiko,
  setuptools-scm,
}:
buildPythonPackage {
  pname = toml.project.name;
  # TODO: Obtain from dynamic pyproject?
  # version = toml.project.version;
  version = "0.0.20";
  pyproject = true;

  src = lib.fileset.toSource {
    root = ./..;
    fileset = lib.fileset.unions [
      ./../pyproject.toml
      ./../badkeys
    ];
  };

  build-system = [
    setuptools-scm
  ];

  dependencies = [
    cryptography
    gmpy2
    paramiko
  ];
}
