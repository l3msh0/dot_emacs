(el-get-bundle elpa:undo-tree)
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

(el-get-bundle wgrep)

(el-get-bundle ag)
(use-package ag
  :commands (ag)
  :config
  (use-package wgrep)
  (bind-key "C-x C-q" 'wgrep-change-to-wgrep-mode ag-mode-map)
  (define-key ag-mode-map (kbd "C-x C-q") 'wgrep-change-to-wgrep-mode))

(el-get-bundle anzu)
(use-package anzu
  :bind (("C-8" . anzu-query-replace-regexp)
         ("C-*" . anzu-query-replace))
  :config
  (global-anzu-mode 1))

(el-get-bundle ddskk)
(use-package ddskk
  :bind ("C-x C-j" . skk-mode)
  :config
  (bind-key* "C-j" 'skk-kakutei))

(el-get-bundle smartrep)
(use-package smartrep)

(el-get-bundle open-junk-file)
(use-package open-junk-file
  :bind ("C-x C-z" . open-junk-file))

(el-get-bundle smex)
(use-package smex
  :bind ("M-x" . smex))

(el-get-bundle highlight-symbol)
(use-package highlight-symbol
  :commands (highlight-symbol-mode)
  :config
  (add-hook 'find-file-hook 'highlight-symbol-mode))

(el-get-bundle migemo)
(use-package migemo
  :config
  ;; Remember to place symbolic link!!
  (setq migemo-dictionary (concat user-emacs-directory "migemo/utf-8/migemo-dict"))
  (migemo-init))

(el-get-bundle ace-jump-mode)
(use-package ace-jump-mode
  :commands (ace-jump-mode ace-jump-word-mode ace-jump-char-mode ace-jump-line-mode))
