(require-package 'company)
(require-package 'company-math)
(global-company-mode)
(add-to-list 'company-backends 'company-math-symbols-unicode)
(setq company-idle-delay 0)
(setq company-math--symbols (cons #("turnstile" 0 9 (:symbol "⊢")) company-math--symbols))
(setq company-math--symbols (cons #("doubleturnstile" 0 15 (:symbol "⊨")) company-math--symbols))
(setq company-math--symbols (cons #("conjunction" 0 11 (:symbol "∧")) company-math--symbols))
(setq company-math--symbols (cons #("disjunction" 0 11 (:symbol "∨")) company-math--symbols))


;; (add-hook 'tuareg-interactive-mode-hook
;;     '(lambda () (setq company-mode nil)))
;; (add-hook 'eshell-mode-hook
;;     '(lambda () (setq company-mode nil)))


(provide 'alxest-company)