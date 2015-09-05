(el-get-bundle twittering-mode)
(use-package twittering-mode
  :config
  (add-hook 'twittering-mode-hook
            (lambda ()
              (twittering-icon-mode 1))))
