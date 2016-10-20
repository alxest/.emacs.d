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

(provide 'alxest-org)
