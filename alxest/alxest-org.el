(require-package 'org)
;http://randomgeekery.org/emacs/2014/05/16_exporting-from-org-to-markdown.html 
(custom-set-variables
 '(org-export-backends (quote (ascii html icalendar latex md))))



(require-package 'evil-leader)
(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require 'evil-org) ; not installed from package manager. https://github.com/edwtjo/evil-org-mode
; official guide says this way, also it does not work when installed with package manager
(global-evil-leader-mode)


;http://tonyballantyne.com/tech/elpa-org-mode-and-invalid-function-org-with-silent-modifications/
;re installed following above instruction

;https://lists.gnu.org/archive/html/emacs-orgmode/2013-04/msg01119.html
(require 'org)
(require 'org-agenda)
(define-key org-agenda-mode-map "j" 'evil-next-line)
(define-key org-agenda-mode-map "k" 'evil-previous-line)



;http://stackoverflow.com/questions/25161792/emacs-org-mode-how-can-i-fold-everything-but-the-current-headline
(defun ded/org-show-next-heading-tidily ()
  "Show next entry, keeping other entries closed."
  (interactive)
  (if (save-excursion (end-of-line) (outline-invisible-p))
      (progn (org-show-entry) (show-children))
    (outline-next-heading)
    (unless (and (bolp) (org-on-heading-p))
      (org-up-heading-safe)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (recenter-top-bottom)
    (show-children)
    (evil-scroll-line-to-top ()) ;vi - zz, zt, zb
    ;; (recenter-top-bottom)
    ))

(defun ded/org-show-previous-heading-tidily ()
  "Show previous entry, keeping other entries closed."
  (interactive)
  (let ((pos (point)))
    (outline-previous-heading)
    (unless (and (< (point) pos) (bolp) (org-on-heading-p))
      (goto-char pos)
      (hide-subtree)
      (error "Boundary reached"))
    (org-overview)
    (org-reveal t)
    (org-show-entry)
    (recenter-top-bottom)
    (show-children)
    ;; (recenter-top-bottom)
    (evil-scroll-line-to-top ()) ;vi - zz, zt, zb
    ))

(add-hook 'org-mode-hook 
          (lambda ()
            (local-set-key (kbd "S-SPC") 'ded/org-show-previous-heading-tidily)))
;; (eval-after-load "org"
;;     '(progn
;;        (define-key org-mode-map (kbd "M-RET") nil)
;;        (local-unset-key (kbd "M-RET"))
;;        (local-set-key (kbd "M-RET") 'ded/outline-previous-visible-heading)
;;        (define-key org-mode-map (kbd "M-RET") 'ded/outline-previous-visible-heading)))
;; (org-defkey org-mode-map [(meta return)] 'ded/outline-previous-visible-heading)

;; (global-set-key "\M-=" 'org-show-current-heading-tidily)






(provide 'alxest-org)
