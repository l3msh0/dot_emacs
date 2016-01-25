;;; General
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;;; flycheck
(el-get-bundle flycheck)

;;; smartparens
(el-get-bundle smartparens)
(use-package smartparens
  :config
  (smartparens-global-mode 1)
  (show-smartparens-global-mode 1)

  (sp-local-pair 'minibuffer-inactive-mode "'" nil :actions nil)
  ; html-mode
  (sp-with-modes '(html-mode sgml-mode web-mode)
    (sp-local-pair "<" ">"))
  ; lisp modes
  (sp-with-modes sp--lisp-modes
    (sp-local-pair "(" nil :bind "C-("))
  ; markdown modes
  (sp-with-modes '(markdown-mode gfm-mode rst-mode)
    (sp-local-pair "*" "*" :bind "C-*")
    (sp-local-tag "2" "**" "**")
    (sp-local-tag "s" "```scheme" "```")
    (sp-local-tag "<"  "<_>" "</_>" :transform 'sp-match-sgml-tags))

  (define-key sp-keymap (kbd "C-M-f") 'sp-forward-sexp)
  (define-key sp-keymap (kbd "C-M-b") 'sp-backward-sexp)
  (define-key sp-keymap (kbd "C-M-d") 'sp-down-sexp)
  (define-key sp-keymap (kbd "C-M-a") 'sp-backward-down-sexp)
  (define-key sp-keymap (kbd "C-S-a") 'sp-beginning-of-sexp)
  (define-key sp-keymap (kbd "C-S-d") 'sp-end-of-sexp)
  (define-key sp-keymap (kbd "C-M-e") 'sp-up-sexp)
  (define-key emacs-lisp-mode-map (kbd ")") 'sp-up-sexp)
  (define-key sp-keymap (kbd "C-M-u") 'sp-backward-up-sexp)
  (define-key sp-keymap (kbd "C-M-t") 'sp-transpose-sexp)
  (define-key sp-keymap (kbd "C-M-n") 'sp-next-sexp)
  (define-key sp-keymap (kbd "C-M-p") 'sp-previous-sexp)
  (define-key sp-keymap (kbd "C-M-k") 'sp-kill-sexp)
  (define-key sp-keymap (kbd "C-M-w") 'sp-copy-sexp)
  (define-key sp-keymap (kbd "M-<delete>") 'sp-unwrap-sexp)
  (define-key sp-keymap (kbd "M-<backspace>") 'sp-backward-unwrap-sexp)
  (define-key sp-keymap (kbd "M-<right>") 'sp-forward-slurp-sexp)
  (define-key sp-keymap (kbd "M-<left>") 'sp-forward-barf-sexp)
  (define-key sp-keymap (kbd "M-S-<left>") 'sp-backward-slurp-sexp)
  (define-key sp-keymap (kbd "M-S-<right>") 'sp-backward-barf-sexp)
  (define-key sp-keymap (kbd "M-D") 'sp-splice-sexp)
  (define-key sp-keymap (kbd "C-M-<delete>") 'sp-splice-sexp-killing-forward)
  (define-key sp-keymap (kbd "C-M-<backspace>") 'sp-splice-sexp-killing-backward)
  (define-key sp-keymap (kbd "C-S-<backspace>") 'sp-splice-sexp-killing-around)
  (define-key sp-keymap (kbd "C-]") 'sp-select-next-thing-exchange)
  (define-key sp-keymap (kbd "C-<left_bracket>") 'sp-select-previous-thing)
  (define-key sp-keymap (kbd "C-M-]") 'sp-select-next-thing)
  (define-key sp-keymap (kbd "M-F") 'sp-forward-symbol)
  (define-key sp-keymap (kbd "M-B") 'sp-backward-symbol)
  (define-key sp-keymap (kbd "H-t") 'sp-prefix-tag-object)
  (define-key sp-keymap (kbd "H-p") 'sp-prefix-pair-object)
  (define-key sp-keymap (kbd "H-s c") 'sp-convolute-sexp)
  (define-key sp-keymap (kbd "H-s a") 'sp-absorb-sexp)
  (define-key sp-keymap (kbd "H-s e") 'sp-emit-sexp)
  (define-key sp-keymap (kbd "H-s p") 'sp-add-to-previous-sexp)
  (define-key sp-keymap (kbd "H-s n") 'sp-add-to-next-sexp)
  (define-key sp-keymap (kbd "H-s j") 'sp-join-sexp)
  (define-key sp-keymap (kbd "H-s s") 'sp-split-sexp))

;;; editorconfig
(el-get-bundle editorconfig)
(use-package editorconfig)

;;; web-mode
(el-get-bundle web-mode)
(el-get-bundle emmet-mode)
(use-package web-mode
  :mode (("\\.html\\'" . web-mode))
  :config
  (bind-key "C-c C-v" 'browse-url-of-buffer web-mode-map)
  (use-package emmet-mode
    :config
    (add-hook 'web-mode-hook 'emmet-mode)
    (bind-key "M-RET" 'emmet-expand-line emmet-mode-keymap)))

;;; yasnippet
(el-get-bundle yasnippet)
(use-package yasnippet
  :config
  (yas-global-mode 1))

;;; auto-complete
(el-get-bundle auto-complete)
(use-package auto-complete
  :config
  (global-auto-composition-mode 1)
  (ac-config-default)

  ;;; advice for whitespace-mode conflict
  (defvar my-prev-whitespace-mode nil)
  (make-variable-buffer-local 'my-prev-whitespace-mode)

  (defadvice popup-draw (before my-turn-off-whitespace)
    "Turn off whitespace mode before showing popup"
    (make-local-variable 'my-prev-whitespace-mode)
    (when global-whitespace-mode
      (setq my-prev-whitespace-mode t)
      (global-whitespace-mode 0)))

  (defadvice popup-delete (after my-restore-whitespace)
    "Restore previous whitespace mode when deleting popup"
    (when my-prev-whitespace-mode
      (global-whitespace-mode 1)
      (setq my-prev-whitespace-mode nil)))

  (ad-activate 'popup-draw)
  (ad-activate 'popup-delete))

;;; PHP
(el-get-bundle php-mode)
(el-get-bundle php-eldoc)
(use-package php-mode
  :mode (("\\.php$" . php-mode))
  :config
  (use-package php-eldoc)
  (defun my-php-mode-hook ()
    (linum-mode 1)
    (flycheck-mode 1)
    (setq indent-tabs-mode t)
    (highlight-symbol-mode 1))
  (add-hook 'php-mode-hook 'my-php-mode-hook))


(el-get-bundle geben)
(use-package geben
  :commands (geben)
  :config
  (defun my-php-debug ()
  "Run current PHP script for debugging with geben"
  (interactive)
  (call-interactively 'geben)
  (shell-command
   (concat "XDEBUG_CONFIG='idekey=my-php-54' " php-executable " " (buffer-file-name) " &"))))

;;; JavaScript
(el-get-bundle js2-mode)
(use-package js2-mode
  :mode (("\\.js$" . js2-mode)))

;;; Clojure
(setq nrepl-hide-special-buffers t)
(el-get-bundle cider)
(use-package cider
  :config
  (add-hook 'clojure-mode-hook 'cider-mode)
  (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
  (add-hook 'cider-repl-mode-hook 'smartparens-strict-mode))

;;; Golang
(el-get-bundle go-mode)
(use-package go-mode
  :mode (("\\.go$" . go-mode))
  :config
  (add-hook 'go-mode-hook 'flycheck-mode))

(el-get-bundle go-autocomplete)
(use-package go-autocomplete)

(el-get-bundle go-eldoc)
(use-package go-eldoc
  :config
  (add-hook 'go-mode-hook 'go-eldoc-setup))

;;; C#
(el-get-bundle csharp-mode)
(el-get-bundle omnisharp-mode)
(use-package csharp-mode
  :mode (("\\.cs$" . csharp-mode))
  :config
  (use-package omnisharp)
  (add-hook 'csharp-mode-hook
            (lambda ()
              (flycheck-mode 1)
              (omnisharp-mode 1)))
  (bind-keys :map csharp-mode-map
             ("C-c C-j" . omnisharp-go-to-definition)
             ("C-c C-8" . pop-tag-mark)))

(el-get-bundle lispxmp)
(use-package lispxmp)
