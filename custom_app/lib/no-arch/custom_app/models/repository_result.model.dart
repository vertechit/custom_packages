class RepositoryResult {
  late ResultStatus resultStatus;
  var resultData;
}

enum ResultStatus {
  sucess,
  error,
  connectionFail,
}
