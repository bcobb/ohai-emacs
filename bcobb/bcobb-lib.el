(defun debug-message (&rest args)
  (setq inhibit-message 't)
  (apply 'message args)
  (setq inhibit-message nil))

(provide 'bcobb-lib)
