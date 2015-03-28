(require-package 'llvm-mode)
(require-package 'tuareg)

(eval-after-load "tuareg"
  '(define-key tuareg-mode-map (kbd "C-c C-q") 'comment-or-uncomment-region))
(add-hook 'tuareg-interactive-mode-hook
										'(lambda () (local-set-key (kbd "C-d") 'evil-scroll-down)))

;https://github.com/realworldocaml/book/wiki/Installation-Instructions
;; -- opam and utop setup --------------------------------
;; Setup environment variables using opam
(dolist
   (var (car (read-from-string
           (shell-command-to-string "opam config env --sexp"))))
 (setenv (car var) (cadr var)))
;; Update the emacs path
(setq exec-path (split-string (getenv "PATH") path-separator))
;; Update the emacs load path
(push (concat (getenv "OCAML_TOPLEVEL_PATH")
          "/../../share/emacs/site-lisp") load-path)
;; Automatically load utop.el
(autoload 'utop "utop" "Toplevel for OCaml" t)
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)







(setq opam-share (substring (shell-command-to-string "opam config var share 2> /dev/null") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(eval-after-load "merlin"
    '(define-key merlin-mode-map (kbd "C-c C-.") 'merlin-error-reset))



(define-key merlin-mode-map
  (kbd "C-c k") 'merlin-type-enclosing-go-up)
(define-key merlin-mode-map
  (kbd "C-c j") 'merlin-type-enclosing-go-down)
(set-face-background 'merlin-type-face "#88FF44")



; Make company aware of merlin
(add-to-list 'company-backends 'merlin-company-backend)
; Enable company on merlin managed buffers
(add-hook 'merlin-mode-hook 'company-mode)
; Or enable it globally:
; (add-hook 'after-init-hook 'global-company-mode)


(provide 'alxest-language)