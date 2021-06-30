(provide 'alxest-latex)

;; (require 'tex-mode)`
;; (require flyspell)
;; (add-hook 'latex-mode-hook 'flyspell-mode)
(require 'tex-mode)`
(require 'flyspell)
(add-hook 'LaTeX-mode-hook #'turn-on-flyspell)
(add-hook 'latex-mode-hook #'turn-on-flyspell)

(add-hook 'latex-mode-hook (lambda () (setq fill-column 93)))


(defun my-latex-compile () (shell-command "./run.sh&" "*My Latex Compile*"))
(define-key latex-mode-map (kbd "M-c") #'(lambda () (interactive)
                                               (progn (message "compiling...")
                                                      (my-latex-compile))))
(add-to-list 'display-buffer-alist '("*My Latex Compile*" display-buffer-no-window (nil)))

;; (add-hook 'LaTeX-mode-hook '(flyspell-mode t))
;; (add-hook 'latex-mode-hook '(flyspell-mode t))
;; (add-hook 'LaTeX-mode-hook '(lambda () (flyspell-mode t)))
;; (eval-after-load "LaTeX" '(flyspell-mode t))
;; (eval-after-load "LaTeX" '(flyspell-mode))
;; (add-hook 'LaTeX-mode-hook 'flyspell-mode)
