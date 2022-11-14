class RepositoryResult {
  ResultStatus resultStatus;
  var resultData;
}

enum ResultStatus {
  sucess,
  error,
  connectionFail,
}
