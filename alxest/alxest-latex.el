(provide 'alxest-latex)

;; (require 'tex-mode)`
;; (require flyspell)
;; (add-hook 'latex-mode-hook 'flyspell-mode)
(require 'tex-mode)`
(require 'flyspell)
(add-hook 'LaTeX-mode-hook #'turn-on-flyspell)
(add-hook 'latex-mode-hook #'turn-on-flyspell)


;; (add-hook 'LaTeX-mode-hook '(flyspell-mode t))
;; (add-hook 'latex-mode-hook '(flyspell-mode t))
;; (add-hook 'LaTeX-mode-hook '(lambda () (flyspell-mode t)))
;; (eval-after-load "LaTeX" '(flyspell-mode t))
;; (eval-after-load "LaTeX" '(flyspell-mode))
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
