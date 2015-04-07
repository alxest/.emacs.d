(require-package 'term)
(require-package 'multi-term)

(setq multi-term-program "/bin/zsh")
;; (setq multi-term-program"/usr/bin/bash")
(global-set-key (kbd "C-}") 'multi-term-next)
(global-set-key (kbd "C-{") 'multi-term-prev)
(global-set-key (kbd "C-c C-z") 'multi-term)

(defun term-toggle-mode ()
  (interactive)
  (if (term-in-line-mode) 
      (term-char-mode)
      (term-line-mode)))
(add-hook 'term-mode-hook
          (lambda () (local-set-key (kbd "C-c C-t") #'term-toggle-mode)))
(setq term-bind-key-alist
      (append term-bind-key-alist
        (list
         (cons "C-v" 'scroll-up-command)
         (cons "C-c C-t" 'term-toggle-mode)
         (cons "C-l" 'recenter-top-bottom))))

(setq scroll-conservatively 101)
(setq scroll-preserve-screen-position t)
(setq term-scroll-snap-to-bottom nil)

(global-set-key (kbd "M-z") 'eshell)
(add-hook 'term-mode-hook
          (lambda () (local-set-key (kbd "RET") #'term-send-return)))

(provide 'alxest-term)
