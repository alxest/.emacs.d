
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

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
(condition-case err
    ;; (set-default-font "Inconsolata 6")
    (set-default-font "Inconsolata:pixelsize=15:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true")
  (error (message "%s" (error-message-string err))))

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
;(require-package 'unbound)
;(describe-unbound-keys 5)
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
;; (let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
;;   (setenv "PATH" path)
;;   (setq exec-path 
;;         (append
;;          (split-string-and-unquote path ":")
;;          exec-path)))
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))




(require-package 'cil-mode)
(require-package 'csharp-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40")
 '(haskell-tags-on-save t)
 '(org-agenda-files (quote ("~/Orgs/main.org")))
 '(org-export-backends (quote (ascii html icalendar latex md)))
 '(package-selected-packages
   (quote
    (llvm-mode circe company-coq markdown-mode ecb sr-speedbar fsharp-mode csharp-mode cil-mode xcscope tuareg multiple-cursors merlin magit hindent helm-projectile haskell-mode evil-search-highlight-persist evil-leader ensime dictionary company-math color-theme-solarized bm)))
 '(safe-local-variable-values
   (quote
    ((TeX-master . "main")
     (eval hi-lock-face-phrase-buffer "Vundef"
           (quote hi-green-b))
     (eval hi-lock-face-phrase-buffer "Returnstate"
           (quote hi-blue-b))
     (eval hi-lock-face-phrase-buffer "Callstate"
           (quote hi-red-b))
     (coq-prog-args "-emacs-U")
     (eval flet
           ((pre
             (s)
             (concat
              (locate-dominating-file buffer-file-name ".dir-locals.el")
              s)))
           (setq coq-load-path
                 (\`
                  ((rec
                    (\,
                     (pre "."))
                    "compcert")))))
     (TeX-PDF-mode . t)
     (TeX-master . "popl")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require-package 'fsharp-mode)
(setq inferior-fsharp-program "/usr/bin/fsharpi --readline-")
(setq fsharp-compiler "/usr/bin/fsharpc")

(require-package 'sr-speedbar)
(require-package 'ecb)
(setq ecb-examples-bufferinfo-buffer-name nil)

;; (require-package 'ggtags)
;; (require-package 'setup-helm-gtags)

;; (require-package 'ycmd)
;; ;; (set-variable 'ycmd-server-command '("python" "/home/youngju.song/Research/ycmd/ycmd"))
;; (add-hook 'after-init-hook #'global-ycmd-mode)
;; ;; (add-hook 'c++-mode-hook 'ycmd-mode)
;; (setq ycmd-server-command '("python" "/home/youngju.song/Research/ycmd/ycmd"))
;; ;; (setq ycmd-server-command '("python" "/home/youngju.song/.vim/bundle/YouCompleteMe/third_party/ycmd"))
;; (add-hook 'ycmd-mode-hook
;; 										'(lambda () (local-set-key (kbd "C-c y .") 'ycmd-goto)))
;; (add-hook 'ycmd-mode-hook
;; 										'(lambda () (local-set-key (kbd "C-c y t") 'ycmd-get-type)))
;; (add-hook 'ycmd-mode-hook
;; 										'(lambda () (local-set-key (kbd "C-c y p") 'ycmd-get-parent)))
;; (add-hook 'ycmd-mode-hook
;; 										'(lambda () (local-set-key (kbd "C-c y d") 'ycmd-show-documentation)))
;; ;; (define-key ycmd-mode-map ycmd-keymap-prefix nil)
;; ;; (setq ycmd-keymap-prefix '(kbd "C-c y"))
;; ;; (define-key ycmd-mode-map ycmd-keymap-prefix
;; ;; 		ycmd-command-map)

(add-hook 'ibuffer-mode-hook
										'(lambda () (visual-line-mode 0)))

;http://emacs.stackexchange.com/questions/620/set-column-widths-in-ibuffer
(setq ibuffer-formats 
      '((mark modified read-only " "
              (name 36 36 :left :elide) ; original: 18
              " "
              (size 9 -1 :right)
              " "
              (mode 10 10 :left :elide) ; original: 16
              " " filename-and-process)
        (mark " "
              (name 16 -1)
              " " filename)))

(require-package 'markdown-mode)

(require-package 'company-coq)
;(add-hook 'coq-mode-hook #'company-coq-mode)


;https://www.emacswiki.org/emacs/NoTabs
(setq-default indent-tabs-mode nil)







(setq column-number-mode t)






;(while "a" (desktop-read))


;; (require-package 'evil-magit)
(put 'erase-buffer 'disabled nil)



 (setq company-coq-disabled-features
        '(smart-subscripts
          prettify-symbols
          snippets
          outline
          code-folding
          company-defaults
          refman-scope-abbrevs-backend
          pg-backend
          dynamic-symbols-backend
          obsolete-settings))

;fucking long loading page
(global-unset-key (kbd "C-h h"))
(tool-bar-mode -1)

;don't want to change to Korean
(global-unset-key (kbd "S-SPC"))

;coq c-p splits word with "_"; really annoying.
;http://emacs.stackexchange.com/questions/9583/how-to-treat-underscore-as-part-of-the-word
(modify-syntax-entry ?_ "w")
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
