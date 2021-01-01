(defun debug-message (&rest args)
  (setq inhibit-message 't)
  (apply 'message args)
  (setq inhibit-message nil))

(defun enable-minor-mode (my-pair)
  "Enable minor mode if filename match the regexp.  MY-PAIR is a cons cell (regexp . minor-mode)."
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
          (funcall (cdr my-pair)))))

(provide 'bcobb-lib)
