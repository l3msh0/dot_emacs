(el-get-bundle git-gutter)
(use-package git-gutter
  :config
  (global-git-gutter-mode 1))

(el-get-bundle magit)
(use-package magit
  :commands (magit-status))
