;;; -*- lexical-binding: t -*-

;;; bcobb-logbook.el --- keep a logbook in Emacs

;; Inspiration:
;;   - https://routley.io/tech/2017/11/23/logbook.html
;;   - https://github.com/CoralineAda/lftm

(defgroup logbook nil
  "logbook"
  :group 'local)

(defcustom logbook-directory (expand-file-name "~/.logbook")
  "Path to directory which contains logbook files"
  :type 'directory
  :safe 'stringp
  :group 'logbook)

(defun logbook--directory ()
  (expand-file-name
   (file-name-as-directory logbook-directory)))

(defun logbook--full-path (name &optional ext)
  (let ((effective-ext (or ext "")))
    (concat
     (logbook--directory)
     name
     effective-ext)))

(defun logbook--day-of-month (&optional reference)
  (string-to-number (s-trim (format-time-string "%e" reference))))

(defun logbook--day-of-week (&optional reference)
  (string-to-number (s-trim (format-time-string "%u" reference))))

(defun logbook--days-in-seconds (n)
  (* n 24 60 60))

(defun logbook--n-days-ago (n &optional reference)
  (time-add (or reference (current-time)) (* -1 (logbook--days-in-seconds n))))

(defun logbook--beginning-of-month-p (&optional reference)
  (< (logbook--day-of-month reference) 7))

(defun logbook--week-includes-last-month-p (&optional reference)
  (> (logbook--day-of-week reference) (logbook--day-of-month reference)))

(defun logbook--effective-moment (&optional reference)
  (if (and (logbook--beginning-of-month-p reference)
           (logbook--week-includes-last-month-p reference))
      (logbook--n-days-ago (logbook--day-of-month reference) reference)
    (let ((now (or reference (current-time))))
      (logbook--n-days-ago (- (logbook--day-of-week now) 1) now))))

(defun logbook--container (&optional reference)
  (let ((month (format-time-string "%Y-%m" (logbook--effective-moment reference))))
    (logbook--full-path month)))

(defun logbook--week-header-content ()
  (let ((week-start (format-time-string "%B %-d, %Y" (logbook--effective-moment))))
    (concat "Week of " week-start)))

(defun logbook--has-week-header-p ()
  (string-match-p (logbook--week-header-content) (buffer-string)))

(defun logbook--day-header-content ()
  (format-time-string "%F, %A"))

(defun logbook--has-day-header-p ()
  (string-match-p (logbook--day-header-content) (buffer-string)))

(defun logbook-open ()
  (interactive)
  (let ((week (s-trim (format-time-string "%F" (logbook--effective-moment))))
        (container (logbook--container)))
    (make-directory container 't)
    (find-file
     (concat (file-name-as-directory container)
             week
             ".markdown"))
    (when (not (logbook--has-week-header-p))
      (insert (concat "# " (logbook--week-header-content))))
    (when (not (logbook--has-day-header-p))
      (insert "\n\n")
      (insert (concat "## " (logbook--day-header-content)))
      (insert "\n\n"))
    (save-buffer)))

(defun logbook-entries ()
  (interactive)
  (dired (logbook--container)))

(provide 'bcobb-logbook)
