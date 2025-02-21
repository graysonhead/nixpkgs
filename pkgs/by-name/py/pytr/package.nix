{
  fetchFromGitHub,
  installShellFiles,
  lib,
  python3Packages,
  versionCheckHook,
}:

python3Packages.buildPythonApplication rec {
  pname = "pytr";
  version = "0.3.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "pytr-org";
    repo = "pytr";
    tag = "v${version}";
    hash = "sha256-OFONjJXKkfb6+bQx5fhsadjm9WG62FISznnWL9IEY7I=";
  };

  build-system = with python3Packages; [
    babel
    setuptools
  ];

  dependencies = with python3Packages; [
    babel
    certifi
    coloredlogs
    ecdsa
    packaging
    pathvalidate
    pygments
    requests-futures
    shtab
    websockets
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --cmd pytr \
      --bash <($out/bin/pytr completion bash) \
      --zsh <($out/bin/pytr completion zsh)
  '';

  nativeCheckInputs = [ versionCheckHook ];

  pythonImportsCheck = [ "pytr" ];

  meta = {
    changelog = "https://github.com/pytr-org/pytr/releases/tag/v${version}";
    description = "Use TradeRepublic in terminal and mass download all documents";
    homepage = "https://github.com/pytr-org/pytr";
    license = lib.licenses.mit;
    mainProgram = "pytr";
    maintainers = with lib.maintainers; [ dotlambda ];
  };
}
