abstract class FormSubmissionStatus {
  const FormSubmissionStatus();
}

class InitialFormStatus extends FormSubmissionStatus {
  const InitialFormStatus();
}

class FormSubmitting extends FormSubmissionStatus {}

class GoogleFormSubmitting extends FormSubmissionStatus {}

class TwitterFormSubmitting extends FormSubmissionStatus {}

class GitHubFormSubmitting extends FormSubmissionStatus {}

class SubmissionSuccess extends FormSubmissionStatus {}

class ReSendEmailSubmissionSuccess extends FormSubmissionStatus {}

class SubmissionFailed extends FormSubmissionStatus {
  final String exception;
   final String serverError = "Something went wrong during submission. Please try again later.";
  SubmissionFailed(this.exception);
}


