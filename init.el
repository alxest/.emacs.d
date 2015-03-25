(add-to-list 'load-path (expand-file-name "alxest" user-emacs-directory))
(require 'alxest-package)
(require 'alxest-helm)
(require 'alxest-term)
(require 'alxest-dvorak)
(require 'alxest-misc)
(require 'alxest-multiple-cursors)
(require 'alxest-evil)
(require 'alxest-org)
(require 'alxest-company)
(require 'alxest-language)

(server-start)
;(require-package 'smartparens)
;(smartparens-global-mode t)

(global-auto-revert-mode t)
(setq-default global-auto-revert-non-file-buffers t)

(require-package 'xcscope)
(cscope-setup)


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

(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(eval-after-load "merlin"
    '(define-key merlin-mode-map (kbd "C-c C-.") 'merlin-error-reset))

; Make company aware of merlin
(add-to-list 'company-backends 'merlin-company-backend)
; Enable company on merlin managed buffers
(add-hook 'merlin-mode-hook 'company-mode)
; Or enable it globally:
; (add-hook 'after-init-hook 'global-company-mode)


(load-file "~/.emacs.d/elpa/ProofGeneral/generic/proof-site.el")
;(setq-default proof-three-window-enable t)
;(require 'coq)
;(setq coq-load-path (list "/home/youngju.song/compcert-2.4/lib"))

(setq split-width-threshold 0)
(setq split-height-threshold nil)
(setq proof-three-window-mode-policy (quote hybrid))

(eval-after-load "coq"
    '(define-key coq-mode-map (kbd "C-c C-h") 'proof-undo-last-successful-command))
;; (eval-after-load "coq"
;;     '(define-key coq-mode-map (kbd "C-c C-u") 'proof-ctxt))

