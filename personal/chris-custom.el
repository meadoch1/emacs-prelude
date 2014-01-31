;; recentf stuff
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; Don't turn on linum-mode by default, it crashes org-mode. Ok to
;; turn it on for various modes, however.
(require 'linum)

(defun enable-linum-mode ()
  (linum-mode t))

; ----------------------------------------------------------------------
; Automatically enable linum mode for various modes
(setq modes-to-hook-with-linum '(c-mode-hook
   csv-mode-hook
   emacs-lisp-mode-hook
   coffee-mode-hook
   feature-mode-hook
   java-mode-hook
   js-mode-hook
   javascript-mode-hook
   espresso-mode-hook
   haml-mode-hook
   lisp-mode-hook
   nxml-mode-hook
   php-mode-hook
   ruby-mode-hook
   sass-mode-hook
   scala-mode-hook
   scss-mode-hook
   sh-mode-hook
   text-mode-hook
   textile-mode-hook
   xml-mode-hook
   yaml-mode-hook))

(defun hook-linum-mode (mode)
  (add-hook mode 'enable-linum-mode))

(while modes-to-hook-with-linum
  (hook-linum-mode (car modes-to-hook-with-linum))
  (setq modes-to-hook-with-linum (cdr modes-to-hook-with-linum)))
; End enable linum mode for various modes
; ----------------------------------------------------------------------

(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset))))))

; ----------------------------------------------------------------------
; Commenting
(require 'newcomment)
(global-set-key (kbd "\C-c /") 'comment-dwim)
(global-set-key (kbd "\C-c #") 'comment-dwim)
; end Commenting
; ----------------------------------------------------------------------

(global-set-key "\M-g" 'goto-line)

(setq
 indent-region-mode t)

(global-set-key "\C-c\C-d" 'dash-at-point)

(require 'grizzl)
 (projectile-global-mode)
 (setq projectile-enable-caching t)
 (setq projectile-completion-system 'grizzl)
 ;; Press Command-p for fuzzy find in project
 (global-set-key (kbd "s-p") 'projectile-find-file)
 ;; Press Command-b for fuzzy switch buffer
 (global-set-key (kbd "s-b") 'projectile-switch-to-buffer)

(require 'gist)
(setq gist-authenticate-function 'gist-basic-authentication)
(global-set-key (kbd "<f8>") 'gist-region-or-buffer)

(add-hook 'js-mode-hook 'flymake-jslint-load)
(add-hook 'css-mode-hook 'flymake-css-load)

(provide 'chris-custom)
