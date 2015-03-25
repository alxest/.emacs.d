(require-package 'evil)
(evil-mode 1)
(global-set-key "\M-d" 'evil-scroll-up)
(global-set-key "\C-u" 'evil-scroll-up)

(global-set-key "\C-x\C-n" 'next-buffer)
(global-set-key "\C-x\C-p" 'previous-buffer)


(provide 'alxest-evil)
