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

(require-package 'magit)
(setq magit-auto-revert-mode nil)
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

(require-package 'evil-search-highlight-persist)
(evil-search-highlight-persist)
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(org-export-backends (quote (ascii html icalendar latex md)))
;;  '(safe-local-variable-values (quote ((eval flet ((pre (s) (concat (locate-dominating-file buffer-file-name ".dir-locals.el") s))) (setq coq-load-path (\` nil))) (eval flet ((pre (s) (concat (locate-dominating-file buffer-file-name ".dir-locals.el") s))) (setq coq-load-path (\` ((\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/src/Vellvm") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/src/Vellvm/ott") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/src/Vellvm/Dominators") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/compcert-1.9") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/cpdtlib") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/GraphBasics") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/metalib-20090714") (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/Coq-Equations-8.4/src") (rec (\, "/home/youngju.song/coq_related/vellvm-legacy-snu-sf/lib/Coq-Equations-8.4/theories") "Equations"))))) (coq-prog-args "-emacs-U" "-impredicative-set") (eval flet ((pre (s) (concat (locate-dominating-file buffer-file-name ".dir-locals.el") s))) (setq coq-load-path (\` ((\, (pre "src/Vellvm")) (\, (pre "src/Vellvm/ott")) (\, (pre "src/Vellvm/Dominators")) (\, (pre "lib/compcert-1.9")) (\, (pre "lib/cpdtlib")) (\, (pre "lib/GraphBasics")) (\, (pre "lib/metalib-20090714")) (\, (pre "lib/Coq-Equations-8.4/src")) (rec (\, (pre "lib/Coq-Equations-8.4/theories")) "Equations")))))))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
