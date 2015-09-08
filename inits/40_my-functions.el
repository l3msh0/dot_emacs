(defun my/mirror-window ()
  (interactive)
  (let ((neighbor (save-window-excursion (other-window 1)
                                         (current-buffer))))
    (switch-to-buffer neighbor)))

(defun my/transpose-buffers (arg)
  "Transpose the buffers shown in two windows."
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))


(defun unicode-unescape-region (start end)
  "指定した範囲のUnicodeエスケープ文字(\\uXXXX)をデコードする."
  (interactive "*r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "\\\\u\\([[:xdigit:]]\\{4\\}\\)" nil t)
      (replace-match (string (unicode-char (string-to-number (match-string 1) 16))) nil t))))

(defun unicode-escape-region (&optional start end)
  "指定した範囲の文字をUnicodeエスケープする."
  (interactive "*r")
  (save-restriction
    (narrow-to-region start end)
    (goto-char (point-min))
    (while (re-search-forward "." nil t)
      (replace-match (format "\\u%04x" (char-unicode (string-to-char (match-string 0)))) nil t))))

(defun char-unicode (char) (encode-char char 'ucs))
(defun unicode-char (code) (decode-char 'ucs code))

;; copy buffer file name
(defun my/copy-buffer-file-name ()
  "Copy buffer file name"
  (interactive)
  (if buffer-file-name
      (progn
        (kill-new buffer-file-name)
        (message buffer-file-name))
    (message "the buffer is not bound to any file")))
(global-set-key (kbd "C-x y") 'my/copy-buffer-file-name)

;; kill word at point even if a cursor is not at the beginning
(defun my/kill-word-at-point ()
      (interactive)
      (let ((char (char-to-string (char-after (point)))))
        (cond
         ((string= " " char) (delete-horizontal-space))
         ((string-match "[\t\n -@\[-`{-~]" char) (kill-word 1))
         (t (forward-char) (backward-word) (kill-word 1)))))

(defun toggle-indent-tabs-mode ()
  (interactive)
  (setq indent-tabs-mode (not indent-tabs-mode))
  (message "%s" indent-tabs-mode))


(defun my/kill-enclosed-object ()
  (interactive)
  (save-excursion
    (destructuring-bind (&key beg end op cl prefix) (sp-beginning-of-sexp)
      ;; TODO op cl prefixは不要なので消したい
      (kill-region (1+ beg) (1- end)))))

(defun my/switch-frame-tranparent ()
  (interactive)
  (if (= 100 (frame-parameter nil 'alpha))
      (modify-frame-parameters nil '((alpha . 93)))
    (modify-frame-parameters nil '((alpha . 100)))))

(defun my/dired-do-quicklook ()
  "In dired, preview with Quick Look."
  (interactive)
  (let ((file (dired-get-filename))
        (process (get-process "qlmanage_ps")))
    (if process
        (kill-process process)
      (start-process "qlmanage_ps" nil "qlmanage" "-p" file))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; advice
;;;

(defadvice quit-window (before quit-window-always-kill)
  "When running `quit-window', always kill the buffer."
  (ad-set-arg 0 t))
(ad-activate 'quit-window)
