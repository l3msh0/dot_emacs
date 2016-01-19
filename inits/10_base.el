;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Language Enviornment
;;;

(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; Font & Theme
;;;

(el-get-bundle elpa:noctilux-theme)
(load-theme 'wombat)

(when (memq window-system '(mac ns))
  ;; fonts
  (create-fontset-from-ascii-font "Migu 1M-20:weight=medium:slant=normal" nil "migu1m")
  (set-fontset-font "fontset-migu1m" 'unicode (font-spec :family "Migu 1M" ) nil 'append)
  (add-to-list 'default-frame-alist '(font . "fontset-migu1m"))
  ;; path
  (el-get-bundle! exec-path-from-shell)
  (use-package exec-path-from-shell
    :config (exec-path-from-shell-initialize)))

;; transparent
(add-to-list 'default-frame-alist '(alpha . 93))

;; variables
(setq-default indent-line-function 'indent-relative-maybe)

(put 'erase-buffer 'disabled nil)
;; built-in minor-mode
(global-hl-line-mode 1)
(column-number-mode 1)
(line-number-mode 1)
(scroll-bar-mode 0)
(show-paren-mode 1)
(global-whitespace-mode 1)
(display-time-mode 1)
(auto-fill-mode 0)
(menu-bar-mode 0)
(tool-bar-mode 0)
(cua-mode 0)
(ido-mode 1)
(which-function-mode 1)

;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)

;; hook
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; regard camelCase as separated word
(let (upper lower)
  (setq upper (get-unused-category))
  (define-category upper "Upper case")
  (modify-category-entry (cons ?A ?Z) upper)

  (setq lower (get-unused-category))
  (define-category lower "Lower case")
  (modify-category-entry (cons ?a ?z) lower)

  (add-to-list 'word-separating-categories (cons lower upper)))

; Problem with TRAMP mode
; Control Path too long error
; TMPDIR variable is really large
; http://lists.macosforge.org/pipermail/macports-tickets/2011-June/084295.html
(setenv "TMPDIR" "/tmp")

(use-package server
  :init (server-start)
  :config
  (add-hook 'server-visit-hook
            (function (lambda ()
                        (set-buffer-file-coding-system 'utf-8)
                        (local-set-key (kbd "C-c C-c") 'server-edit)))))
