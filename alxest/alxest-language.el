;(require-package 'llvm-mode)
(require-package 'tuareg)

(eval-after-load "tuareg"
  '(define-key tuareg-mode-map (kbd "C-c C-q") 'comment-or-uncomment-region))
(add-hook 'tuareg-interactive-mode-hook
										'(lambda () (local-set-key (kbd "C-d") 'evil-scroll-down)))

(define-key tuareg-mode-map (kbd "<backspace>") 'nil)

;https://github.com/realworldocaml/book/wiki/Installation-Instructions
;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam

;; -- Tweaks for OS X -------------------------------------
;; Tweak for problem on OS X where Emacs.app doesn't run the right
;; init scripts when invoking a sub-shell
(cond
 ((eq window-system 'ns) ; macosx
  ;; Invoke login shells, so that .profile or .bash_profile is read
  (setq shell-command-switch "-lc")))

;; (dolist
;;    (var (car (read-from-string
;;            (shell-command-to-string "source ~/.zshrc && opam config env --sexp"))))
;;  (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
          "/../../share/emacs/site-lisp") load-path)
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
;; (add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)







;; (setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
;; (add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require-package 'merlin)
;; (add-hook 'tuareg-mode-hook 'merlin-mode)


(let ((opam-share (ignore-errors (car (process-lines "opam" "config" "var" "share")))))
  (when (and opam-share (file-directory-p opam-share))
    ;; Register Merlin
    (add-to-list 'load-path (expand-file-name "emacs/site-lisp" opam-share))
    (autoload 'merlin-mode "merlin" nil t nil)
    ;; Automatically start it in OCaml buffers
    (add-hook 'tuareg-mode-hook 'merlin-mode t)
    (add-hook 'caml-mode-hook 'merlin-mode t)
    ;; Use opam switch to lookup ocamlmerlin binary
    (setq merlin-command 'opam)))

(eval-after-load "merlin"
    '(define-key merlin-mode-map (kbd "C-c C-.") 'merlin-error-reset))



(define-key merlin-mode-map
  (kbd "C-c k") 'merlin-type-enclosing-go-up)
(define-key merlin-mode-map
  (kbd "C-c j") 'merlin-type-enclosing-go-down)
(set-face-background 'merlin-type-face "#88FF44")



;; Fucked up, so slow
;; ; Make company aware of merlin
;; (add-to-list 'company-backends 'merlin-company-backend)
;; ; Enable company on merlin managed buffers
;; (add-hook 'merlin-mode-hook 'company-mode)
;; ; Or enable it globally:
;; ; (add-hook 'after-init-hook 'global-company-mode)

(add-hook 'merlin-mode-hook (lambda () (setq company-mode nil)))
(eval-after-load "merlin" '(setq company-mode nil))
(add-hook 'tuareg-mode-hook (lambda () (setq company-mode nil)))
(eval-after-load "tuareg" '(setq company-mode nil))


;; (setq merlin-locate-focus-new-window
(setq merlin-locate-in-new-window 'never)
;; Documentation:
;; Determine whether to display results of `merlin-locate' in a new window or not.
;; (defcustom merlin-locate-in-new-window 'diff
;;   "Determine whether to display results of `merlin-locate' in a new window or not."
;;   :group 'merlin :type '(choice (const :tag "Always open a new window" always)
;;                                 (const :tag "Never open a new window" never)
;;                                 (const :tag "Open a new window only if the target file is different from current buffer." diff)))


;http://tuhdo.github.io/c-ide.html
(add-hook 'c-mode-common-hook 'hs-minor-mode)


;scala modes
;(require-package 'scala-mode2)
(require-package 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(setq ensime-startup-notification nil)

;don't know why but cannot unbind M-. or rebind M-.
(add-hook 'scala-mode-hook
										'(lambda () (local-set-key (kbd "C-,") 'ensime-edit-definition)))
(setq ensime-startup-snapshot-notification nil)
(add-to-list 'auto-mode-alist '("\\.atd\\'" . tuareg-mode))

;https://github.com/serras/emacs-haskell-tutorial/blob/master/tutorial.md
(require-package 'haskell-mode)
(require-package 'hindent)
(add-hook 'haskell-mode-hook #'hindent-mode)
(let ((my-cabal-path (expand-file-name "~/.cabal/bin")))
  (setenv "PATH" (concat my-cabal-path path-separator (getenv "PATH")))
  (add-to-list 'exec-path my-cabal-path))
(custom-set-variables '(haskell-tags-on-save t))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map (kbd "C-c C-o") 'haskell-compile))
(eval-after-load 'haskell-cabal
  '(define-key haskell-cabal-mode-map (kbd "C-c C-o") 'haskell-compile))




;copied from https://github.com/rust-lang/rust-mode
(require-package 'rust-mode)
(setq rust-format-on-save nil)

(require-package 'racer)
;copied from https://github.com/racer-rust/emacs-racer
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
;; (add-hook 'racer-mode-hook #'company-mode)
(add-hook 'racer-mode-hook (lambda () (setq company-mode nil)))

(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(define-key rust-mode-map (kbd "C-c d") #'racer-describe-tooltip)
(define-key rust-mode-map (kbd "C-c D") #'racer-describe)
(setq company-tooltip-align-annotations t)




;https://github.com/ananthakumaran/tide
(require-package 'tide)
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)



;http://stackoverflow.com/questions/26603649/haskell-repl-in-emacs
(provide 'alxest-language)
