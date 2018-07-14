(defun debug-message (&rest args)
  (setq inhibit-message 't)
  (apply 'message args)
  (setq inhibit-message nil))

(defun inspect-exec-path ()
  (debug-message "---- exec-path ----")
  (dolist (el exec-path) (debug-message el))
  (debug-message "---- o ----"))

(provide 'bcobb-lib)
