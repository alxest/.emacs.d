(require-package 'org)
;http://randomgeekery.org/emacs/2014/05/16_exporting-from-org-to-markdown.html 
(custom-set-variables
 '(org-export-backends (quote (ascii html icalendar latex md))))



(require-package 'evil-leader)
(global-evil-leader-mode)



(add-to-list 'load-path "~/.emacs.d/plugins/evil-org-mode")
(require-package 'evil-org)
(add-hook 'org-mode-hook 'evil-org-mode)
(evil-org-set-key-theme '(navigation insert textobjects additional calendar))
(require 'evil-org-agenda)
(evil-org-agenda-set-keys)


;http://tonyballantyne.com/tech/elpa-org-mode-and-invalid-function-org-with-silent-modifications/
;re installed following above instruction

;https://lists.gnu.org/archive/html/emacs-orgmode/2013-04/msg01119.html
(require 'org)
;(define-key org-agenda-mode-map "j" 'evil-next-line)
;(define-key org-agenda-mode-map "k" 'evil-previous-line)



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

;; (add-hook 'org-mode-hook 
;;           (lambda ()
;;             (local-set-key (kbd "S-SPC") 'ded/org-show-previous-heading-tidily)))
;; (eval-after-load "org"
;;     '(progn
;;        (define-key org-mode-map (kbd "M-RET") nil)
;;        (local-unset-key (kbd "M-RET"))
;;        (local-set-key (kbd "M-RET") 'ded/outline-previous-visible-heading)
;;        (define-key org-mode-map (kbd "M-RET") 'ded/outline-previous-visible-heading)))
;; (org-defkey org-mode-map [(meta return)] 'ded/outline-previous-visible-heading)

;; (global-set-key "\M-=" 'org-show-current-heading-tidily)


;; http://emacs.stackexchange.com/questions/14500/unbind-c-ret-in-emacs
;; http://stackoverflow.com/questions/13720898/emacs-how-can-i-display-only-current-task-and-hide-others-in-org-mode
;; org default function; it is also in org manual
;; (define-key org-mode-map [M-return] 'org-narrow-to-subtree)
;; (define-key org-mode-map (kbd "M-*") 'widen)



;http://emacs.stackexchange.com/questions/2237/show-siblings-of-visible-headers-after-hide-other
;not sure this is needed
;I may just test with narrow/widen + evil-org-mode's gh/j/k/l
(defun outline-focus ()
  "Hide everything except for the current body and the parent headings.
Unlike `hide-other' since Emacs 20, this function shows all siblings
of visible headers."
  (interactive)
  (hide-sublevels 1)
  (let (outline-view-change-hook)
    (save-excursion
      (outline-back-to-heading t)
      (show-entry)
      (while (condition-case nil (progn (outline-up-heading 1 t) (not (bobp)))
               (error nil))
        (show-children))))
  (run-hooks 'outline-view-change-hook))

;https://github.com/edwtjo/evil-org-mode/blob/master/evil-org.el
(evil-define-key 'normal evil-org-mode-map
  "H" 'outline-up-heading
  "P" 'outline-previous-heading
  "J" (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
	   'org-forward-same-level
	  'org-forward-heading-same-level)
  "K" (if (fboundp 'org-backward-same-level)
	   'org-backward-same-level
	  'org-backward-heading-same-level)
  "L" 'outline-next-visible-heading
  "gh" 'org-shiftleft
  "gj" 'org-shiftdown
  "gk" 'org-shiftup
  "gl" 'org-shiftright
  ;; originally, below two was defined as "define-key org-mode-map", but I moved to here
  ;; I only want M-return to narrow subtree in normal mode.
  ;; In edit mode, I want it to invoke org-meta-ret
  [M-return] 'org-narrow-to-subtree
  "M-*" 'widen)

;; below does not work, even with "eval-after-load" blah
;; it seems it's because that first emacs loads the mode, and then "eval-after-load" is executed, and then key binding is overwritten
;; (define-key evil-org-mode-map (kbd "H") 'outline-up-heading)
;; (define-key evil-org-mode-map (kbd "J") 'org-forward-heading-same-level)
;; (define-key evil-org-mode-map (kbd "K") 'org-backward-heading-same-level)
;; (define-key evil-org-mode-map (kbd "L") 'outline-next-visible-heading)

;; (define-key evil-org-mode-map (kbd "g-h") 'org-shiftleft)
;; (define-key evil-org-mode-map (kbd "g-j") 'org-shiftdown)
;; (define-key evil-org-mode-map (kbd "g-k") 'org-shiftup)
;; (define-key evil-org-mode-map (kbd "g-l") 'org-shiftright)

(add-hook 'org-mode-hook (lambda () (setq fill-column 100)))
;list-faces-display
;https://stackoverflow.com/questions/50816812/how-to-set-emacs-line-color-based-on-start-character
(add-hook 'org-mode-hook (lambda () (highlight-regexp "^#.*$" (quote custom-comment))))
;; (add-hook 'org-mode-hook (lambda () (highlight-regexp "^#.*$" (quote hi-green))))
;; (add-hook 'org-mode-hook (lambda () (highlight-regexp "^#.*$" (quote company-tooltip-annotation))))
;; (add-hook 'org-mode-hook (lambda () (highlight-regexp "^#g.*$" (quote diff-refine-changed))))
;; (add-hook 'org-mode-hook (lambda () (highlight-regexp "^#r.*$" (quote diff-refine-removed))))
(add-hook 'org-mode-hook (lambda () (highlight-regexp "^.*`b$" (quote caml-types-scope-face))))
(add-hook 'org-mode-hook (lambda () (highlight-regexp "^.*`r$" (quote helm-buffer-saved-out))))
(add-hook 'org-mode-hook (lambda () (highlight-regexp "^.*`g$" (quote caml-types-expr-face))))
(add-hook 'org-mode-hook (lambda () (highlight-regexp "^.*`y$" (quote proof-command-mouse-highlight-face))))

(define-key org-mode-map (kbd "C-c C-r") 'revert-buffer)
(define-key org-mode-map (kbd "M-{") '(lambda nil (interactive) (other-window -1)))
(define-key org-mode-map (kbd "M-}") '(lambda nil (interactive) (other-window 1)))

;(font-lock-add-keywords 'org-mode "★")

(provide 'alxest-org)
