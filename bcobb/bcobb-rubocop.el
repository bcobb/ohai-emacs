(defun bcobb-projectile-bundler-p ()
  (when (projectile-project-p)
    (let ((file-path (concat (projectile-project-root) "Gemfile.lock")))
      (file-exists-p file-path))))

(defun bcobb-projectile-project-uses-rubocop-p ()
  (when (bcobb-projectile-bundler-p)
    (let ((contents (with-temp-buffer (insert-file-contents (concat (projectile-project-root) "Gemfile.lock"))
                                      (buffer-string))))
      (string-match-p "rubocop" contents))))

(defun bcobb-flycheck-rubocop-wrapper (command)
  (if (bcobb-projectile-project-uses-rubocop-p)
      (append '("bundle" "exec") command)
    command))

(setq flycheck-command-wrapper-function 'bcobb-flycheck-rubocop-wrapper)

(provide 'bcobb-rubocop)
