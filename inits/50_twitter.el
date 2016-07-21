(el-get-bundle twittering-mode)
(use-package twittering-mode
  :commands (twit)
  :config
  (add-hook 'twittering-mode-hook
            (lambda ()
              (twittering-icon-mode 1)
              (twittering-toggle-activate-buffer)))
  (fmakunbound 'twittering-update-lambda)
  (fmakunbound 'twittering-jojo-mode)
  (bind-keys :map twittering-mode-map
             ("f" . twittering-switch-to-next-timeline)
             ("b" . twittering-switch-to-previous-timeline)
             ("F" . twittering-favorite))
  (bind-key "C-, t" 'twittering-update-status-interactive))
