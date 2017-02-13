(use-package org
  :commands (org-mode)
  :bind (("C-c a" . org-agenda)
         ("C-c r" . org-capture))
  :config
  (when (file-exists-p (expand-file-name "~/Google ドライブ/org"))
    (setq org-directory (expand-file-name "~/Google ドライブ/org")))

  ;; Set task name on frame title when clock-in
  (add-hook 'org-clock-in-hook (lambda () (setq frame-title-format  '("*** " org-clock-heading " ***"))))
  (add-hook 'org-clock-out-hook (lambda () (setq frame-title-format "%b")))
  (add-hook 'org-mode-hook 'org-indent-mode)

  (key-chord-define org-mode-map "sl" 'org-store-link)
  (key-chord-define org-mode-map "cg" 'org-clock-goto)
  (auto-fill-mode 0))
