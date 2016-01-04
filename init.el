(add-to-list 'load-path (expand-file-name "alxest" user-emacs-directory))
(require 'alxest-package)
(require 'alxest-helm)
;(require 'alxest-term)
(require 'alxest-eshell)
(require 'alxest-dvorak)
(require 'alxest-misc)
(require 'alxest-multiple-cursors)
(require 'alxest-evil)
(require 'alxest-org)
(require 'alxest-company)
(require 'alxest-language)
(require 'alxest-coq)

(server-force-delete)
(server-start)
;(require-package 'smartparens)
;(smartparens-global-mode t)

(global-auto-revert-mode t)
(setq-default global-auto-revert-non-file-buffers t)

(require-package 'xcscope)
(cscope-setup)
(setq mac-command-modifier 'meta)

;; fonts
; describe-font
; Options-Set default fonts
; (set-default-font "Inconsolata:pixelsize=18:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true")
(set-default-font "Inconsolata 14")

;(setenv "PATH" (concat "~/.local/coq8.4pl5/bin:" (getenv "PATH")))
;(require-package 'unicode-fonts)
;(unicode-fonts-setup)

;http://www.emacswiki.org/emacs/NavigatingParentheses
  ;; C-M-n     forward-list  Move forward over a parenthetical group 

  ;; C-M-p     backward-list  Move backward over a parenthetical group 

  ;; C-M-f     forward-sexp Move forward over a balanced expression

  ;; C-M-b     backward-sexp  Move backward over a balanced expression

  ;; C-M-k     kill-sexp  Kill balanced expression forward

  ;; C-M-SPC   mark-sexp  Put the mark at the end of the sexp.
;; Emulation of the vi % command

;; This code from http://emacro.sourceforge.net/ gives a vi-like way of moving over parenthesis groups. I bind it to C-%, from vi heritage.

;; (defun goto-match-paren (arg)
;;   "Go to the matching parenthesis if on parenthesis, otherwise insert %.
;; vi style of % jumping to matching brace."
;;   (interactive "p")
;;   (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
;;         ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
;;         (t (self-insert-command (or arg 1)))))


;only when X forwarding is slow
;(setq transient-mark-mode nil)

(global-set-key (kbd "C-x g") 'magit-status)

(add-hook 'ibuffer-mode-hook 
    '(lambda ()
       (local-set-key (kbd "j") 'ibuffer-forward-line)))
(eval-after-load "ibuffer"
    '(define-key ibuffer-mode-map (kbd "k") 'ibuffer-backward-line))



;http://emacsredux.com/blog/2013/05/09/keep-backup-and-auto-save-files-out-of-the-way/
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;http://stackoverflow.com/questions/151945/how-do-i-control-how-emacs-makes-backup-files
;; (setq backup-directory-alist '(("." . "~/.saves")))
;; (setq backup-by-copying t)
;; (setq delete-old-versions t
;;   kept-new-versions 6
;;   kept-old-versions 2
;;   version-control t)

(setq tuareg-begin-indent 0)
(setq default-tab-width 1) 
;in tuareg mode, C-? does not mark proper position, because it counts tab as single character



(setq split-width-threshold 0)
(setq split-height-threshold nil)
(setq proof-three-window-mode-policy (quote hybrid))

;; (require-package 'magit)
;; (setq magit-auto-revert-mode nil)
;; Warning (:warning): for magit-1.4.0

;; You have just updated to version 1.4.0 of Magit, and have to
;; make a choice.

;; Before running Git, Magit by default reverts all unmodified
;; buffers which visit files tracked in the current repository.
;; This can potentially lead to dataloss so you might want to
;; disable this by adding the following line to your init file:


(add-hook 'eshell-mode-hook '(lambda () (setq company-mode nil)))
(require-package 'unbound)
(describe-unbound-keys 5)
(global-set-key (kbd "C-c C-r") 'revert-buffer)


;; http://stackoverflow.com/questions/21005885/export-org-mode-code-block-and-result-with-different-styles
;; this code makes below code not working..
;; (require 'ox-latex)
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))


;http://stackoverflow.com/questions/9435019/how-do-i-source-my-zshrc-within-emacs
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))







(require-package 'cil-mode)
(require-package 'csharp-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(safe-local-variable-values (quote ((TeX-PDF-mode . t) (TeX-master . "popl")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require-package 'fsharp-mode)
(setq inferior-fsharp-program "/usr/bin/fsharpi --readline-")
(setq fsharp-compiler "/usr/bin/fsharpc")

;; (require-package 'sr-speedbar)
;; (require-package 'ecb)
;; (setq ecb-examples-bufferinfo-buffer-name nil)

;; (require-package 'ggtags)
;; (require-package 'setup-helm-gtags)

(require-package 'ycmd)
;; (set-variable 'ycmd-server-command '("python" "/home/youngju.song/Research/ycmd/ycmd"))
(add-hook 'after-init-hook #'global-ycmd-mode)
;; (add-hook 'c++-mode-hook 'ycmd-mode)
(setq ycmd-server-command '("python" "/home/youngju.song/Research/ycmd/ycmd"))
