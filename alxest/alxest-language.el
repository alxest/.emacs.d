(require-package 'llvm-mode)
(require-package 'tuareg)

(eval-after-load "tuareg"
  '(define-key tuareg-mode-map (kbd "C-c C-q") 'comment-or-uncomment-region))

(provide 'alxest-language)
