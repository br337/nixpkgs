{ lib, buildPythonPackage, fetchPypi, python
, django, ply }:

buildPythonPackage rec {
  pname = "djangoql";
  version = "0.17.1";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-TwU9ASjij0EpJuLakCc19L3Lq1wI1Dvk3+/XR/yi6W4=";
  };

  propagatedBuildInputs = [ ply ];

  nativeCheckInputs = [ django ];

  checkPhase = ''
    export PYTHONPATH=test_project:$PYTHONPATH
    ${python.executable} test_project/manage.py test core.tests
  '';

  meta = with lib; {
    description = "Advanced search language for Django";
    homepage = "https://github.com/ivelum/djangoql";
    license = licenses.mit;
    maintainers = with maintainers; [ erikarvstedt ];
  };
}
