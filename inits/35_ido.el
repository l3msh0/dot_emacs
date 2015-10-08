(el-get-bundle elpa:ido-migemo)
(use-package ido-migemo
  :config
  (ido-migemo-mode 1)
  (setq ido-migemo-exclude-command-list '(smex ido-switch-buffer))
  (setq ido-migemo-prompt-string "[MIGEMO] "))
