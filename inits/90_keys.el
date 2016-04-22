(use-package bind-key
  :config
  (bind-keys*
   ("C-;" . helm-mini))
  (bind-keys
   ("C-h" . delete-backward-char)
   ("<C-f12>" . my/switch-frame-tranparent)
   ("M-?" . help-for-help)
   ("C-t" . other-window)
   ("M-d" . my/kill-word-at-point)
   ("C-x F" . find-function-other-window)
   ("C-+" . text-scale-increase)
   ("C--" . text-scale-decrease)
   ("C-x y" . my/copy-buffer-file-name)))

;;; global

(global-unset-key (kbd "C-\\"))

(global-set-key (kbd "C-x O") (lambda () (interactive) (other-window -1))) ;; back one

(with-eval-after-load 'git-gutter
  (global-set-key (kbd "C-x g n") 'git-gutter:next-diff)
  (global-set-key (kbd "C-x g p") 'git-gutter:previous-diff))

(with-eval-after-load 'pop)
(global-set-key (kbd "C-x l") 'popwin:display-last-buffer)
(global-set-key (kbd "C-x p") 'popwin:stick-popup-window)


;;; emacs-lisp-mode
(define-key emacs-lisp-mode-map (kbd "C-c C-d") 'lispxmp)

;; auto-complete
(with-eval-after-load 'auto-complete
  (define-key ac-mode-map (kbd "M-/") 'auto-complete))

;; php-auto-yasnippets
(with-eval-after-load 'php-mode
  (define-key php-mode-map (kbd "C-c C-y") 'yas/create-php-snippet))

(global-set-key (kbd "M-j")
            (lambda ()
                  (interactive)
                  (join-line -1)))

;;; smartrep
(with-eval-after-load 'smartrep
  (defvar m-o-map (make-keymap))
  (define-key global-map (kbd "M-o") m-o-map)
  (smartrep-define-key
   global-map "M-o" '(("n" . (lambda () (scroll-other-window 1)))
                      ("p" . (lambda () (scroll-other-window -1)))
                      ("N" . 'scroll-other-window)
                      ("P" . (lambda () (scroll-other-window '-)))
                      ("a" . (lambda () (beginning-of-buffer-other-window 0)))
                      ("e" . (lambda () (end-of-buffer-other-window 0)))))

  (smartrep-define-key
   global-map "M-g" '(("n" . 'next-error)
                      ("p" . 'previous-error)
                      ("u" . 'undo)))

  (with-eval-after-load 'org
    (smartrep-define-key org-mode-map "C-c" '(("p" . 'outline-previous-visible-heading)
                                              ("n" . 'outline-next-visible-heading)
                                              ("b" . 'org-backward-heading-same-level)
                                              ("f" . 'org-forward-heading-same-level)
                                              ("u" . 'outline-up-heading)))
    (define-key org-mode-map (kbd "M-*") 'org-mark-ring-goto)
    (define-key org-mode-map (kbd "C-'") 'helm-ls-git-ls)))

;;; key-chord
(key-chord-define-global "cj" 'org-clock-goto)
(key-chord-define-global "fj" 'shell-pop)
(key-chord-define-global "jd" 'dired-jump)
(key-chord-define-global "jx" 'direx:jump-to-directory-other-window)
(key-chord-define-global "mw" 'my/mirror-window)
(key-chord-define-global "mt" 'my/transpose-buffers)
(key-chord-define-global "jw" 'double-dired)
(key-chord-define-global "hr" 'highlight-symbol-query-replace)
(key-chord-define-global "hm" 'helm-mini)
(key-chord-define-global "d." 'my/kill-enclosed-object)
(key-chord-define-global "vm" 'view-mode)
(key-chord-define-global "gl" 'helm-ls-git-ls)
(key-chord-define-global "gn" 'git-gutter:next-hunk)
(key-chord-define-global "gp" 'git-gutter:previous-hunk)
(key-chord-define-global "pr" 'helm-apropos)

(key-chord-define-global "jw" 'ace-jump-word-mode)
(key-chord-define-global "jc" 'ace-jump-char-mode)
(key-chord-define-global "jk" 'ace-jump-line-mode)

(key-chord-define-global "rb" (lambda () (interactive) (revert-buffer-with-coding-system 'utf-8)))

(key-chord-define-global "gs" 'geben-end)
(key-chord-define-global "gb" 'geben)

(key-chord-define-global "mx" 'helm-M-x)
(key-chord-define-global "sm" 'popwin:messages)

(key-chord-define-global "ht" 'highlight-symbol-at-point)
(global-set-key (kbd "M-n") 'highlight-symbol-next)
(global-set-key (kbd "M-p") 'highlight-symbol-prev)


;;; twittering-mode
(eval-after-load 'twittering-mode
  '(progn
     (define-key twittering-mode-map (kbd "F") 'twittering-favorite)
     (define-key twittering-mode-map (kbd "f") nil)
     (define-key twittering-mode-map (kbd "C-c C-l") nil)
     (define-key twittering-mode-map (kbd ">") 'end-of-buffer)
     (define-key twittering-mode-map (kbd "<") 'beginning-of-buffer)
     (define-key twittering-mode-map (kbd "M-n") 'twittering-switch-to-next-timeline)
     (define-key twittering-mode-map (kbd "M-p") 'twittering-switch-to-previous-timeline)))

(eval-after-load 'anzu
  '(progn
     (key-chord-define-global "r." 'anzu-query-replace-at-cursor-thing)))

(key-chord-define-global "g." 'ag)
(key-chord-define-global "g," 'ag-project)

;;; clojure-mode
(with-eval-after-load 'clojure-mode
  (define-key clojure-mode-map (kbd "<C-return>") 'lisp-eval-last-sexp))

;;; sp
(with-eval-after-load 'smartparens
    (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-slurp-sexp)
    (define-key smartparens-mode-map (kbd "C-<right>") 'sp-forward-barf-sexp)
    (key-chord-define smartparens-mode-map "rw" 'sp-rewrap-sexp))

;;; helm
(with-eval-after-load 'helm
  (global-set-key (kbd "C-c ?") 'helm-descbinds))
